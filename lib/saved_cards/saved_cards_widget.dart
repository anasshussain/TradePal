import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '/auth/supabase_auth/auth_util.dart';
import '/core/theme/app_theme.dart';
import '/repositories/api_requests/api_calls.dart';
import '/widgets/app_button.dart';
import '/widgets/app_icon_button.dart';
import '/widgets/components/appbar_component/appbar_component_widget.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '/utils/custom_code/actions/index.dart' as actions;

class SavedCardsWidget extends StatefulWidget {
  const SavedCardsWidget({super.key});

  static String routeName = 'saved_cards';

  @override
  State<SavedCardsWidget> createState() => _SavedCardsWidgetState();
}

class _SavedCardsWidgetState extends State<SavedCardsWidget> {
  bool isLoading = true;
  bool isAddingCard = false;
  List<Map<String, dynamic>> cards = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _loadCards());
  }

  Future<void> _loadCards() async {
    if (!mounted) return;
    setState(() => isLoading = true);
    debugPrint('[CardDebug] _loadCards: currentUserUid=$currentUserUid');

    try {
      final response =
          await ListPaymentMethodsCall.call(token: currentJwtToken);

      debugPrint(
          '[CardDebug] list_payment_methods: succeeded=${response.succeeded} statusCode=${response.statusCode} body=${response.bodyText}');

      final success = response.succeeded &&
          (ListPaymentMethodsCall.success(response.jsonBody) == true);

      if (success) {
        cards = ListPaymentMethodsCall.paymentMethods(response.jsonBody)
            .cast<Map<String, dynamic>>();
        debugPrint('[CardDebug] parsed ${cards.length} card(s)');
      } else {
        debugPrint('[CardDebug] list_payment_methods failed');
        cards = [];
      }
    } catch (e, s) {
      debugPrint('[CardDebug] EXCEPTION in _loadCards: $e\n$s');
      cards = [];
    } finally {
      if (mounted) {
        setState(() => isLoading = false);
      }
    }
  }

  Future<void> _addCard() async {
    if (!mounted) return;
    setState(() => isAddingCard = true);
    debugPrint('[CardDebug] _addCard: calling create_setup_intent');

    try {
      final response = await CreateSetupIntentCall.call(token: currentJwtToken);

      debugPrint(
          '[CardDebug] create_setup_intent: succeeded=${response.succeeded} statusCode=${response.statusCode} body=${response.bodyText}');

      final success = response.succeeded &&
          (CreateSetupIntentCall.success(response.jsonBody) == true);

      final clientSecret = CreateSetupIntentCall.clientSecret(
        response.jsonBody,
      );
      final customerId = CreateSetupIntentCall.customerId(response.jsonBody);
      final ephemeralKey = CreateSetupIntentCall.ephemeralKey(
        response.jsonBody,
      );

      if (!success ||
          clientSecret == null ||
          customerId == null ||
          ephemeralKey == null) {
        debugPrint(
            '[CardDebug] create_setup_intent missing fields: success=$success clientSecret=${clientSecret != null} customerId=${customerId != null} ephemeralKey=${ephemeralKey != null}');
        if (mounted) {
          await actions.showToast(
            context,
            CreateSetupIntentCall.message(response.jsonBody) ??
                'Unable to start card setup. Please try again.',
            2,
          );
        }
        return;
      }

      debugPrint('[CardDebug] initPaymentSheet with setup intent');
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          setupIntentClientSecret: clientSecret,
          merchantDisplayName: 'My Trade Pal',
          customerId: customerId,
          customerEphemeralKeySecret: ephemeralKey,
          style: ThemeMode.light,
        ),
      );

      debugPrint('[CardDebug] presentPaymentSheet');
      await Stripe.instance.presentPaymentSheet();
      debugPrint('[CardDebug] presentPaymentSheet completed successfully');

      if (mounted) {
        await actions.showToast(context, 'Card added', 2);
      }
      await _loadCards();
    } on StripeException catch (e) {
      debugPrint(
          '[CardDebug] StripeException: code=${e.error.code} message=${e.error.localizedMessage}');
      // A cancel (user backed out of the sheet) isn't worth an error toast.
      if (e.error.code != FailureCode.Canceled && mounted) {
        await actions.showToast(
          context,
          e.error.localizedMessage ?? 'Unable to add card.',
          2,
        );
      }
    } catch (e, s) {
      debugPrint('[CardDebug] EXCEPTION in _addCard: $e\n$s');
      if (mounted) {
        await actions.showToast(
          context,
          'Unable to add card. Please try again.',
          2,
        );
      }
    } finally {
      if (mounted) {
        setState(() => isAddingCard = false);
      }
    }
  }

  Future<void> _confirmDeleteCard(Map<String, dynamic> card) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Remove card?'),
        content: Text(
          '${_brandLabel(card['brand'])} •••• ${card['last4'] ?? ''} will no '
          'longer be available for payments.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(true),
            child: const Text('Remove'),
          ),
        ],
      ),
    );

    if (confirmed != true) return;

    final response = await DeletePaymentMethodCall.call(
      paymentMethodId: card['id'] as String?,
      token: currentJwtToken,
    );

    final success = response.succeeded &&
        (DeletePaymentMethodCall.success(response.jsonBody) == true);

    if (success) {
      await _loadCards();
    } else if (mounted) {
      await actions.showToast(
        context,
        DeletePaymentMethodCall.message(response.jsonBody) ??
            'Unable to remove card. Please try again.',
        2,
      );
    }
  }

  String _brandLabel(dynamic brand) {
    final value = (brand ?? '').toString();
    if (value.isEmpty) return 'Card';
    return value[0].toUpperCase() + value.substring(1);
  }

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context);

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
          title: 'Payment Methods',
          showAction: false,
          actionIcon: null,
          action: () async {},
        ),
      ),
      body: Skeletonizer(
        enabled: isLoading,
        child: RefreshIndicator(
          onRefresh: _loadCards,
          color: theme.primary,
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
            child: cards.isEmpty
                ? _emptyState(theme)
                : Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 4, bottom: 12),
                        child: Text(
                          'Saved Cards',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey.shade600,
                            letterSpacing: 0.3,
                          ),
                        ),
                      ),
                      for (final card in cards) ...[
                        _cardTile(theme, card),
                        const SizedBox(height: 12),
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
              onPressed: _addCard,
              text: 'Add Card',
              icon: const Icon(
                Icons.add_rounded,
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

  Widget _emptyState(AppTheme theme) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 60),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.credit_card_off_outlined,
              size: 72,
              color: Colors.grey.shade400,
            ),
            const SizedBox(height: 20),
            const Text(
              'No Saved Cards',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Add a card to make paying for jobs faster.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey.shade600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _cardTile(AppTheme theme, Map<String, dynamic> card) {
    final isDefault = card['is_default'] == true;

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
              color: theme.primary.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.credit_card_rounded,
              color: theme.primary,
              size: 22,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${_brandLabel(card['brand'])} •••• ${card['last4'] ?? ''}',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: theme.primaryText,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  'Expires ${card['exp_month'] ?? '--'}/${card['exp_year'] ?? '--'}',
                  style: TextStyle(
                    fontSize: 12.5,
                    color: theme.secondaryText,
                  ),
                ),
              ],
            ),
          ),
          if (isDefault)
            Container(
              margin: const EdgeInsets.only(right: 8),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
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
          IconButton(
            onPressed: () => _confirmDeleteCard(card),
            icon: Icon(
              Icons.delete_outline,
              color: theme.error,
              size: 22,
            ),
          ),
        ],
      ),
    );
  }
}
