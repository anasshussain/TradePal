import 'package:collection/collection.dart';
import 'package:my_trade_pal/widgets/components/appbar_component/appbar_component_widget.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '/auth/supabase_auth/auth_util.dart';
import '/repositories/api_requests/api_calls.dart';
import '/repositories/backend.dart';
import '/models/structs/index.dart';
import '/widgets/components/bank_card_component/bank_card_component_widget.dart';
import '/widgets/app_icon_button.dart';
import '/core/theme/app_theme.dart';
import '/utils/util.dart';
import '/widgets/app_button.dart';
import 'dart:ui';
import '/utils/custom_code/actions/index.dart' as actions;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '/providers/bank_cards_provider.dart';
import '/viewmodels/bank_cards_model.dart';
export '/viewmodels/bank_cards_model.dart';

/// create a page to show saved cards like atm cards and chip logo with all
/// card details, expiry
class BankCardsWidget extends StatefulWidget {
  const BankCardsWidget({super.key});

  static String routeName = 'bank_cards';
  static String routePath = '/bankCards';

  @override
  State<BankCardsWidget> createState() => _BankCardsWidgetState();
}

class _BankCardsWidgetState extends State<BankCardsWidget> {
  late BankCardsModel _model;
  List<BankDetailsStruct>? getCards;
  late BankCardsProvider _provider = BankCardsProvider();

  final scaffoldKey = GlobalKey<ScaffoldState>();
  bool isLoading = false;
  @override
  void initState() {
    super.initState();
    isLoading = true;
    _model = createModel(context, () => BankCardsModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      try {
        debugPrint('[CardsDebug] currentUserUid=$currentUserUid');

        _model.userStripeRow = await SupabaseTablesGroup.getStripeRowCall.call(
          userId: 'eq.${currentUserUid}',
        );

        debugPrint(
            '[CardsDebug] getStripeRowCall: succeeded=${_model.userStripeRow?.succeeded} statusCode=${_model.userStripeRow?.statusCode} body=${_model.userStripeRow?.bodyText}');

        if ((_model.userStripeRow?.succeeded ?? true)) {
          // Note: jsonBody is `dynamic`, so this whole chain is dynamically
          // dispatched. `whereType<T>()` is a real Iterable method (unlike
          // the `withoutNulls` extension, which can't be resolved through a
          // dynamic receiver and throws NoSuchMethodError at runtime). The
          // explicit `List<StripeDataStruct>` annotation is also required:
          // without it, `stripeAccounts` would infer type `dynamic`, and the
          // `firstWhereOrNull`/`firstOrNull` extensions below would fail the
          // same way even though the runtime object is a proper List.
          final List<StripeDataStruct> stripeAccounts =
              (_model.userStripeRow?.jsonBody ?? '')
                  .toList()
                  .map<StripeDataStruct?>(StripeDataStruct.maybeFromMap)
                  .whereType<StripeDataStruct>()
                  .toList();

          debugPrint(
              '[CardsDebug] parsed ${stripeAccounts.length} stripe_accounts row(s): ${stripeAccounts.map((a) => '${a.stripeAccountId} (charges=${a.chargesEnabled}, payouts=${a.payoutsEnabled})').toList()}');

          // A user can end up with more than one stripe_accounts row (e.g. a
          // double-tapped "Connect Stripe" creating two Stripe accounts).
          // Prefer the fully onboarded one over a stale/incomplete duplicate.
          final stripeAccount = stripeAccounts.firstWhereOrNull(
                (a) => a.payoutsEnabled && a.chargesEnabled,
              ) ??
              stripeAccounts.firstWhereOrNull((a) => a.stripeAccountId.isNotEmpty) ??
              stripeAccounts.firstOrNull;

          final stripeAccountId = stripeAccount?.stripeAccountId;
          debugPrint('[CardsDebug] chosen stripeAccountId=$stripeAccountId');

          if (stripeAccountId != null && stripeAccountId.isNotEmpty) {
            _model.bankDetailRes =
                await SupabaseEdgeFunctionsGroup.getBankAccDetailsCall.call(
              accountId: stripeAccountId,
            );

            debugPrint(
                '[CardsDebug] get-bankAccounts: succeeded=${_model.bankDetailRes?.succeeded} statusCode=${_model.bankDetailRes?.statusCode} body=${_model.bankDetailRes?.bodyText}');

            if ((_model.bankDetailRes?.succeeded ?? true)) {
              getCards = (_model.bankDetailRes?.jsonBody ?? '')
                  .toList()
                  .map<BankDetailsStruct?>(BankDetailsStruct.maybeFromMap)
                  .whereType<BankDetailsStruct>()
                  .toList();
              _provider.stripeDetails = stripeAccount;
              debugPrint('[CardsDebug] parsed ${getCards?.length} card(s)');
            } else {
              debugPrint(
                  '[CardsDebug] get-bankAccounts failed: ${_model.bankDetailRes?.bodyText}');
            }
          } else {
            debugPrint(
                '[CardsDebug] no usable stripe_account_id found, skipping bank account fetch');
          }
        }
      } catch (e, s) {
        debugPrint('[CardsDebug] EXCEPTION loading bank cards: $e\n$s');
      } finally {
        safeSetState(() {
          isLoading = false;
        });
      }
    });

