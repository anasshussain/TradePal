import '/models/structs/index.dart';
import '/core/theme/app_theme.dart';
import '/utils/util.dart';
import '/widgets/app_button.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import '/viewmodels/add_stripe_model.dart';
export '/viewmodels/add_stripe_model.dart';

class AddStripeWidget extends StatefulWidget {
  const AddStripeWidget({
    super.key,
    String? title,
    String? subtitle,
    String? buttonLabel,
    this.bankDetails,
  })  : this.title = title ?? '',
        this.subtitle = subtitle ?? '',
        this.buttonLabel = buttonLabel ?? '';

  final String title;
  final String subtitle;
  final String buttonLabel;
  final List<StripeDataStruct>? bankDetails;

  @override
  State<AddStripeWidget> createState() => _AddStripeWidgetState();
}

class _AddStripeWidgetState extends State<AddStripeWidget> {
  late AddStripeModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => AddStripeModel());

    // On component load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      _model.payoutsEnabled = false;
      _model.isVerificationPending = false;
      safeSetState(() {});
      if (widget!.bankDetails != null && (widget!.bankDetails)!.isNotEmpty) {
        if (widget!.bankDetails!.firstOrNull!.payoutsEnabled &&
            widget!.bankDetails!.firstOrNull!.chargesEnabled) {
          _model.payoutsEnabled = true;
          safeSetState(() {});
        } else {
          _model.isVerificationPending = true;
          safeSetState(() {});
        }
      }
    });

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    // On component dispose action.
    () async {
      _model.payoutsEnabled = false;
      _model.isVerificationPending = false;
    }();

    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional(0.0, 1.0),
      child: SafeArea(
        child: Container(
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
            padding: EdgeInsets.all(valueOrDefault<double>(
              AppConstants.parentPagePadding,
              0.0,
            )),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 48.0,
                      height: 48.0,
                      decoration: BoxDecoration(
                        color: AppTheme.of(context).secondary,
                        borderRadius: BorderRadius.circular(6.0),
                        shape: BoxShape.rectangle,
                      ),
                      alignment: AlignmentDirectional(0.0, 0.0),
                      child: SvgPicture.network(
                        'https://cdn.simpleicons.org/stripe/ffffff.svg',
                        width: 28.0,
                        height: 28.0,
                        fit: BoxFit.contain,
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: InkWell(
                        splashColor: Colors.transparent,
                        focusColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () async {
                          Navigator.pop(context);
                        },
                        child: Container(
                          decoration: BoxDecoration(),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    widget!.title,
                                    style: AppTheme.of(context)
                                        .titleMedium
                                        .override(
                                          font: GoogleFonts.manrope(
                                            fontWeight:
                                                AppTheme.of(context)
                                                    .titleMedium
                                                    .fontWeight,
                                            fontStyle:
                                                AppTheme.of(context)
                                                    .titleMedium
                                                    .fontStyle,
                                          ),
                                          color: AppTheme.of(context)
                                              .primaryText,
                                          letterSpacing: 0.0,
                                          fontWeight:
                                              AppTheme.of(context)
                                                  .titleMedium
                                                  .fontWeight,
                                          fontStyle:
                                              AppTheme.of(context)
                                                  .titleMedium
                                                  .fontStyle,
                                          lineHeight: 1.4,
                                        ),
                                  ),
                                  Icon(
                                    Icons.close,
                                    color: AppTheme.of(context)
                                        .primaryText,
                                    size: 24.0,
                                  ),
                                ],
                              ),
                              Text(
                                widget!.subtitle,
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
                        ),
                      ),
                    ),
                  ].divide(SizedBox(width: 10.0)),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: AppTheme.of(context).primaryBackground,
                    borderRadius: BorderRadius.circular(6.0),
                    shape: BoxShape.rectangle,
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(valueOrDefault<double>(
                      AppConstants.childPadding,
                      0.0,
                    )),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        if (_model.isVerificationPending)
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                0.0,
                                AppTheme.of(context)
                                    .designToken
                                    .spacing
                                    .md,
                                0.0,
                                AppTheme.of(context)
                                    .designToken
                                    .spacing
                                    .md),
                            child: Text(
                              'Verification Pending',
                              style: AppTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    font: GoogleFonts.manrope(
                                      fontWeight: AppTheme.of(context)
                                          .bodyMedium
                                          .fontWeight,
                                      fontStyle: AppTheme.of(context)
                                          .bodyMedium
                                          .fontStyle,
                                    ),
                                    color: AppTheme.of(context)
                                        .primaryText,
                                    letterSpacing: 0.0,
                                    fontWeight: AppTheme.of(context)
                                        .bodyMedium
                                        .fontWeight,
                                    fontStyle: AppTheme.of(context)
                                        .bodyMedium
                                        .fontStyle,
                                    lineHeight: 1.4,
                                  ),
                            ),
                          ),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.account_balance_rounded,
                              color: AppTheme.of(context).secondaryText,
                              size: 20.0,
                            ),
                            Expanded(
                              flex: 1,
                              child: Text(
                                'Direct Payouts',
                                style: AppTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      font: GoogleFonts.manrope(
                                        fontWeight: AppTheme.of(context)
                                            .bodyMedium
                                            .fontWeight,
                                        fontStyle: AppTheme.of(context)
                                            .bodyMedium
                                            .fontStyle,
                                      ),
                                      color: AppTheme.of(context)
                                          .primaryText,
                                      letterSpacing: 0.0,
                                      fontWeight: AppTheme.of(context)
                                          .bodyMedium
                                          .fontWeight,
                                      fontStyle: AppTheme.of(context)
                                          .bodyMedium
                                          .fontStyle,
                                      lineHeight: 1.4,
                                    ),
                              ),
                            ),
                            Icon(
                              Icons.check_circle_rounded,
                              color: valueOrDefault<Color>(
                                _model.payoutsEnabled
                                    ? AppTheme.of(context).success
                                    : AppTheme.of(context).alternate,
                                AppTheme.of(context).alternate,
                              ),
                              size: 18.0,
                            ),
                          ].divide(SizedBox(width: 10.0)),
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.security_rounded,
                              color: AppTheme.of(context).secondaryText,
                              size: 20.0,
                            ),
                            Expanded(
                              flex: 1,
                              child: Text(
                                'Secure Encryption',
                                style: AppTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      font: GoogleFonts.manrope(
                                        fontWeight: AppTheme.of(context)
                                            .bodyMedium
                                            .fontWeight,
                                        fontStyle: AppTheme.of(context)
                                            .bodyMedium
                                            .fontStyle,
                                      ),
                                      color: AppTheme.of(context)
                                          .primaryText,
                                      letterSpacing: 0.0,
                                      fontWeight: AppTheme.of(context)
                                          .bodyMedium
                                          .fontWeight,
                                      fontStyle: AppTheme.of(context)
                                          .bodyMedium
                                          .fontStyle,
                                      lineHeight: 1.4,
                                    ),
                              ),
                            ),
                            Icon(
                              Icons.check_circle_rounded,
                              color: valueOrDefault<Color>(
                                _model.payoutsEnabled
                                    ? AppTheme.of(context).success
                                    : AppTheme.of(context).alternate,
                                AppTheme.of(context).alternate,
                              ),
                              size: 18.0,
                            ),
                          ].divide(SizedBox(width: 10.0)),
                        ),
                      ].divide(SizedBox(height: 10.0)),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0,
                      AppTheme.of(context).designToken.spacing.md),
                  child: AppButton(
                    onPressed: () async {},
                    text: widget!.buttonLabel,
                    options: AppButtonOptions(
                      height: 40.0,
                      padding:
                          EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
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
                ),
              ].divide(SizedBox(height: 20.0)),
            ),
          ),
        ),
      ),
    );
  }
}