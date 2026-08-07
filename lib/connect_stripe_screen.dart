import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_trade_pal/auth/supabase_auth/auth_util.dart';
import 'package:my_trade_pal/core/theme/app_theme.dart';
import 'package:my_trade_pal/models/structs/index.dart';
import 'package:my_trade_pal/repositories/api_requests/api_calls.dart';
import 'package:my_trade_pal/utils/util.dart';
import 'package:my_trade_pal/widgets/app_button.dart';
import 'package:my_trade_pal/widgets/app_icon_button.dart';
import 'package:my_trade_pal/widgets/components/appbar_component/appbar_component_widget.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '/utils/custom_code/actions/index.dart' as actions;

class ConnectStripeScreen extends StatefulWidget {
  const ConnectStripeScreen({
    super.key,
    required this.onConnectStripe,
    required this.onManagePayouts,
  });
  static String routeName = 'connect_stripe';

  final Future<void> Function() onConnectStripe;
  final Future<void> Function() onManagePayouts;
  @override
  State<ConnectStripeScreen> createState() => _ConnectStripeScreenState();
}

class _ConnectStripeScreenState extends State<ConnectStripeScreen>
    with WidgetsBindingObserver {
  bool hasStripeAccount = false;
  bool payoutsEnabled = false;
  bool chargesEnabled = false;
  bool isLoading = true;
  bool isLoadingBalance = false;

  int? availableBalance;
  int? pendingBalance;
  String balanceCurrency = 'gbp';

  bool isLoadingBankAccount = false;
  BankDetailsStruct? defaultBankAccount;

  dynamic stripeRow;
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addObserver(this);

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await _subscribeStripeAccount();
      await _loadStripeAccount();
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    actions.unsubscribe('stripe_accounts');
    super.dispose();
  }

  Future<void> _subscribeStripeAccount() async {
    print("=== STARTING SUBSCRIBE ===");
    await actions.subscribe(
      'stripe_accounts',
      'user_id',
      currentUserUid,
      'update',
      () async {
        print("===== REALTIME CALLBACK FIRED =====");
        await _loadStripeAccount();
        debugPrint("Stripe account updated.");
      },
    );
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    if (state == AppLifecycleState.resumed) {
      debugPrint("App resumed. Reloading Stripe account...");
      await _loadStripeAccount();
    }
  }

  Future<void> _loadStripeAccount() async {
    debugPrint(
        '[PayoutDebug] _loadStripeAccount: currentUserUid=$currentUserUid');

    final response = await SupabaseTablesGroup.getStripeRowCall
        .call(userId: 'eq.$currentUserUid');

    debugPrint(
        '[PayoutDebug] getStripeRowCall: succeeded=${response.succeeded} statusCode=${response.statusCode} body=${response.bodyText}');

    if (!response.succeeded) {
      if (!mounted) return;
      setState(() => isLoading = false);
      return;
    }

    final rows = getJsonField(response.jsonBody, r'$');
    debugPrint(
        '[PayoutDebug] rows type=${rows.runtimeType} isList=${rows is List} length=${rows is List ? rows.length : 'n/a'}');

    if (rows is List && rows.isNotEmpty) {
      // A user can end up with more than one stripe_accounts row (e.g. a
      // double-tapped "Connect Stripe" creating two Stripe accounts). Prefer
      // the fully onboarded one instead of blindly taking the first row,
      // which could be a stale/incomplete duplicate.
      stripeRow = rows.firstWhere(
        (r) => (r['payouts_enabled'] == true) && (r['charges_enabled'] == true),
        orElse: () => rows.firstWhere(
          (r) => (r['stripe_account_id'] ?? '').toString().isNotEmpty,
          orElse: () => rows.first,
        ),
      );

      debugPrint('[PayoutDebug] chosen stripeRow=$stripeRow');

      if (!mounted) return;

      setState(() {
        final stripeAccountId = stripeRow['stripe_account_id'] ?? '';

        hasStripeAccount = stripeAccountId.toString().isNotEmpty;

        payoutsEnabled = stripeRow['payouts_enabled'] ?? false;

        chargesEnabled = stripeRow['charges_enabled'] ?? false;

        isLoading = false;
      });

      debugPrint(
          '[PayoutDebug] hasStripeAccount=$hasStripeAccount payoutsEnabled=$payoutsEnabled chargesEnabled=$chargesEnabled');

      // Balance/bank account aren't shown until the account is verified
      // (see build()), so don't bother fetching them until then either.
      if (hasStripeAccount && chargesEnabled) {
        final stripeAccountId = stripeRow['stripe_account_id'].toString();
        debugPrint(
            '[PayoutDebug] loading balance + bank account for stripeAccountId=$stripeAccountId');
        await Future.wait([
          _loadBalance(),
          _loadDefaultBankAccount(stripeAccountId),
        ]);
      }
    } else {
      debugPrint('[PayoutDebug] no stripe_accounts rows found for this user');
      if (!mounted) return;

      setState(() {
        stripeRow = null;
        hasStripeAccount = false;
        payoutsEnabled = false;
        chargesEnabled = false;
        availableBalance = null;
        pendingBalance = null;
        defaultBankAccount = null;
        isLoading = false;
      });
    }
  }

  Future<void> _loadDefaultBankAccount(String stripeAccountId) async {
    if (!mounted) return;
    setState(() => isLoadingBankAccount = true);
    debugPrint(
        '[PayoutDebug] _loadDefaultBankAccount: calling get-bankAccounts with accountId=$stripeAccountId');

    try {
      final response = await SupabaseEdgeFunctionsGroup.getBankAccDetailsCall
          .call(accountId: stripeAccountId);

      debugPrint(
          '[PayoutDebug] get-bankAccounts: succeeded=${response.succeeded} statusCode=${response.statusCode} body=${response.bodyText}');

      // Note: jsonBody is `dynamic`, so this whole chain is dynamically
      // dispatched. `whereType<T>()` is a real Iterable method (unlike the
      // `withoutNulls` extension, which can't be resolved through a dynamic
      // receiver and throws NoSuchMethodError at runtime). The explicit
      // `List<BankDetailsStruct>` annotation is also required: without it,
      // `accounts` would infer type `dynamic` (the ternary's true-branch is
      // dynamic), and calling the `firstWhereOrNull` extension below would
      // fail the same way even though the runtime object is a proper List.
      final List<BankDetailsStruct> accounts = response.succeeded
          ? (response.jsonBody ?? '')
              .toList()
              .map<BankDetailsStruct?>(BankDetailsStruct.maybeFromMap)
              .whereType<BankDetailsStruct>()
              .toList()
          : <BankDetailsStruct>[];

      debugPrint('[PayoutDebug] parsed ${accounts.length} bank account(s)');

      if (!mounted) return;
      setState(() {
        // A connected account can hold a separate "default" bank account per
        // currency (e.g. one for GBP, one for EUR) — `defaultForCurrency` is
        // per-currency, not a single overall default. Since this app only
        // operates in GBP, prefer the GBP account explicitly rather than
        // whichever currency's default Stripe happens to return first.
        defaultBankAccount = accounts.isEmpty
            ? null
            : (accounts.firstWhereOrNull(
                  (a) =>
                      a.defaultForCurrency && a.currency.toLowerCase() == 'gbp',
                ) ??
                accounts.firstWhereOrNull((a) => a.defaultForCurrency) ??
                accounts.first);
      });

      debugPrint(
          '[PayoutDebug] defaultBankAccount=${defaultBankAccount?.toMap()}');
    } catch (e, s) {
      debugPrint('[PayoutDebug] EXCEPTION in _loadDefaultBankAccount: $e\n$s');
      if (!mounted) return;
      setState(() => defaultBankAccount = null);
    } finally {
      if (mounted) {
        setState(() => isLoadingBankAccount = false);
      }
    }
  }

  Future<void> _loadBalance() async {
    if (!mounted) return;
    setState(() => isLoadingBalance = true);

    try {
      final response =
          await SupabaseEdgeFunctionsGroup.getStripeBalanceCall.call(
        userId: currentUserUid,
      );

      final success = response.succeeded &&
          (SupabaseEdgeFunctionsGroup.getStripeBalanceCall
                  .success(response.jsonBody) ==
              true);

      if (!success) {
        debugPrint('get_stripe_balance failed: ${response.bodyText}');
      }

      if (!mounted) return;
      setState(() {
        if (success) {
          availableBalance = SupabaseEdgeFunctionsGroup.getStripeBalanceCall
              .available(response.jsonBody);
          pendingBalance = SupabaseEdgeFunctionsGroup.getStripeBalanceCall
              .pending(response.jsonBody);
          balanceCurrency = SupabaseEdgeFunctionsGroup.getStripeBalanceCall
                  .currency(response.jsonBody) ??
              'gbp';
        } else {
          availableBalance = null;
          pendingBalance = null;
        }
      });
    } catch (e, s) {
      debugPrint('Failed to load Stripe balance: $e\n$s');
      if (!mounted) return;
      setState(() {
        availableBalance = null;
        pendingBalance = null;
      });
    } finally {
      if (mounted) {
        setState(() => isLoadingBalance = false);
      }
    }
  }

  String _currencySymbol(String currency) {
    switch (currency.toLowerCase()) {
      case 'usd':
        return '\$';
      case 'eur':
        return '€';
      case 'gbp':
      default:
        return '£';
    }
  }

  String _formatMinorUnits(int minorUnits) {
    return NumberFormat('#,##0.00', 'en_GB').format(minorUnits / 100);
  }

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context);
    // Only celebrate once Stripe has actually verified the account — an
    // account row can exist (e.g. the user started onboarding and backed
    // out immediately) without charges/payouts ever being enabled.
    final heroGradient = chargesEnabled
        ? [theme.success, const Color(0xFF15803D)]
        : [theme.primary, const Color(0xFF173C98)];

    return Scaffold(
      backgroundColor: theme.primaryBackground,
      appBar: AppBar(
        backgroundColor: theme.primaryBackground,
        automaticallyImplyLeading: false,
        // AppbarComponentWidget's own back button relies on the app's
        // GoRouter route stack, which doesn't see this screen (it's pushed
        // via a plain Navigator.push), so it never shows. Add a themed one
        // here instead, driven by the real Navigator stack.
        leading: Navigator.canPop(context)
            ? AppIconButton(
                borderRadius: 8.0,
                buttonSize: 40.0,
                icon: FaIcon(
                  FontAwesomeIcons.chevronLeft,
                  color: theme.primaryText,
                  size: 24.0,
                ),
                onPressed: () => Navigator.of(context).pop(),
              )
            : null,
        title: AppbarComponentWidget(
          title: 'Payments & Payouts',
          showAction: false,
          actionIcon: null,
          action: () async {},
        ),
      ),
      body: Skeletonizer(
        enabled: isLoading,
        child: RefreshIndicator(
          onRefresh: _loadStripeAccount,
          color: theme.primary,
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _heroCard(theme, heroGradient),
                const SizedBox(height: 22),
                if (hasStripeAccount) ...[
                  // Balances/payout details are only meaningful once Stripe
                  // has actually verified the account — showing "£0.00" next
                  // to "Setup incomplete" reads as broken, not empty.
                  if (chargesEnabled) ...[
                    _fundsCard(theme),
                    const SizedBox(height: 16),
                    _payoutAccountCard(theme),
                    const SizedBox(height: 22),
                  ],
                  _sectionLabel('Account Status'),
                  const SizedBox(height: 12),
                  _statusTile(
                    theme: theme,
                    icon: Icons.account_balance_rounded,
                    title: 'Stripe Account',
                    subtitle: chargesEnabled
                        ? 'Linked and verified'
                        : 'Setup incomplete',
                    active: chargesEnabled,
                  ),
                  const SizedBox(height: 12),
                  _statusTile(
                    theme: theme,
                    icon: Icons.payments_rounded,
                    title: 'Payouts',
                    subtitle: payoutsEnabled
                        ? 'Ready to receive transfers'
                        : 'Awaiting Stripe verification',
                    active: payoutsEnabled,
                  ),
                ] else ...[
                  _sectionLabel('Why connect Stripe?'),
                  const SizedBox(height: 12),
                  _featureTile(
                    theme: theme,
                    icon: Icons.lock_rounded,
                    title: 'Secure payments',
                    subtitle:
                        'Every transaction is encrypted and PCI-compliant.',
                  ),
                  const SizedBox(height: 10),
                  _featureTile(
                    theme: theme,
                    icon: Icons.verified_user_rounded,
                    title: 'Identity verification',
                    subtitle: 'Quick, guided verification through Stripe.',
                  ),
                  const SizedBox(height: 10),
                  _featureTile(
                    theme: theme,
                    icon: Icons.shield_rounded,
                    title: 'Bank account protection',
                    subtitle: 'Your bank details are never stored by us.',
                  ),
                  const SizedBox(height: 10),
                  _featureTile(
                    theme: theme,
                    icon: Icons.bolt_rounded,
                    title: 'Direct payouts',
                    subtitle: 'Get paid straight to your bank account.',
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        top: false,
        child: Container(
          padding: const EdgeInsets.fromLTRB(20, 14, 20, 14),
          decoration: BoxDecoration(
            color: theme.secondaryBackground,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.06),
                blurRadius: 16,
                offset: const Offset(0, -4),
              ),
            ],
          ),
          child: SizedBox(
            width: double.infinity,
            child: AppButton(
              onPressed: hasStripeAccount
                  ? () async {
                      await widget.onManagePayouts();
                      // The onboarding/dashboard webview has just closed —
                      // re-fetch rather than waiting on the realtime
                      // subscription, which can lag behind Stripe's
                      // account.updated webhook.
                      await _loadStripeAccount();
                    }
                  : () async {
                      await widget.onConnectStripe();
                      await _loadStripeAccount();
                    },
              text: hasStripeAccount ? 'Manage Payouts' : 'Connect Stripe',
              icon: Icon(
                hasStripeAccount
                    ? Icons.settings_rounded
                    : Icons.arrow_forward_rounded,
                size: 20,
                color: Colors.white,
              ),
              options: AppButtonOptions(
                width: double.infinity,
                height: 54.0,
                padding:
                    const EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 20.0, 0.0),
                iconAlignment: IconAlignment.end,
                iconPadding:
                    const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                color: theme.primary,
                textStyle: theme.titleSmall.override(
                  font: GoogleFonts.inter(
                    fontWeight: theme.titleSmall.fontWeight,
                    fontStyle: theme.titleSmall.fontStyle,
                  ),
                  color: Colors.white,
                  letterSpacing: 0.0,
                  fontWeight: theme.titleSmall.fontWeight,
                  fontStyle: theme.titleSmall.fontStyle,
                ),
                elevation: 0.0,
                borderRadius:
                    BorderRadius.circular(theme.designToken.radius.lg + 8),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _heroCard(AppTheme theme, List<Color> gradient) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(26),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(26),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: gradient,
        ),
        boxShadow: [
          BoxShadow(
            color: gradient.first.withOpacity(0.35),
            blurRadius: 28,
            spreadRadius: -6,
            offset: const Offset(0, 16),
          ),
        ],
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            top: -50,
            right: -30,
            child: Container(
              width: 140,
              height: 140,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(0.08),
              ),
            ),
          ),
          Positioned(
            bottom: -60,
            left: -40,
            child: Container(
              width: 160,
              height: 160,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(0.05),
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.16),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      chargesEnabled
                          ? Icons.verified_rounded
                          : Icons.account_balance_wallet_rounded,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                  if (chargesEnabled)
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.18),
                        borderRadius: BorderRadius.circular(999),
                      ),
                      child: const Text(
                        'CONNECTED',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.6,
                        ),
                      ),
                    )
                  else if (hasStripeAccount)
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.18),
                        borderRadius: BorderRadius.circular(999),
                      ),
                      child: const Text(
                        'INCOMPLETE',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.6,
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 20),
              Text(
                chargesEnabled
                    ? 'Stripe Connected'
                    : hasStripeAccount
                        ? 'Finish setting up your payouts'
                        : 'Set up your payouts',
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                chargesEnabled
                    ? 'Manage your payout methods, bank account, and verification details.'
                    : hasStripeAccount
                        ? 'Complete your Stripe onboarding to start receiving payments.'
                        : 'Connect Stripe to receive payments from customers securely.',
                style: TextStyle(
                  color: Colors.white.withOpacity(0.85),
                  fontSize: 14,
                  height: 1.4,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _fundsCard(AppTheme theme) {
    final symbol = _currencySymbol(balanceCurrency);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: theme.secondaryBackground,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 14,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: isLoadingBalance
          ? const Padding(
              padding: EdgeInsets.symmetric(vertical: 18),
              child: Center(
                child: SizedBox(
                  width: 22,
                  height: 22,
                  child: CircularProgressIndicator(strokeWidth: 2),
                ),
              ),
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.account_balance_wallet_rounded,
                        color: theme.primary, size: 18),
                    const SizedBox(width: 8),
                    Text(
                      'Your Funds',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: theme.secondaryText,
                        letterSpacing: 0.3,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: _fundsStat(
                        theme: theme,
                        label: 'Available',
                        amount: availableBalance,
                        symbol: symbol,
                        color: theme.success,
                      ),
                    ),
                    Container(
                      width: 1,
                      height: 38,
                      color: theme.border,
                      margin: const EdgeInsets.symmetric(horizontal: 16),
                    ),
                    Expanded(
                      child: _fundsStat(
                        theme: theme,
                        label: 'Pending',
                        amount: pendingBalance,
                        symbol: symbol,
                        color: theme.warning,
                      ),
                    ),
                  ],
                ),
              ],
            ),
    );
  }

  Widget _fundsStat({
    required AppTheme theme,
    required String label,
    required int? amount,
    required String symbol,
    required Color color,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 12, color: theme.secondaryText),
        ),
        const SizedBox(height: 4),
        Text(
          amount == null ? '—' : '$symbol${_formatMinorUnits(amount)}',
          style: TextStyle(
            fontSize: 19,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ],
    );
  }

  Widget _payoutAccountCard(AppTheme theme) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.secondaryBackground,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: isLoadingBankAccount
          ? const Padding(
              padding: EdgeInsets.symmetric(vertical: 4),
              child: Center(
                child: SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(strokeWidth: 2),
                ),
              ),
            )
          : Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: theme.primary.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.account_balance_rounded,
                    color: theme.primary,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Payout Account',
                        style: TextStyle(
                          fontSize: 12,
                          color: theme.secondaryText,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        defaultBankAccount == null
                            ? 'No bank account added yet'
                            : '${defaultBankAccount!.bankName} •••• ${defaultBankAccount!.last4}',
                        style: TextStyle(
                          fontSize: 14.5,
                          fontWeight: FontWeight.w600,
                          color: theme.primaryText,
                        ),
                      ),
                    ],
                  ),
                ),
                if (defaultBankAccount != null)
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: theme.success.withOpacity(0.12),
                      borderRadius: BorderRadius.circular(999),
                    ),
                    child: Text(
                      'Default',
                      style: TextStyle(
                        fontSize: 11.5,
                        fontWeight: FontWeight.w700,
                        color: theme.success,
                      ),
                    ),
                  ),
              ],
            ),
    );
  }

  Widget _sectionLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(left: 4),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w600,
          color: Colors.grey.shade600,
          letterSpacing: 0.3,
        ),
      ),
    );
  }

  Widget _statusTile({
    required AppTheme theme,
    required IconData icon,
    required String title,
    required String subtitle,
    required bool active,
  }) {
    final statusColor = active ? theme.success : theme.warning;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.secondaryBackground,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: statusColor.withOpacity(0.12),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: statusColor, size: 22),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: theme.primaryText,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 12.5,
                    color: theme.secondaryText,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color: statusColor.withOpacity(0.12),
              borderRadius: BorderRadius.circular(999),
            ),
            child: Text(
              active ? 'Active' : 'Pending',
              style: TextStyle(
                fontSize: 11.5,
                fontWeight: FontWeight.w700,
                color: statusColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _featureTile({
    required AppTheme theme,
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: theme.secondaryBackground,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: theme.primary.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: theme.primary, size: 20),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 14.5,
                    fontWeight: FontWeight.w600,
                    color: theme.primaryText,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 12.5,
                    color: theme.secondaryText,
                    height: 1.3,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
