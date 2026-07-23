import '/auth/supabase_auth/auth_util.dart';
import '/repositories/api_requests/api_calls.dart';
import '/models/structs/index.dart';
import '/core/theme/app_theme.dart';
import '/utils/util.dart';
import '/widgets/app_button.dart';
import 'dart:ui';
import '/utils/custom_code/actions/index.dart' as actions;
import '/core/routes/index.dart';
import 'package:flutter/services.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '/providers/verify_email_provider.dart';
import '/viewmodels/verify_email_model.dart';
export '/viewmodels/verify_email_model.dart';

class VerifyEmailWidget extends StatefulWidget {
  const VerifyEmailWidget({super.key});

  static String routeName = 'verify_email';
  static String routePath = '/verifyEmail';

  @override
  State<VerifyEmailWidget> createState() => _VerifyEmailWidgetState();
}

class _VerifyEmailWidgetState extends State<VerifyEmailWidget> {
  late VerifyEmailModel _model;
  final VerifyEmailProvider _provider = VerifyEmailProvider();

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => VerifyEmailModel());

    _model.pinCodeFocusNode ??= FocusNode();

    WidgetsBinding.instance.addPostFrameCallback((_) => _provider.update(() {}));
  }

  @override
  void dispose() {
    _model.dispose();
    _provider.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<VerifyEmailProvider>.value(
      value: _provider,
      child: Consumer<VerifyEmailProvider>(
        builder: (context, _, __) => _buildContent(context),
      ),
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
        body: SafeArea(
          top: true,
          child: Align(
            alignment: const AlignmentDirectional(0.0, 0.0),
            child: Padding(
              padding: EdgeInsets.all(valueOrDefault<double>(
                AppConstants.parentPagePadding,
                0.0,
              )),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Material(
                          color: Colors.transparent,
                          elevation: 0.0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                AppTheme.of(context)
                                    .designToken
                                    .radius
                                    .md),
                          ),
                          child: Container(
                            width: 120.0,
                            height: 120.0,
                            decoration: BoxDecoration(
                              color: AppTheme.of(context)
                                  .secondaryBackground,
                              boxShadow: const [
                                BoxShadow(
                                  blurRadius: 26.0,
                                  color: Color(0x372C4EB8),
                                  offset: Offset(
                                    0.0,
                                    0.0,
                                  ),
                                  spreadRadius: 25.0,
                                )
                              ],
                              borderRadius: BorderRadius.circular(
                                  AppTheme.of(context)
                                      .designToken
                                      .radius
                                      .md),
                              border: Border.all(
                                color: AppTheme.of(context).alternate,
                              ),
                            ),
                            child: Align(
                              alignment: const AlignmentDirectional(0.0, 0.0),
                              child: Icon(
                                Icons.email_outlined,
                                color: AppTheme.of(context).primary,
                                size: 64.0,
                              ),
                            ),
                          ),
                        ),
                        Text(
                          'Verify Your Email',
                          textAlign: TextAlign.center,
                          style: AppTheme.of(context)
                              .displayMedium
                              .override(
                                font: GoogleFonts.manrope(
                                  fontWeight: FontWeight.bold,
                                  fontStyle: AppTheme.of(context)
                                      .displayMedium
                                      .fontStyle,
                                ),
                                fontSize: 44.0,
                                letterSpacing: 0.0,
                                fontWeight: FontWeight.bold,
                                fontStyle: AppTheme.of(context)
                                    .displayMedium
                                    .fontStyle,
                              ),
                        ),
                        Text(
                          'We\'ve sent a verification code to this address ${currentUserEmail}. Enter it below to confirm your account.',
                          textAlign: TextAlign.center,
                          style:
                              AppTheme.of(context).labelLarge.override(
                                    font: GoogleFonts.inter(
                                      fontWeight: AppTheme.of(context)
                                          .labelLarge
                                          .fontWeight,
                                      fontStyle: AppTheme.of(context)
                                          .labelLarge
                                          .fontStyle,
                                    ),
                                    letterSpacing: 0.0,
                                    fontWeight: AppTheme.of(context)
                                        .labelLarge
                                        .fontWeight,
                                    fontStyle: AppTheme.of(context)
                                        .labelLarge
                                        .fontStyle,
                                    lineHeight: 1.5,
                                  ),
                        ),
                        if ((_provider.showResendCode ?? true) &&
                            responsiveVisibility(
                              context: context,
                              phone: false,
                              tablet: false,
                              tabletLandscape: false,
                              desktop: false,
                            ))
                          Text(
                            'Resend the code if you have not received it.',
                            textAlign: TextAlign.center,
                            style: AppTheme.of(context)
                                .labelLarge
                                .override(
                                  font: GoogleFonts.inter(
                                    fontWeight: AppTheme.of(context)
                                        .labelLarge
                                        .fontWeight,
                                    fontStyle: AppTheme.of(context)
                                        .labelLarge
                                        .fontStyle,
                                  ),
                                  letterSpacing: 0.0,
                                  fontWeight: AppTheme.of(context)
                                      .labelLarge
                                      .fontWeight,
                                  fontStyle: AppTheme.of(context)
                                      .labelLarge
                                      .fontStyle,
                                  lineHeight: 1.5,
                                ),
                          ),
                      ].divide(const SizedBox(height: 16.0)),
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        PinCodeTextField(
                          autoDisposeControllers: false,
                          appContext: context,
                          length: 6,
                          textStyle:
                              AppTheme.of(context).bodyLarge.override(
                                    font: GoogleFonts.manrope(
                                      fontWeight: AppTheme.of(context)
                                          .bodyLarge
                                          .fontWeight,
                                      fontStyle: AppTheme.of(context)
                                          .bodyLarge
                                          .fontStyle,
                                    ),
                                    letterSpacing: 0.0,
                                    fontWeight: AppTheme.of(context)
                                        .bodyLarge
                                        .fontWeight,
                                    fontStyle: AppTheme.of(context)
                                        .bodyLarge
                                        .fontStyle,
                                  ),
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          enableActiveFill: false,
                          autoFocus: true,
                          focusNode: _model.pinCodeFocusNode,
                          enablePinAutofill: false,
                          errorTextSpace: 16.0,
                          showCursor: true,
                          cursorColor: AppTheme.of(context).primary,
                          obscureText: false,
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          pinTheme: PinTheme(
                            fieldHeight: 50.0,
                            fieldWidth: 50.0,
                            borderWidth: 0.0,
                            borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(12.0),
                              bottomRight: Radius.circular(12.0),
                              topLeft: Radius.circular(12.0),
                              topRight: Radius.circular(12.0),
                            ),
                            shape: PinCodeFieldShape.box,
                            activeColor: AppTheme.of(context).primary,
                            inactiveColor:
                                AppTheme.of(context).alternate,
                            selectedColor: const Color(0xFF51576C),
                          ),
                          controller: _model.pinCodeController,
                          onChanged: (_) {},
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: _model.pinCodeControllerValidator
                              .asValidator(context),
                        ),
                        Text(
                          'Didn\'t receive the email? Check your spam folder or try again.',
                          textAlign: TextAlign.center,
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
                                color:
                                    AppTheme.of(context).secondaryText,
                                fontSize: 14.0,
                                letterSpacing: 0.0,
                                fontWeight: AppTheme.of(context)
                                    .bodySmall
                                    .fontWeight,
                                fontStyle: AppTheme.of(context)
                                    .bodySmall
                                    .fontStyle,
                              ),
                        ),
                      ].divide(const SizedBox(height: 16.0)),
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        if (responsiveVisibility(
                          context: context,
                          phone: false,
                          tablet: false,
                          tabletLandscape: false,
                          desktop: false,
                        ))
                          AppButton(
                            onPressed: () {
                              print('Button pressed ...');
                            },
                            text: 'Open email app',
                            icon: const Icon(
                              Icons.mail_outline,
                              size: 24.0,
                            ),
                            options: AppButtonOptions(
                              width: 300.0,
                              height: 50.0,
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  24.0, 0.0, 24.0, 0.0),
                              iconPadding: const EdgeInsetsDirectional.fromSTEB(
                                  0.0, 0.0, 0.0, 0.0),
                              iconColor: const Color(0xFF00AB5A),
                              color: Colors.transparent,
                              textStyle: AppTheme.of(context)
                                  .titleSmall
                                  .override(
                                    font: GoogleFonts.manrope(
                                      fontWeight: FontWeight.w600,
                                      fontStyle: AppTheme.of(context)
                                          .titleSmall
                                          .fontStyle,
                                    ),
                                    color: const Color(0xFF00AB5A),
                                    fontSize: 16.0,
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.w600,
                                    fontStyle: AppTheme.of(context)
                                        .titleSmall
                                        .fontStyle,
                                  ),
                              elevation: 0.0,
                              borderSide: const BorderSide(
                                color: Color(0xFF00AB5A),
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                          ),
                        AppButton(
                          onPressed: () async {
                            if (_model.pinCodeController!.text != null &&
                                _model.pinCodeController!.text != '') {
                              _model.verifyCodeApiResult =
                                  await SupabaseEdgeFunctionsGroup.verifyOtpCall
                                      .call(
                                email: currentUserEmail,
                                code: _model.pinCodeController!.text,
                              );

                              if ((_model.verifyCodeApiResult?.succeeded ??
                                  true)) {
                                _model.apiResultUserProfile =
                                    await SupabaseTablesGroup.getUserCall.call(
                                  userId: currentUserUid,
                                );

                                if ((_model.apiResultUserProfile?.succeeded ??
                                    true)) {
                                  AppState().userProfileCache = ((_model
                                                  .apiResultUserProfile
                                                  ?.jsonBody ??
                                              '')
                                          .toList()
                                          .map<UserStruct?>(
                                              UserStruct.maybeFromMap)
                                          .toList() as Iterable<UserStruct?>)
                                      .withoutNulls
                                      .firstOrNull!;
                                  await actions.checkUserSession(
                                    context,
                                  );
                                } else {
                                  await actions.checkUserSession(
                                    context,
                                  );
                                }
                              } else {
                                await actions.showToast(
                                  context,
                                  valueOrDefault<String>(
                                    SupabaseEdgeFunctionsGroup.verifyOtpCall
                                        .message(
                                      (_model.verifyCodeApiResult?.jsonBody ??
                                          ''),
                                    ),
                                    'default value',
                                  ),
                                  2,
                                );
                              }
                            } else {
                              await actions.showToast(
                                context,
                                'Please Enter Otp Code',
                                2,
                              );
                            }

                            _provider.update(() {});
                          },
                          text: 'VERIFY',
                          icon: const Icon(
                            Icons.mark_email_read,
                            size: 24.0,
                          ),
                          options: AppButtonOptions(
                            width: 300.0,
                            height: 50.0,
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                16.0, 0.0, 16.0, 0.0),
                            iconPadding: const EdgeInsetsDirectional.fromSTEB(
                                0.0, 0.0, 0.0, 0.0),
                            color: AppTheme.of(context).primary,
                            textStyle: AppTheme.of(context)
                                .titleSmall
                                .override(
                                  font: GoogleFonts.inter(
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
                            borderRadius: BorderRadius.circular(
                                AppTheme.of(context)
                                    .designToken
                                    .radius
                                    .lg),
                          ),
                        ),
                        if (_provider.showResendCode ?? true)
                          AppButton(
                            onPressed: () async {
                              _model.sendOtpResult =
                                  await SupabaseEdgeFunctionsGroup.sendOtpCall
                                      .call(
                                email: currentUserEmail,
                              );

                              if (SupabaseEdgeFunctionsGroup.sendOtpCall
                                  .success(
                                (_model.sendOtpResult?.jsonBody ?? ''),
                              )!) {
                                await actions.showToast(
                                  context,
                                  valueOrDefault<String>(
                                    SupabaseEdgeFunctionsGroup.sendOtpCall
                                        .message(
                                      (_model.sendOtpResult?.jsonBody ?? ''),
                                    ),
                                    'default value',
                                  ),
                                  2,
                                );
                                _provider.update(() {
                                  _model.pinCodeController?.clear();
                                });
                              } else {
                                await actions.showToast(
                                  context,
                                  valueOrDefault<String>(
                                    SupabaseEdgeFunctionsGroup.sendOtpCall
                                        .message(
                                      (_model.sendOtpResult?.jsonBody ?? ''),
                                    ),
                                    'default value',
                                  ),
                                  2,
                                );
                              }

                              _provider.update(() {});
                            },
                            text: 'Resend code',
                            icon: const Icon(
                              Icons.mark_email_read,
                              size: 15.0,
                            ),
                            options: AppButtonOptions(
                              width: 300.0,
                              height: 50.0,
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  16.0, 0.0, 16.0, 0.0),
                              iconPadding: const EdgeInsetsDirectional.fromSTEB(
                                  0.0, 0.0, 0.0, 0.0),
                              color: Colors.transparent,
                              textStyle: AppTheme.of(context)
                                  .titleSmall
                                  .override(
                                    font: GoogleFonts.inter(
                                      fontWeight: AppTheme.of(context)
                                          .titleSmall
                                          .fontWeight,
                                      fontStyle: AppTheme.of(context)
                                          .titleSmall
                                          .fontStyle,
                                    ),
                                    color: AppTheme.of(context).primary,
                                    letterSpacing: 0.0,
                                    fontWeight: AppTheme.of(context)
                                        .titleSmall
                                        .fontWeight,
                                    fontStyle: AppTheme.of(context)
                                        .titleSmall
                                        .fontStyle,
                                  ),
                              elevation: 0.0,
                              borderSide: BorderSide(
                                color: AppTheme.of(context).primary,
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                        InkWell(
                          splashColor: Colors.transparent,
                          focusColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: () async {
                            GoRouter.of(context).prepareAuthEvent();
                            await authManager.signOut();
                            GoRouter.of(context).clearRedirectLocation();

                            context.goNamedAuth(
                                SignupWidget.routeName, context.mounted);
                          },
                          child: Container(
                            width: double.infinity,
                            height: 50.0,
                            decoration: const BoxDecoration(),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      AppTheme.of(context)
                                          .designToken
                                          .spacing
                                          .lg,
                                      0.0,
                                      0.0,
                                      0.0),
                                  child: Text(
                                    'Wrong email address?',
                                    textAlign: TextAlign.center,
                                    style: AppTheme.of(context)
                                        .bodySmall
                                        .override(
                                          font: GoogleFonts.manrope(
                                            fontWeight:
                                                AppTheme.of(context)
                                                    .bodySmall
                                                    .fontWeight,
                                            fontStyle:
                                                AppTheme.of(context)
                                                    .bodySmall
                                                    .fontStyle,
                                          ),
                                          color: AppTheme.of(context)
                                              .secondaryText,
                                          fontSize: 14.0,
                                          letterSpacing: 0.0,
                                          fontWeight:
                                              AppTheme.of(context)
                                                  .bodySmall
                                                  .fontWeight,
                                          fontStyle:
                                              AppTheme.of(context)
                                                  .bodySmall
                                                  .fontStyle,
                                        ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      AppTheme.of(context)
                                          .designToken
                                          .spacing
                                          .lg,
                                      0.0,
                                      0.0,
                                      0.0),
                                  child: Text(
                                    'Change Email',
                                    textAlign: TextAlign.center,
                                    style: AppTheme.of(context)
                                        .bodySmall
                                        .override(
                                          font: GoogleFonts.manrope(
                                            fontWeight: FontWeight.w600,
                                            fontStyle:
                                                AppTheme.of(context)
                                                    .bodySmall
                                                    .fontStyle,
                                          ),
                                          color: AppTheme.of(context)
                                              .primary,
                                          fontSize: 15.0,
                                          letterSpacing: 0.0,
                                          fontWeight: FontWeight.w600,
                                          fontStyle:
                                              AppTheme.of(context)
                                                  .bodySmall
                                                  .fontStyle,
                                        ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ].divide(const SizedBox(height: 12.0)),
                    ),
                  ].divide(const SizedBox(height: AppConstants.spacing)),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
