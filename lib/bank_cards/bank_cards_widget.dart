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

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
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
          _model.bankCards = ((_model.bankDetailRes?.jsonBody ?? '')
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
          safeSetState(() {});
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
        body: SingleChildScrollView(
          primary: false,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: EdgeInsets.all(20.0),
                child: Container(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          AppIconButton(
                            borderRadius: 8.0,
                            buttonSize: 40.0,
                            icon: FaIcon(
                              FontAwesomeIcons.chevronLeft,
                              color: AppTheme.of(context).primaryText,
                              size: 24.0,
                            ),
                            onPressed: () async {
                              context.safePop();
                            },
                          ),
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Text(
                                    'My Cards',
                                    style: AppTheme.of(context)
                                        .headlineMedium
                                        .override(
                                          font: GoogleFonts.manrope(
                                            fontWeight: FontWeight.bold,
                                            fontStyle:
                                                AppTheme.of(context)
                                                    .headlineMedium
                                                    .fontStyle,
                                          ),
                                          color: AppTheme.of(context)
                                              .primaryText,
                                          letterSpacing: 0.0,
                                          fontWeight: FontWeight.bold,
                                          fontStyle:
                                              AppTheme.of(context)
                                                  .headlineMedium
                                                  .fontStyle,
                                          lineHeight: 1.4,
                                        ),
                                  ),
                                ],
                              ),
                              Text(
                                'Manage your payment methods',
                                style: AppTheme.of(context)
                                    .bodySmall
                                    .override(
                                      font: GoogleFonts.manrope(
                                        fontWeight: AppTheme.of(context)
                                            .bodySmall
                                            .fontWeight,
                                        fontStyle: AppTheme.of(context)
                                            .bodySmall
                                            .fontStyle,
                                      ),
                                      color: AppTheme.of(context)
                                          .secondaryText,
                                      letterSpacing: 0.0,
                                      fontWeight: AppTheme.of(context)
                                          .bodySmall
                                          .fontWeight,
                                      fontStyle: AppTheme.of(context)
                                          .bodySmall
                                          .fontStyle,
                                      lineHeight: 1.4,
                                    ),
                              ),
                            ].divide(SizedBox(height: 2.0)),
                          ),
                          AppIconButton(
                            borderRadius: 10.0,
                            buttonSize: 40.0,
                            fillColor: AppTheme.of(context)
                                .secondaryBackground,
                            icon: Icon(
                              Icons.add_rounded,
                              color: AppTheme.of(context).primary,
                              size: 24.0,
                            ),
                            onPressed: () async {
                              _model.connectStripe =
                                  await SupabaseEdgeFunctionsGroup
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
                          ),
                        ],
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                0.0,
                                valueOrDefault<double>(
                                  AppConstants.parentPagePadding,
                                  0.0,
                                ),
                                0.0,
                                0.0),
                            child: Builder(
                              builder: (context) {
                                final bank = _model.bankCards.toList();

                                return ListView.separated(
                                  padding: EdgeInsets.zero,
                                  shrinkWrap: true,
                                  scrollDirection: Axis.vertical,
                                  itemCount: bank.length,
                                  separatorBuilder: (_, __) => SizedBox(
                                      height: AppTheme.of(context)
                                          .designToken
                                          .spacing
                                          .lg),
                                  itemBuilder: (context, bankIndex) {
                                    final bankItem = bank[bankIndex];
                                    return Align(
                                      alignment: AlignmentDirectional(0.0, 0.0),
                                      child: BankCardComponentWidget(
                                        key: Key(
                                            'Keywhx_${bankIndex}_of_${bank.length}'),
                                        bankCardDetail: bankItem,
                                      ),
                                    );
                                  },
                                );
                              },
                            ),
                          ),
                        ].divide(SizedBox(height: 10.0)),
                      ),
                    ].divide(SizedBox(height: 20.0)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
