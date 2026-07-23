import 'package:my_trade_pal/widgets/components/appbar_component/appbar_component_widget.dart';

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
  final scaffoldKey = GlobalKey<ScaffoldState>();
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    isLoading = true;
    _model = createModel(context, () => BankCardsModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      _model.userStripeRow = await SupabaseTablesGroup.getStripeRowCall.call(
        userId: 'eq.${currentUserUid}',
      );

      if ((_model.userStripeRow?.succeeded ?? true)) {
        _model.bankDetailRes =
            await SupabaseEdgeFunctionsGroup.getBankAccDetailsCall.call(
          accountId: ((_model.userStripeRow?.jsonBody ?? '')
                  .toList()
                  .map<StripeDataStruct?>(StripeDataStruct.maybeFromMap)
                  .toList() as Iterable<StripeDataStruct?>)
              .withoutNulls
              ?.firstOrNull
              ?.stripeAccountId,
        );

        if ((_model.bankDetailRes?.succeeded ?? true)) {
          getCards = _model.bankCards = ((_model.bankDetailRes?.jsonBody ?? '')
                  .toList()
                  .map<BankDetailsStruct?>(BankDetailsStruct.maybeFromMap)
                  .toList() as Iterable<BankDetailsStruct?>)
              .withoutNulls
              .toList()
              .cast<BankDetailsStruct>();
          _model.stripeDetails = ((_model.userStripeRow?.jsonBody ?? '')
                  .toList()
                  .map<StripeDataStruct?>(StripeDataStruct.maybeFromMap)
                  .toList() as Iterable<StripeDataStruct?>)
              .withoutNulls
              ?.firstOrNull;
          safeSetState(() {
            isLoading = false;
          });
        }
      }
    });

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
        body: isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : (getCards == null || getCards!.isEmpty)
                ? Center(
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
                  )
                : Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Builder(
                      builder: (context) {
                        final bank = _model.bankCards.toList();
                  
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
                            final bankItem = bank[bankIndex];
                            return Align(
                              alignment: AlignmentDirectional(0.0, 0.0),
                              child: BankCardComponentWidget(
                                key: Key('Keywhx_${bankIndex}_of_${bank.length}'),
                                bankCardDetail: bankItem,
                              ),
                            );
                          },
                        );
                      },
                    ),
                ),
        floatingActionButton: Padding(
          padding: const EdgeInsets.all(20),
          child: FloatingActionButton(
            backgroundColor:  AppTheme.of(context).secondary,
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
