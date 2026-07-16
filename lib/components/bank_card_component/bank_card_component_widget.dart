import '/backend/api_requests/api_calls.dart';
import '/backend/schema/structs/index.dart';
import '/theme/app_theme.dart';
import '/core/util.dart';
import '/widgets/app_button.dart';
import 'dart:ui';
import '/custom_code/actions/index.dart' as actions;
import '/core/custom_functions.dart' as functions;
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'bank_card_component_model.dart';
export 'bank_card_component_model.dart';

class BankCardComponentWidget extends StatefulWidget {
  const BankCardComponentWidget({
    super.key,
    required this.bankCardDetail,
  });

  final BankDetailsStruct? bankCardDetail;

  @override
  State<BankCardComponentWidget> createState() =>
      _BankCardComponentWidgetState();
}

class _BankCardComponentWidgetState extends State<BankCardComponentWidget> {
  late BankCardComponentModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => BankCardComponentModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Material(
          color: Colors.transparent,
          elevation: 4.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Container(
            width: 320.0,
            height: 200.0,
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: Image.asset(
                  'assets/images/texture.jpg',
                ).image,
              ),
              borderRadius: BorderRadius.circular(12.0),
            ),
          ),
        ),
        Material(
          color: Colors.transparent,
          elevation: 6.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Container(
            width: 320.0,
            height: 200.0,
            constraints: BoxConstraints(
              maxWidth: double.infinity,
              maxHeight: 200.0,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: Container(
              width: double.infinity,
              child: Stack(
                children: [
                  Align(
                    alignment: AlignmentDirectional(1.0, -1.0),
                    child: Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 10.0, 0.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  blurRadius: 4.0,
                                  color: AppTheme.of(context)
                                      .secondaryBackground,
                                  offset: Offset(
                                    0.5,
                                    0.5,
                                  ),
                                )
                              ],
                              borderRadius: BorderRadius.circular(4.0),
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(2.0),
                              child: InkWell(
                                splashColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () async {
                                  _model.removeBankAccount =
                                      await SupabaseEdgeFunctionsGroup
                                          .deleteBankAccountCall
                                          .call(
                                    accountId: widget!.bankCardDetail?.account,
                                    bankAccountId: widget!.bankCardDetail?.id,
                                  );

                                  if ((_model.removeBankAccount?.succeeded ??
                                      true)) {
                                    await actions.showToast(
                                      context,
                                      'Successfully Deleted',
                                      2,
                                    );
                                  } else {
                                    await actions.showToast(
                                      context,
                                      'Some error occured',
                                      2,
                                    );
                                  }

                                  safeSetState(() {});
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        blurRadius: 4.0,
                                        color: Color(0xFFC0C0C0),
                                        offset: Offset(
                                          -1.5,
                                          -1.5,
                                        ),
                                      )
                                    ],
                                    borderRadius: BorderRadius.circular(4.0),
                                  ),
                                  child: Icon(
                                    Icons.delete_rounded,
                                    color: Color(0xFFD8D8D8),
                                    size: 30.0,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Theme(
                            data: ThemeData(
                              checkboxTheme: CheckboxThemeData(
                                visualDensity: VisualDensity.compact,
                                materialTapTargetSize:
                                    MaterialTapTargetSize.shrinkWrap,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4.0),
                                ),
                              ),
                              unselectedWidgetColor:
                                  AppTheme.of(context).secondaryText,
                            ),
                            child: Checkbox(
                              value: _model.checkboxValue ??=
                                  widget!.bankCardDetail!.defaultForCurrency,
                              onChanged: (newValue) async {
                                safeSetState(
                                    () => _model.checkboxValue = newValue!);
                                if (newValue!) {
                                  _model.createDefaultAccount =
                                      await SupabaseEdgeFunctionsGroup
                                          .createDefaultAccountCall
                                          .call(
                                    accountId: widget!.bankCardDetail?.account,
                                    bankAccountId: widget!.bankCardDetail?.id,
                                  );

                                  if ((_model.createDefaultAccount?.succeeded ??
                                      true)) {
                                    await actions.showToast(
                                      context,
                                      'Account updated',
                                      2,
                                    );
                                  } else {
                                    await actions.showToast(
                                      context,
                                      'some error occured',
                                      2,
                                    );
                                  }

                                  safeSetState(() {});
                                }
                              },
                              side:
                                  (AppTheme.of(context).secondaryText !=
                                          null)
                                      ? BorderSide(
                                          width: 2,
                                          color: AppTheme.of(context)
                                              .secondaryText!,
                                        )
                                      : null,
                              activeColor: AppTheme.of(context).primary,
                              checkColor: AppTheme.of(context).info,
                            ),
                          ),
                        ].divide(SizedBox(height: 20.0)),
                      ),
                    ),
                  ),
                  Opacity(
                    opacity: 0.5,
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppTheme.of(context).success,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10.0),
                          bottomRight: Radius.circular(12.0),
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Text(
                          valueOrDefault<String>(
                            widget!.bankCardDetail?.bankName,
                            'bank name',
                          ),
                          style: AppTheme.of(context)
                              .bodyMedium
                              .override(
                                font: GoogleFonts.manrope(
                                  fontWeight: FontWeight.w600,
                                  fontStyle: AppTheme.of(context)
                                      .bodyMedium
                                      .fontStyle,
                                ),
                                color: AppTheme.of(context).primaryText,
                                fontSize: 16.0,
                                letterSpacing: 0.0,
                                fontWeight: FontWeight.w600,
                                fontStyle: AppTheme.of(context)
                                    .bodyMedium
                                    .fontStyle,
                              ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Transform.rotate(
                              angle: 270.0 * (math.pi / 180),
                              child: Icon(
                                Icons.change_history_sharp,
                                color: AppTheme.of(context).primary,
                                size: 24.0,
                              ),
                            ),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: Image.asset(
                                'assets/images/cardChip-removebg-preview.png',
                                width: 55.0,
                                height: 55.0,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              '****',
                              style: AppTheme.of(context)
                                  .bodyMedium
                                  .override(
                                font: GoogleFonts.poppins(
                                  fontWeight: AppTheme.of(context)
                                      .bodyMedium
                                      .fontWeight,
                                  fontStyle: AppTheme.of(context)
                                      .bodyMedium
                                      .fontStyle,
                                ),
                                color: Color(0x83FFFFFF),
                                fontSize: 28.0,
                                letterSpacing: 0.0,
                                fontWeight: AppTheme.of(context)
                                    .bodyMedium
                                    .fontWeight,
                                fontStyle: AppTheme.of(context)
                                    .bodyMedium
                                    .fontStyle,
                                shadows: [
                                  Shadow(
                                    color: Color(0xFFC0C0C0),
                                    offset: Offset(-1.5, -1.5),
                                    blurRadius: 4.0,
                                  ),
                                  Shadow(
                                    color: AppTheme.of(context)
                                        .secondaryBackground,
                                    offset: Offset(1.5, 1.5),
                                    blurRadius: 4.0,
                                  )
                                ],
                              ),
                            ),
                            Text(
                              '****',
                              style: AppTheme.of(context)
                                  .bodyMedium
                                  .override(
                                font: GoogleFonts.poppins(
                                  fontWeight: AppTheme.of(context)
                                      .bodyMedium
                                      .fontWeight,
                                  fontStyle: AppTheme.of(context)
                                      .bodyMedium
                                      .fontStyle,
                                ),
                                color: Color(0x83FFFFFF),
                                fontSize: 28.0,
                                letterSpacing: 0.0,
                                fontWeight: AppTheme.of(context)
                                    .bodyMedium
                                    .fontWeight,
                                fontStyle: AppTheme.of(context)
                                    .bodyMedium
                                    .fontStyle,
                                shadows: [
                                  Shadow(
                                    color: Color(0xFFC0C0C0),
                                    offset: Offset(-1.5, -1.5),
                                    blurRadius: 4.0,
                                  ),
                                  Shadow(
                                    color: AppTheme.of(context)
                                        .secondaryBackground,
                                    offset: Offset(1.5, 1.5),
                                    blurRadius: 4.0,
                                  )
                                ],
                              ),
                            ),
                            Text(
                              '****',
                              style: AppTheme.of(context)
                                  .bodyMedium
                                  .override(
                                font: GoogleFonts.poppins(
                                  fontWeight: AppTheme.of(context)
                                      .bodyMedium
                                      .fontWeight,
                                  fontStyle: AppTheme.of(context)
                                      .bodyMedium
                                      .fontStyle,
                                ),
                                color: Color(0x83FFFFFF),
                                fontSize: 28.0,
                                letterSpacing: 0.0,
                                fontWeight: AppTheme.of(context)
                                    .bodyMedium
                                    .fontWeight,
                                fontStyle: AppTheme.of(context)
                                    .bodyMedium
                                    .fontStyle,
                                shadows: [
                                  Shadow(
                                    color: Color(0xFFC0C0C0),
                                    offset: Offset(-1.5, -1.5),
                                    blurRadius: 4.0,
                                  ),
                                  Shadow(
                                    color: AppTheme.of(context)
                                        .secondaryBackground,
                                    offset: Offset(1.5, 1.5),
                                    blurRadius: 4.0,
                                  )
                                ],
                              ),
                            ),
                            Text(
                              valueOrDefault<String>(
                                widget!.bankCardDetail?.last4,
                                '0123',
                              ),
                              style: AppTheme.of(context)
                                  .bodyMedium
                                  .override(
                                font: GoogleFonts.poppins(
                                  fontWeight: AppTheme.of(context)
                                      .bodyMedium
                                      .fontWeight,
                                  fontStyle: AppTheme.of(context)
                                      .bodyMedium
                                      .fontStyle,
                                ),
                                color: Color(0x83FFFFFF),
                                fontSize: 28.0,
                                letterSpacing: 0.0,
                                fontWeight: AppTheme.of(context)
                                    .bodyMedium
                                    .fontWeight,
                                fontStyle: AppTheme.of(context)
                                    .bodyMedium
                                    .fontStyle,
                                shadows: [
                                  Shadow(
                                    color: Color(0xFFC0C0C0),
                                    offset: Offset(-1.5, -1.5),
                                    blurRadius: 4.0,
                                  ),
                                  Shadow(
                                    color: AppTheme.of(context)
                                        .secondaryBackground,
                                    offset: Offset(1.5, 1.5),
                                    blurRadius: 4.0,
                                  )
                                ],
                              ),
                            ),
                          ].divide(SizedBox(width: 10.0)),
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Padding(
                              padding: EdgeInsets.all(10.0),
                              child: Text(
                                functions
                                    .countryCodeToEmoji(valueOrDefault<String>(
                                  widget!.bankCardDetail?.country,
                                  'country',
                                )),
                                style: AppTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      font: GoogleFonts.manrope(
                                        fontWeight: FontWeight.w600,
                                        fontStyle: AppTheme.of(context)
                                            .bodyMedium
                                            .fontStyle,
                                      ),
                                      color: AppTheme.of(context)
                                          .primaryText,
                                      fontSize: 16.0,
                                      letterSpacing: 0.0,
                                      fontWeight: FontWeight.w600,
                                      fontStyle: AppTheme.of(context)
                                          .bodyMedium
                                          .fontStyle,
                                    ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 10.0, 0.0, 10.0),
                              child: Text(
                                valueOrDefault<String>(
                                  widget!.bankCardDetail?.currency,
                                  'currency',
                                ),
                                style: AppTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      font: GoogleFonts.manrope(
                                        fontWeight: FontWeight.w600,
                                        fontStyle: AppTheme.of(context)
                                            .bodyMedium
                                            .fontStyle,
                                      ),
                                      color: AppTheme.of(context)
                                          .primaryText,
                                      fontSize: 16.0,
                                      letterSpacing: 0.0,
                                      fontWeight: FontWeight.w600,
                                      fontStyle: AppTheme.of(context)
                                          .bodyMedium
                                          .fontStyle,
                                    ),
                              ),
                            ),
                          ],
                        ),
                      ].divide(SizedBox(height: 10.0)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
