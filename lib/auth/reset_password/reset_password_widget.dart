import '/widgets/page_header.dart';
import '/core/theme/app_theme.dart';
import '/utils/util.dart';
import '/widgets/app_button.dart';
import 'dart:ui';
import '/utils/action_blocks/actions.dart' as action_blocks;
import '/utils/custom_code/actions/index.dart' as actions;
import '/utils/custom_functions.dart' as functions;
import '/core/routes/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '/providers/reset_password_provider.dart';
import '/viewmodels/reset_password_model.dart';
export '/viewmodels/reset_password_model.dart';

class ResetPasswordWidget extends StatefulWidget {
  const ResetPasswordWidget({super.key});

  static String routeName = 'resetPassword';
  static String routePath = '/resetPassword';

  @override
  State<ResetPasswordWidget> createState() => _ResetPasswordWidgetState();
}

class _ResetPasswordWidgetState extends State<ResetPasswordWidget> {
  late ResetPasswordModel _model;
  final ResetPasswordProvider _provider = ResetPasswordProvider();

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ResetPasswordModel());

    _model.passwordTextController ??= TextEditingController();
    _model.passwordFocusNode ??= FocusNode();

    _model.cPasswordTextController ??= TextEditingController();
    _model.cPasswordFocusNode ??= FocusNode();

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
    return ChangeNotifierProvider<ResetPasswordProvider>.value(
      value: _provider,
      child: Consumer<ResetPasswordProvider>(
        builder: (context, _, __) => _buildContent(context),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    final hasConfirmInput = _model.cPasswordTextController.text.isNotEmpty;
    final passwordsMatch = _model.passwordTextController.text ==
        _model.cPasswordTextController.text;

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: AppTheme.of(context).primaryBackground,
        body: SafeArea(
          // top: true,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              // Pinned header: lives outside the SingleChildScrollView
              // below so it never scrolls away with the rest of the page,
              // matching the pattern used across the rest of the app.
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(
                    valueOrDefault<double>(
                      AppConstants.parentPagePadding,
                      0.0,
                    ),
                    valueOrDefault<double>(
                      AppConstants.parentPagePadding,
                      0.0,
                    ),
                    valueOrDefault<double>(
                      AppConstants.parentPagePadding,
                      0.0,
                    ),
                    0.0),
                child: const PageHeaderWidget(
                  title: 'Reset Password',
                  showNotification: false,
                  showBackButton: true,
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(
                      valueOrDefault<double>(
                        AppConstants.parentPagePadding,
                        0.0,
                      ),
                      AppTheme.of(context).designToken.spacing.lg,
                      valueOrDefault<double>(
                        AppConstants.parentPagePadding,
                        0.0,
                      ),
                      valueOrDefault<double>(
                        AppConstants.parentPagePadding,
                        0.0,
                      )),
                  child: SingleChildScrollView(
                    child: Column(
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
                              .lg),
                    ),
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: AppTheme.of(context)
                            .secondaryBackground,
                        borderRadius: BorderRadius.circular(
                            AppTheme.of(context)
                                .designToken
                                .radius
                                .lg),
                        border: Border.all(
                          color: AppTheme.of(context).alternate,
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(valueOrDefault<double>(
                          AppConstants.parentPagePadding,
                          0.0,
                        )),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Column(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Align(
                                  alignment:
                                      const AlignmentDirectional(-1.0, -1.0),
                                  child: Text(
                                    'NEW PASSWORD',
                                    style: AppTheme.of(context)
                                        .bodySmall
                                        .override(
                                          font: GoogleFonts.inter(
                                            fontWeight: FontWeight.w600,
                                            fontStyle:
                                                AppTheme.of(context)
                                                    .bodySmall
                                                    .fontStyle,
                                          ),
                                          letterSpacing: 1.0,
                                          fontWeight: FontWeight.w600,
                                          fontStyle:
                                              AppTheme.of(context)
                                                  .bodySmall
                                                  .fontStyle,
                                        ),
                                  ),
                                ),
                                SizedBox(
                                  width: double.infinity,
                                  child: TextFormField(
                                    controller:
                                        _model.passwordTextController,
                                    focusNode: _model.passwordFocusNode,
                                    onChanged: (_) =>
                                        _provider.update(() {}),
                                    autofocus: false,
                                    enabled: true,
                                    obscureText: !_model.passwordVisibility,
                                    decoration: InputDecoration(
                                      isDense: false,
                                      labelStyle: AppTheme.of(
                                              context)
                                          .labelMedium
                                          .override(
                                            font: GoogleFonts.inter(
                                              fontWeight:
                                                  AppTheme.of(
                                                          context)
                                                      .labelMedium
                                                      .fontWeight,
                                              fontStyle:
                                                  AppTheme.of(
                                                          context)
                                                      .labelMedium
                                                      .fontStyle,
                                            ),
                                            color:
                                                AppTheme.of(context)
                                                    .secondaryText,
                                            fontSize: 12.0,
                                            letterSpacing: 0.0,
                                            fontWeight:
                                                AppTheme.of(context)
                                                    .labelMedium
                                                    .fontWeight,
                                            fontStyle:
                                                AppTheme.of(context)
                                                    .labelMedium
                                                    .fontStyle,
                                          ),
                                      hintText: '********',
                                      hintStyle: AppTheme.of(
                                              context)
                                          .labelMedium
                                          .override(
                                            font: GoogleFonts.inter(
                                              fontWeight: FontWeight.normal,
                                              fontStyle:
                                                  AppTheme.of(
                                                          context)
                                                      .labelMedium
                                                      .fontStyle,
                                            ),
                                            color:
                                                AppTheme.of(context)
                                                    .hint,
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.normal,
                                            fontStyle:
                                                AppTheme.of(context)
                                                    .labelMedium
                                                    .fontStyle,
                                          ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                          color: Color(0x00000000),
                                          width: 1.0,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color:
                                              AppTheme.of(context)
                                                  .primary,
                                          width: 1.0,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color:
                                              AppTheme.of(context)
                                                  .error,
                                          width: 1.0,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      ),
                                      focusedErrorBorder:
                                          OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color:
                                              AppTheme.of(context)
                                                  .error,
                                          width: 1.0,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      ),
                                      filled: true,
                                      fillColor:
                                          AppTheme.of(context)
                                              .alternate,
                                      suffixIcon: InkWell(
                                        onTap: () async {
                                          safeSetState(() => _model
                                                  .passwordVisibility =
                                              !_model.passwordVisibility);
                                        },
                                        focusNode:
                                            FocusNode(skipTraversal: true),
                                        child: Icon(
                                          _model.passwordVisibility
                                              ? Icons.visibility_outlined
                                              : Icons
                                                  .visibility_off_outlined,
                                          size: 22,
                                        ),
                                      ),
                                    ),
                                    style: AppTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          font: GoogleFonts.inter(
                                            fontWeight:
                                                AppTheme.of(context)
                                                    .bodyMedium
                                                    .fontWeight,
                                            fontStyle:
                                                AppTheme.of(context)
                                                    .bodyMedium
                                                    .fontStyle,
                                          ),
                                          letterSpacing: 0.0,
                                          fontWeight:
                                              AppTheme.of(context)
                                                  .bodyMedium
                                                  .fontWeight,
                                          fontStyle:
                                              AppTheme.of(context)
                                                  .bodyMedium
                                                  .fontStyle,
                                        ),
                                    cursorColor:
                                        AppTheme.of(context)
                                            .primaryText,
                                    enableInteractiveSelection: true,
                                    validator: _model
                                        .passwordTextControllerValidator
                                        .asValidator(context),
                                  ),
                                ),
                                Text(
                                  'CONFIRM NEW PASSWORD',
                                  style: AppTheme.of(context)
                                      .bodySmall
                                      .override(
                                        font: GoogleFonts.inter(
                                          fontWeight: FontWeight.w600,
                                          fontStyle:
                                              AppTheme.of(context)
                                                  .bodySmall
                                                  .fontStyle,
                                        ),
                                        letterSpacing: 1.0,
                                        fontWeight: FontWeight.w600,
                                        fontStyle:
                                            AppTheme.of(context)
                                                .bodySmall
                                                .fontStyle,
                                      ),
                                ),
                                SizedBox(
                                  width: double.infinity,
                                  child: TextFormField(
                                    controller:
                                        _model.cPasswordTextController,
                                    focusNode: _model.cPasswordFocusNode,
                                    onChanged: (_) =>
                                        _provider.update(() {}),
                                    autofocus: false,
                                    enabled: true,
                                    obscureText:
                                        !_model.cPasswordVisibility,
                                    decoration: InputDecoration(
                                      isDense: false,
                                      labelStyle: AppTheme.of(
                                              context)
                                          .labelMedium
                                          .override(
                                            font: GoogleFonts.inter(
                                              fontWeight:
                                                  AppTheme.of(
                                                          context)
                                                      .labelMedium
                                                      .fontWeight,
                                              fontStyle:
                                                  AppTheme.of(
                                                          context)
                                                      .labelMedium
                                                      .fontStyle,
                                            ),
                                            color:
                                                AppTheme.of(context)
                                                    .secondaryText,
                                            fontSize: 12.0,
                                            letterSpacing: 0.0,
                                            fontWeight:
                                                AppTheme.of(context)
                                                    .labelMedium
                                                    .fontWeight,
                                            fontStyle:
                                                AppTheme.of(context)
                                                    .labelMedium
                                                    .fontStyle,
                                          ),
                                      hintText: '********',
                                      hintStyle: AppTheme.of(
                                              context)
                                          .labelMedium
                                          .override(
                                            font: GoogleFonts.inter(
                                              fontWeight: FontWeight.normal,
                                              fontStyle:
                                                  AppTheme.of(
                                                          context)
                                                      .labelMedium
                                                      .fontStyle,
                                            ),
                                            color:
                                                AppTheme.of(context)
                                                    .hint,
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.normal,
                                            fontStyle:
                                                AppTheme.of(context)
                                                    .labelMedium
                                                    .fontStyle,
                                          ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                          color: Color(0x00000000),
                                          width: 1.0,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color:
                                              AppTheme.of(context)
                                                  .primary,
                                          width: 1.0,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color:
                                              AppTheme.of(context)
                                                  .error,
                                          width: 1.0,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      ),
                                      focusedErrorBorder:
                                          OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color:
                                              AppTheme.of(context)
                                                  .error,
                                          width: 1.0,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      ),
                                      filled: true,
                                      fillColor:
                                          AppTheme.of(context)
                                              .alternate,
                                      suffixIcon: InkWell(
                                        onTap: () async {
                                          safeSetState(() => _model
                                                  .cPasswordVisibility =
                                              !_model.cPasswordVisibility);
                                        },
                                        focusNode:
                                            FocusNode(skipTraversal: true),
                                        child: Icon(
                                          _model.cPasswordVisibility
                                              ? Icons.visibility_outlined
                                              : Icons
                                                  .visibility_off_outlined,
                                          size: 22,
                                        ),
                                      ),
                                    ),
                                    style: AppTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          font: GoogleFonts.inter(
                                            fontWeight:
                                                AppTheme.of(context)
                                                    .bodyMedium
                                                    .fontWeight,
                                            fontStyle:
                                                AppTheme.of(context)
                                                    .bodyMedium
                                                    .fontStyle,
                                          ),
                                          letterSpacing: 0.0,
                                          fontWeight:
                                              AppTheme.of(context)
                                                  .bodyMedium
                                                  .fontWeight,
                                          fontStyle:
                                              AppTheme.of(context)
                                                  .bodyMedium
                                                  .fontStyle,
                                        ),
                                    cursorColor:
                                        AppTheme.of(context)
                                            .primaryText,
                                    enableInteractiveSelection: true,
                                    validator: _model
                                        .cPasswordTextControllerValidator
                                        .asValidator(context),
                                  ),
                                ),
                                if (hasConfirmInput)
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(
                                        passwordsMatch
                                            ? Icons.check_circle
                                            : Icons.cancel,
                                        color: passwordsMatch
                                            ? AppTheme.of(context).success
                                            : AppTheme.of(context).error,
                                        size: 16.0,
                                      ),
                                      Text(
                                        passwordsMatch
                                            ? 'Passwords match'
                                            : 'Passwords do not match',
                                        style: AppTheme.of(context)
                                            .labelMedium
                                            .override(
                                              font: GoogleFonts.inter(
                                                fontWeight:
                                                    AppTheme.of(context)
                                                        .labelMedium
                                                        .fontWeight,
                                                fontStyle:
                                                    AppTheme.of(context)
                                                        .labelMedium
                                                        .fontStyle,
                                              ),
                                              color: passwordsMatch
                                                  ? AppTheme.of(context)
                                                      .success
                                                  : AppTheme.of(context)
                                                      .error,
                                              letterSpacing: 0.0,
                                              fontWeight:
                                                  AppTheme.of(context)
                                                      .labelMedium
                                                      .fontWeight,
                                              fontStyle:
                                                  AppTheme.of(context)
                                                      .labelMedium
                                                      .fontStyle,
                                            ),
                                      ),
                                    ].divide(const SizedBox(width: 6.0)),
                                  ),
                              ].divide(SizedBox(
                                  height: AppTheme.of(context)
                                      .designToken
                                      .spacing
                                      .lg)),
                            ),
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
                                decoration: BoxDecoration(
                                  color: AppTheme.of(context)
                                      .secondaryBackground,
                                  borderRadius: BorderRadius.circular(
                                      AppTheme.of(context)
                                          .designToken
                                          .radius
                                          .md),
                                  border: Border.all(
                                    color: AppTheme.of(context)
                                        .alternate,
                                  ),
                                ),
                                child: Padding(
                                  padding:
                                      EdgeInsets.all(valueOrDefault<double>(
                                    AppConstants.parentPagePadding,
                                    0.0,
                                  )),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'SECURITY CHECK',
                                        style: AppTheme.of(context)
                                            .labelMedium
                                            .override(
                                              font: GoogleFonts.inter(
                                                fontWeight:
                                                    AppTheme.of(
                                                            context)
                                                        .labelMedium
                                                        .fontWeight,
                                                fontStyle:
                                                    AppTheme.of(
                                                            context)
                                                        .labelMedium
                                                        .fontStyle,
                                              ),
                                              letterSpacing: 0.0,
                                              fontWeight:
                                                  AppTheme.of(
                                                          context)
                                                      .labelMedium
                                                      .fontWeight,
                                              fontStyle:
                                                  AppTheme.of(
                                                          context)
                                                      .labelMedium
                                                      .fontStyle,
                                            ),
                                      ),
                                      Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Material(
                                            color: Colors.transparent,
                                            elevation: 0.0,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      AppTheme.of(
                                                              context)
                                                          .designToken
                                                          .radius
                                                          .sm),
                                            ),
                                            child: Container(
                                              width: 24.0,
                                              height: 24.0,
                                              decoration: BoxDecoration(
                                                color: AppTheme.of(
                                                        context)
                                                    .secondaryBackground,
                                                boxShadow: [
                                                  AppTheme.of(
                                                          context)
                                                      .designToken
                                                      .shadow
                                                      .sm
                                                ],
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        AppTheme.of(
                                                                context)
                                                            .designToken
                                                            .radius
                                                            .sm),
                                                border: Border.all(
                                                  color:
                                                      AppTheme.of(
                                                              context)
                                                          .alternate,
                                                ),
                                              ),
                                              child: Icon(
                                                Icons.check_circle,
                                                color: functions.hasMinLength(
                                                            _model
                                                                .passwordTextController
                                                                .text) ==
                                                        true
                                                    ? AppTheme.of(
                                                            context)
                                                        .primary
                                                    : AppTheme.of(
                                                            context)
                                                        .alternate,
                                                size: 16.0,
                                              ),
                                            ),
                                          ),
                                          Text(
                                            'At least 8 characters long',
                                            style: AppTheme.of(
                                                    context)
                                                .labelMedium
                                                .override(
                                                  font: GoogleFonts.inter(
                                                    fontWeight:
                                                        AppTheme.of(
                                                                context)
                                                            .labelMedium
                                                            .fontWeight,
                                                    fontStyle:
                                                        AppTheme.of(
                                                                context)
                                                            .labelMedium
                                                            .fontStyle,
                                                  ),
                                                  color: functions.hasMinLength(
                                                              _model
                                                                  .passwordTextController
                                                                  .text) ==
                                                          true
                                                      ? AppTheme.of(
                                                              context)
                                                          .primaryText
                                                      : AppTheme.of(
                                                              context)
                                                          .secondaryText,
                                                  letterSpacing: 0.0,
                                                  fontWeight:
                                                      AppTheme.of(
                                                              context)
                                                          .labelMedium
                                                          .fontWeight,
                                                  fontStyle:
                                                      AppTheme.of(
                                                              context)
                                                          .labelMedium
                                                          .fontStyle,
                                                ),
                                          ),
                                        ].divide(const SizedBox(
                                            width: AppConstants
                                                .childPadding)),
                                      ),
                                      Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Material(
                                            color: Colors.transparent,
                                            elevation: 0.0,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      AppTheme.of(
                                                              context)
                                                          .designToken
                                                          .radius
                                                          .sm),
                                            ),
                                            child: Container(
                                              width: 24.0,
                                              height: 24.0,
                                              decoration: BoxDecoration(
                                                color: AppTheme.of(
                                                        context)
                                                    .secondaryBackground,
                                                boxShadow: [
                                                  AppTheme.of(
                                                          context)
                                                      .designToken
                                                      .shadow
                                                      .sm
                                                ],
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        AppTheme.of(
                                                                context)
                                                            .designToken
                                                            .radius
                                                            .sm),
                                                border: Border.all(
                                                  color:
                                                      AppTheme.of(
                                                              context)
                                                          .alternate,
                                                ),
                                              ),
                                              child: Icon(
                                                Icons.check_circle,
                                                color: functions.hasNumberOrSymbol(
                                                            _model
                                                                .passwordTextController
                                                                .text) ==
                                                        true
                                                    ? AppTheme.of(
                                                            context)
                                                        .primary
                                                    : AppTheme.of(
                                                            context)
                                                        .alternate,
                                                size: 16.0,
                                              ),
                                            ),
                                          ),
                                          Text(
                                            'Must include a symbol or\nnumber',
                                            style: AppTheme.of(
                                                    context)
                                                .labelMedium
                                                .override(
                                                  font: GoogleFonts.inter(
                                                    fontWeight:
                                                        AppTheme.of(
                                                                context)
                                                            .labelMedium
                                                            .fontWeight,
                                                    fontStyle:
                                                        AppTheme.of(
                                                                context)
                                                            .labelMedium
                                                            .fontStyle,
                                                  ),
                                                  color: functions.hasNumberOrSymbol(
                                                              _model
                                                                  .passwordTextController
                                                                  .text) ==
                                                          true
                                                      ? AppTheme.of(
                                                              context)
                                                          .primaryText
                                                      : AppTheme.of(
                                                              context)
                                                          .secondaryText,
                                                  letterSpacing: 0.0,
                                                  fontWeight:
                                                      AppTheme.of(
                                                              context)
                                                          .labelMedium
                                                          .fontWeight,
                                                  fontStyle:
                                                      AppTheme.of(
                                                              context)
                                                          .labelMedium
                                                          .fontStyle,
                                                ),
                                          ),
                                        ].divide(const SizedBox(
                                            width: AppConstants
                                                .childPadding)),
                                      ),
                                      Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Material(
                                            color: Colors.transparent,
                                            elevation: 0.0,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      AppTheme.of(
                                                              context)
                                                          .designToken
                                                          .radius
                                                          .sm),
                                            ),
                                            child: Container(
                                              width: 24.0,
                                              height: 24.0,
                                              decoration: BoxDecoration(
                                                color: AppTheme.of(
                                                        context)
                                                    .secondaryBackground,
                                                boxShadow: [
                                                  AppTheme.of(
                                                          context)
                                                      .designToken
                                                      .shadow
                                                      .sm
                                                ],
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        AppTheme.of(
                                                                context)
                                                            .designToken
                                                            .radius
                                                            .sm),
                                                border: Border.all(
                                                  color:
                                                      AppTheme.of(
                                                              context)
                                                          .alternate,
                                                ),
                                              ),
                                              child: Icon(
                                                Icons.check_circle,
                                                color: (functions.hasLowercase(
                                                                _model
                                                                    .passwordTextController
                                                                    .text) ==
                                                            true) &&
                                                        (functions.hasUppercase(
                                                                _model
                                                                    .passwordTextController
                                                                    .text) ==
                                                            true)
                                                    ? AppTheme.of(
                                                            context)
                                                        .primary
                                                    : AppTheme.of(
                                                            context)
                                                        .alternate,
                                                size: 16.0,
                                              ),
                                            ),
                                          ),
                                          Text(
                                            'Upper and lowercase letters',
                                            style: AppTheme.of(
                                                    context)
                                                .labelMedium
                                                .override(
                                                  font: GoogleFonts.inter(
                                                    fontWeight:
                                                        AppTheme.of(
                                                                context)
                                                            .labelMedium
                                                            .fontWeight,
                                                    fontStyle:
                                                        AppTheme.of(
                                                                context)
                                                            .labelMedium
                                                            .fontStyle,
                                                  ),
                                                  color: (functions.hasLowercase(_model
                                                                  .passwordTextController
                                                                  .text) ==
                                                              true) &&
                                                          (functions.hasUppercase(_model
                                                                  .passwordTextController
                                                                  .text) ==
                                                              true)
                                                      ? AppTheme.of(
                                                              context)
                                                          .primaryText
                                                      : AppTheme.of(
                                                              context)
                                                          .secondaryText,
                                                  letterSpacing: 0.0,
                                                  fontWeight:
                                                      AppTheme.of(
                                                              context)
                                                          .labelMedium
                                                          .fontWeight,
                                                  fontStyle:
                                                      AppTheme.of(
                                                              context)
                                                          .labelMedium
                                                          .fontStyle,
                                                ),
                                          ),
                                        ].divide(const SizedBox(
                                            width: AppConstants
                                                .childPadding)),
                                      ),
                                    ].divide(SizedBox(
                                        height: AppTheme.of(context)
                                            .designToken
                                            .spacing
                                            .md)),
                                  ),
                                ),
                              ),
                            ),
                            AppButton(
                              onPressed: () async {
                                await action_blocks.tapFeedback(context);
                                _model.validationResult =
                                    await actions.isValidPassword(
                                  _model.passwordTextController.text,
                                );
                                if (_model.validationResult == true) {
                                  if (_model.passwordTextController.text ==
                                      _model.cPasswordTextController.text) {
                                    _model.resetPasswordError =
                                        await actions.resetPassword(
                                      _model.passwordTextController.text,
                                    );
                                    if (_model.resetPasswordError ==
                                        null) {
                                      await PasswordChangedSuccessPageWidget
                                          .show(context);
                                      if (context.mounted) {
                                        context
                                            .goNamed(LoginWidget.routeName);
                                      }
                                    } else if (context.mounted) {
                                      await actions.showToast(
                                        context,
                                        _model.resetPasswordError!,
                                        3,
                                      );
                                    }
                                  } else {
                                    await actions.showToast(
                                      context,
                                      'Passwords do not match.',
                                      2,
                                    );
                                  }
                                } else {
                                  await actions.showToast(
                                    context,
                                    'Password must be at least 8 characters and include an uppercase letter, a lowercase letter, and a number or symbol.',
                                    3,
                                  );
                                }
          
                                _provider.update(() {});
                              },
                              text: 'Reset Password',
                              options: AppButtonOptions(
                                width: 300.0,
                                height: 50.0,
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    16.0, 0.0, 16.0, 0.0),
                                iconAlignment: IconAlignment.end,
                                iconPadding: const EdgeInsetsDirectional.fromSTEB(
                                    0.0, 0.0, 0.0, 0.0),
                                color: AppTheme.of(context).primary,
                                textStyle: AppTheme.of(context)
                                    .titleSmall
                                    .override(
                                      font: GoogleFonts.inter(
                                        fontWeight:
                                            AppTheme.of(context)
                                                .titleSmall
                                                .fontWeight,
                                        fontStyle:
                                            AppTheme.of(context)
                                                .titleSmall
                                                .fontStyle,
                                      ),
                                      color: Colors.white,
                                      letterSpacing: 0.0,
                                      fontWeight:
                                          AppTheme.of(context)
                                              .titleSmall
                                              .fontWeight,
                                      fontStyle:
                                          AppTheme.of(context)
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
                          ]
                              .divide(const SizedBox(
                                  height: AppConstants.parentPagePadding))
                              .addToStart(const SizedBox(
                                  height: AppConstants.parentPagePadding))
                              .addToEnd(const SizedBox(height: 20.0)),
                        ),
                      ),
                    ),
                  ),
                ]
                    .divide(SizedBox(
                        height: AppTheme.of(context)
                            .designToken
                            .spacing
                            .md))
                    .addToEnd(const SizedBox(height: 60.0)),
                    ),
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
