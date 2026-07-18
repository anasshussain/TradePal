import '/auth/supabase_auth/auth_util.dart';
import '/repositories/api_requests/api_calls.dart';
import '/core/theme/app_theme.dart';
import '/utils/util.dart';
import '/widgets/app_button.dart';
import 'dart:ui';
import '/utils/custom_code/actions/index.dart' as actions;
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '/viewmodels/unlock_chat_dialogue_box_model.dart';
export '/viewmodels/unlock_chat_dialogue_box_model.dart';

/// create a dialogue box which show pay now button and text for unloacking
/// the chat with customer
class UnlockChatDialogueBoxWidget extends StatefulWidget {
  const UnlockChatDialogueBoxWidget({
    super.key,
    required this.jobid,
  });

  final String? jobid;

  @override
  State<UnlockChatDialogueBoxWidget> createState() =>
      _UnlockChatDialogueBoxWidgetState();
}

class _UnlockChatDialogueBoxWidgetState
    extends State<UnlockChatDialogueBoxWidget> {
  late UnlockChatDialogueBoxModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => UnlockChatDialogueBoxModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 320.0,
      decoration: BoxDecoration(
        color: AppTheme.of(context).secondaryBackground,
        borderRadius: BorderRadius.circular(10.0),
        shape: BoxShape.rectangle,
        border: Border.all(
          color: AppTheme.of(context).alternate,
          width: 1.0,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(32.0),
        child: Container(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 64.0,
                height: 64.0,
                decoration: BoxDecoration(
                  color: Color(0x1A214FC7),
                  borderRadius: BorderRadius.circular(9999.0),
                  shape: BoxShape.rectangle,
                ),
                alignment: AlignmentDirectional(0.0, 0.0),
                child: Icon(
                  Icons.lock_open_rounded,
                  color: AppTheme.of(context).primary,
                  size: 32.0,
                ),
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Unlock Customer Chat',
                    textAlign: TextAlign.center,
                    style: AppTheme.of(context).titleLarge.override(
                          font: GoogleFonts.manrope(
                            fontWeight: AppTheme.of(context)
                                .titleLarge
                                .fontWeight,
                            fontStyle: AppTheme.of(context)
                                .titleLarge
                                .fontStyle,
                          ),
                          color: AppTheme.of(context).primaryText,
                          letterSpacing: 0.0,
                          fontWeight: AppTheme.of(context)
                              .titleLarge
                              .fontWeight,
                          fontStyle:
                              AppTheme.of(context).titleLarge.fontStyle,
                          lineHeight: 1.4,
                        ),
                  ),
                  Text(
                    'Your proposal has been accepted. Pay the access fee to start chatting with the customer.',
                    textAlign: TextAlign.center,
                    style: AppTheme.of(context).bodyMedium.override(
                          font: GoogleFonts.manrope(
                            fontWeight: AppTheme.of(context)
                                .bodyMedium
                                .fontWeight,
                            fontStyle: AppTheme.of(context)
                                .bodyMedium
                                .fontStyle,
                          ),
                          color: AppTheme.of(context).secondaryText,
                          letterSpacing: 0.0,
                          fontWeight: AppTheme.of(context)
                              .bodyMedium
                              .fontWeight,
                          fontStyle:
                              AppTheme.of(context).bodyMedium.fontStyle,
                          lineHeight: 1.4,
                        ),
                  ),
                ].divide(SizedBox(height: 10.0)),
              ),
              Container(
                decoration: BoxDecoration(
                  color: AppTheme.of(context).primaryBackground,
                  borderRadius: BorderRadius.circular(6.0),
                  shape: BoxShape.rectangle,
                ),
                child: Padding(
                  padding:
                      EdgeInsetsDirectional.fromSTEB(20.0, 10.0, 20.0, 10.0),
                  child: Container(
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Access Fee',
                          style: AppTheme.of(context)
                              .labelMedium
                              .override(
                                font: GoogleFonts.inter(
                                  fontWeight: AppTheme.of(context)
                                      .labelMedium
                                      .fontWeight,
                                  fontStyle: AppTheme.of(context)
                                      .labelMedium
                                      .fontStyle,
                                ),
                                color:
                                    AppTheme.of(context).secondaryText,
                                letterSpacing: 0.0,
                                fontWeight: AppTheme.of(context)
                                    .labelMedium
                                    .fontWeight,
                                fontStyle: AppTheme.of(context)
                                    .labelMedium
                                    .fontStyle,
                                lineHeight: 1.4,
                              ),
                        ),
                        Text(
                          '£7.99',
                          style: AppTheme.of(context)
                              .titleMedium
                              .override(
                                font: GoogleFonts.manrope(
                                  fontWeight: FontWeight.bold,
                                  fontStyle: AppTheme.of(context)
                                      .titleMedium
                                      .fontStyle,
                                ),
                                color: AppTheme.of(context).primaryText,
                                letterSpacing: 0.0,
                                fontWeight: FontWeight.bold,
                                fontStyle: AppTheme.of(context)
                                    .titleMedium
                                    .fontStyle,
                                lineHeight: 1.4,
                              ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    AppButton(
                      onPressed: () async {
                        await actions.unsubscribe(
                          'proposal_payments',
                        );
                        _model.paymentIntentResponse =
                            await CreatePaymentFeeCall.call(
                          jobId: widget!.jobid,
                          token: currentJwtToken,
                        );

                        if ((_model.paymentIntentResponse?.succeeded ?? true)) {
                          await Future.delayed(
                            Duration(
                              milliseconds: 100,
                            ),
                          );
                          await actions.subscribe(
                            'proposal_payments',
                            'stripe_payment_intent_id',
                            CreatePaymentFeeCall.paymentIntentId(
                              (_model.paymentIntentResponse?.jsonBody ?? ''),
                            )!,
                            'update',
                            () async {},
                          );
                          _model.paymentRes = await actions.makePayment(
                            getJsonField(
                              (_model.paymentIntentResponse?.jsonBody ?? ''),
                              r'''$.client_secret''',
                            ).toString(),
                          );
                        }
                        Navigator.pop(context);

                        safeSetState(() {});
                      },
                      text: 'Pay Now',
                      options: AppButtonOptions(
                        width: 150.0,
                        height: 40.0,
                        padding: EdgeInsetsDirectional.fromSTEB(
                            16.0, 0.0, 16.0, 0.0),
                        iconPadding:
                            EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                        color: AppTheme.of(context).primary,
                        textStyle:
                            AppTheme.of(context).titleSmall.override(
                                  font: GoogleFonts.manrope(
                                    fontWeight: AppTheme.of(context)
                                        .titleSmall
                                        .fontWeight,
                                    fontStyle: AppTheme.of(context)
                                        .titleSmall
                                        .fontStyle,
                                  ),
                                  color: Colors.white,
                                  fontSize: 14.0,
                                  letterSpacing: 0.0,
                                  fontWeight: AppTheme.of(context)
                                      .titleSmall
                                      .fontWeight,
                                  fontStyle: AppTheme.of(context)
                                      .titleSmall
                                      .fontStyle,
                                ),
                        elevation: 0.0,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    AppButton(
                      onPressed: () async {
                        Navigator.pop(context);
                      },
                      text: 'Maybe Later',
                      options: AppButtonOptions(
                        width: 150.0,
                        height: 40.0,
                        padding: EdgeInsetsDirectional.fromSTEB(
                            16.0, 0.0, 16.0, 0.0),
                        iconPadding:
                            EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                        color: Colors.transparent,
                        textStyle:
                            AppTheme.of(context).titleSmall.override(
                                  font: GoogleFonts.manrope(
                                    fontWeight: AppTheme.of(context)
                                        .titleSmall
                                        .fontWeight,
                                    fontStyle: AppTheme.of(context)
                                        .titleSmall
                                        .fontStyle,
                                  ),
                                  color: AppTheme.of(context).primary,
                                  fontSize: 14.0,
                                  letterSpacing: 0.0,
                                  fontWeight: AppTheme.of(context)
                                      .titleSmall
                                      .fontWeight,
                                  fontStyle: AppTheme.of(context)
                                      .titleSmall
                                      .fontStyle,
                                ),
                        elevation: 0.0,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  ].divide(SizedBox(height: 4.0)),
                ),
              ),
            ].divide(SizedBox(height: 20.0)),
          ),
        ),
      ),
    );
  }
}