    WidgetsBinding.instance.addPostFrameCallback((_) => _provider.notify());
  }

  @override
  void dispose() {
    _model.dispose();
    _provider.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<BankCardsProvider>.value(
      value: _provider,
      child: _buildContent(context),
    );
  }

  Widget _buildContent(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: AppTheme.of(context).primaryBackground,
        appBar: AppBar(
          backgroundColor: AppTheme.of(context).primaryBackground,
          automaticallyImplyLeading: false,
          title: AppbarComponentWidget(
            title: 'Bank Cards',
            showAction: false,
            actionIcon: null,
            action: () async {},
          ),
        ),
        body: (getCards == null || getCards!.isEmpty)
            ? Skeletonizer(
                enabled: isLoading,
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.credit_card_off_outlined,
                          size: 80,
                          color: Colors.grey.shade400,
                        ),
                        const SizedBox(height: 20),
                      
                      
                        const Text(
                          'No Cards Found',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          "You haven't added any payment cards yet.\nAdd your first card to continue.",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.grey.shade600,
                            height: 1.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            : Skeletonizer(
                enabled: isLoading,
                child: Padding(
                  padding: const EdgeInsets.only(top: 10.0, bottom: 100),
                  child: Builder(
                    builder: (context) {
                      final bank = getCards ?? [];

                      return ListView.separated(
                        padding: EdgeInsets.zero,
                        clipBehavior: Clip.none,
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        itemCount: bank.length,
                        separatorBuilder: (_, __) => SizedBox(
                            height:
                                AppTheme.of(context).designToken.spacing.lg),
                        itemBuilder: (context, bankIndex) {
                          return InkWell(
                            onTap: () async {
                              debugPrint("the data is ${bank[bankIndex]}");
                              ApiCallResponse response =
                                  await SupabaseEdgeFunctionsGroup
                                      .deleteBankAccountCall
                                      .call(
                                          accountId: bank[bankIndex].account,
                                          bankAccountId: bank[bankIndex].id);
                              setState(() {
                                bank.removeAt(bankIndex);

                                debugPrint("Success: ${response.succeeded}");
                                debugPrint("Status: ${response.statusCode}");
                                debugPrint("JSON: ${response.jsonBody}");
                              });
                            },
                            child: BankCardComponentWidget(
                                key: Key(
                                    'Keywhx_${bankIndex}_of_${bank.length}'),
                                bankCardDetail: bank[bankIndex]),
                          );
                        },
                      );
                    },
                  ),
                ),
              ),
        floatingActionButton: Padding(
          padding: const EdgeInsets.all(20),
          child: FloatingActionButton(
            enableFeedback: true,
            backgroundColor: AppTheme.of(context).secondary,
            onPressed: () async {
              _model.connectStripe = await SupabaseEdgeFunctionsGroup
                  .onboardingStripeConnectAccountCall
                  .call(
                userId: currentUserUid,
                email: currentUserEmail,
              );

              if ((_model.connectStripe?.succeeded ?? true)) {
                await launchURL(SupabaseEdgeFunctionsGroup
                    .onboardingStripeConnectAccountCall
                    .url(
                  (_model.connectStripe?.jsonBody ?? ''),
                )!);
              } else {
                await actions.showToast(
                  context,
                  'Some error occured',
                  2,
                );
              }

              safeSetState(() {});
            },
            child: Icon(
              Icons.add,
              color: Color(0xffffffff),
            ),
          ),
        ),
      ),
    );
  }
}
