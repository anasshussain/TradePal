import '/auth/supabase_auth/auth_util.dart';
import '/repositories/api_requests/api_calls.dart';
import '/widgets/components/applogo_component/applogo_component_widget.dart';
import '/core/theme/app_theme.dart';
import '/utils/util.dart';
import '/widgets/app_button.dart';
import 'dart:ui';
import '/utils/action_blocks/actions.dart' as action_blocks;
import '/utils/custom_code/actions/index.dart' as actions;
import '/core/routes/index.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '/providers/signup_provider.dart';
import '/viewmodels/signup_model.dart';
export '/viewmodels/signup_model.dart';

/// design me a create account and log in page which has a button that says
/// create account and a button that says log in.
///
/// Recovery email field and a save my email and password for faster log in
/// tick box and i agree to terms and services tick box
class SignupWidget extends StatefulWidget {
  const SignupWidget({super.key});

  static String routeName = 'signup';
  static String routePath = '/SignUp';

  @override
  State<SignupWidget> createState() => _SignupWidgetState();
}

class _SignupWidgetState extends State<SignupWidget> {
  late SignupModel _model;
  final SignupProvider _provider = SignupProvider();

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SignupModel());

    _model.fulNameTextController ??= TextEditingController();
    _model.fulNameFocusNode ??= FocusNode();

    _model.emailTextController ??= TextEditingController();
    _model.emailFocusNode ??= FocusNode();

    _model.phoneTextController ??= TextEditingController();
    _model.phoneFocusNode ??= FocusNode();

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
    context.watch<AppState>();

    return ChangeNotifierProvider<SignupProvider>.value(
      value: _provider,
      child: Consumer<SignupProvider>(
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
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding: EdgeInsets.all(valueOrDefault<double>(
                    AppConstants.parentPagePadding,
                    0.0,
                  )),
                  child: Material(
                    color: Colors.transparent,
                    elevation: 0.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          AppTheme.of(context).designToken.radius.lg),
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppTheme.of(context).secondaryBackground,
                        borderRadius: BorderRadius.circular(
                            AppTheme.of(context).designToken.radius.lg),
                        border: Border.all(
                          color: AppTheme.of(context).alternate,
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(valueOrDefault<double>(
                          AppConstants.childPadding,
                          0.0,
                        )),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            wrapWithModel(
                              model: _model.applogoComponentModel,
                              updateCallback: () => _provider.update(() {}),
                              child: const ApplogoComponentWidget(),
                            ),
                            Column(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  'Create an Account',
                                  textAlign: TextAlign.center,
                                  style: AppTheme.of(context)
                                      .headlineLarge
                                      .override(
                                        font: GoogleFonts.manrope(
                                          fontWeight: FontWeight.bold,
                                          fontStyle:
                                              AppTheme.of(context)
                                                  .headlineLarge
                                                  .fontStyle,
                                        ),
                                        letterSpacing: 0.0,
                                        fontWeight: FontWeight.bold,
                                        fontStyle: AppTheme.of(context)
                                            .headlineLarge
                                            .fontStyle,
                                      ),
                                ),
                                Text(
                                  'Start your journey in the Lounge today.',
                                  textAlign: TextAlign.center,
                                  style: AppTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        font: GoogleFonts.manrope(
                                          fontWeight:
                                              AppTheme.of(context)
                                                  .bodyMedium
                                                  .fontWeight,
                                          fontStyle:
                                              AppTheme.of(context)
                                                  .bodyMedium
                                                  .fontStyle,
                                        ),
                                        color: AppTheme.of(context)
                                            .secondaryText,
                                        letterSpacing: 0.0,
                                        fontWeight: AppTheme.of(context)
                                            .bodyMedium
                                            .fontWeight,
                                        fontStyle: AppTheme.of(context)
                                            .bodyMedium
                                            .fontStyle,
                                      ),
                                ),
                              ].divide(const SizedBox(height: 8.0)),
                            ),
                            Form(
                              key: _model.formKey,
                              autovalidateMode: AutovalidateMode.disabled,
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Column(
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'FULL NAME',
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
                                      TextFormField(
                                        controller:
                                            _model.fulNameTextController,
                                        focusNode: _model.fulNameFocusNode,
                                        autofocus: false,
                                        enabled: true,
                                        obscureText: false,
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
                                          hintText: 'Johnathan Doe',
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
                                        ),
                                        style: AppTheme.of(context)
                                            .bodyMedium
                                            .override(
                                              font: GoogleFonts.manrope(
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
                                            .fulNameTextControllerValidator
                                            .asValidator(context),
                                      ),
                                    ].divide(const SizedBox(
                                        height: AppConstants.childPadding)),
                                  ),
                                  Column(
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'EMAIL ADDRESS',
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
                                      TextFormField(
                                        controller: _model.emailTextController,
                                        focusNode: _model.emailFocusNode,
                                        autofocus: false,
                                        enabled: true,
                                        obscureText: false,
                                        decoration: InputDecoration(
                                          isDense: false,
                                          hintText: 'john@traderslounge.com',
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
                                            .emailTextControllerValidator
                                            .asValidator(context),
                                      ),
                                    ].divide(const SizedBox(
                                        height: AppConstants.childPadding)),
                                  ),
                                  Column(
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'PHONE NUMBER',
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
                                      TextFormField(
                                        controller: _model.phoneTextController,
                                        focusNode: _model.phoneFocusNode,
                                        autofocus: false,
                                        enabled: true,
                                        obscureText: false,
                                        decoration: InputDecoration(
                                          isDense: false,
                                          hintText: '+1 (555) 000-0000',
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
                                            .phoneTextControllerValidator
                                            .asValidator(context),
                                      ),
                                    ].divide(const SizedBox(
                                        height: AppConstants.childPadding)),
                                  ),
                                  Column(
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'PASSWORD',
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
                                      TextFormField(
                                        controller:
                                            _model.passwordTextController,
                                        focusNode: _model.passwordFocusNode,
                                        autofocus: false,
                                        enabled: true,
                                        obscureText: !_model.passwordVisibility,
                                        decoration: InputDecoration(
                                          isDense: false,
                                          hintText: '*************',
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
                                      Text(
                                        'CONFIRM PASSWORD',
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
                                      TextFormField(
                                        controller:
                                            _model.cPasswordTextController,
                                        focusNode: _model.cPasswordFocusNode,
                                        autofocus: false,
                                        enabled: true,
                                        obscureText:
                                            !_model.cPasswordVisibility,
                                        decoration: InputDecoration(
                                          isDense: false,
                                          hintText: '*************',
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
                                    ].divide(const SizedBox(
                                        height: AppConstants.childPadding)),
                                  ),
                                ].divide(const SizedBox(
                                    height: AppConstants.childSpacing)),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(
                                  AppTheme.of(context)
                                      .designToken
                                      .spacing
                                      .md),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Theme(
                                    data: ThemeData(
                                      checkboxTheme: CheckboxThemeData(
                                        visualDensity: VisualDensity.compact,
                                        materialTapTargetSize:
                                            MaterialTapTargetSize.shrinkWrap,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(4.0),
                                        ),
                                      ),
                                      unselectedWidgetColor:
                                          AppTheme.of(context)
                                              .secondaryText,
                                    ),
                                    child: Checkbox(
                                      value: _model.checkboxValue ??= false,
                                      onChanged: (newValue) async {
                                        _provider.update(() =>
                                            _model.checkboxValue = newValue!);
                                      },
                                      side: (AppTheme.of(context)
                                                  .secondaryText !=
                                              null)
                                          ? BorderSide(
                                              width: 2,
                                              color:
                                                  AppTheme.of(context)
                                                      .secondaryText!,
                                            )
                                          : null,
                                      activeColor:
                                          AppTheme.of(context).primary,
                                      checkColor:
                                          AppTheme.of(context).info,
                                    ),
                                  ),
                                  Flexible(
                                    child: Container(
                                      decoration: const BoxDecoration(),
                                      child: Text(
                                        'I agree to the Terms of Service and Privacy Policy. I understand that my data will be handled in accordance with these terms.',
                                        textAlign: TextAlign.start,
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
                                  ),
                                ].divide(const SizedBox(
                                    width: AppConstants.childPadding)),
                              ),
                            ),
                            AppButton(
                              onPressed: () async {
                                await action_blocks.tapFeedback(context);
                                _model.formResult = true;
                                if (_model.formKey.currentState == null ||
                                    !_model.formKey.currentState!.validate()) {
                                  _provider.update(() => _model.formResult = false);
                                  return;
                                }
                                if (_model.checkboxValue == true) {
                                  GoRouter.of(context).prepareAuthEvent();
                                  if (_model.passwordTextController.text !=
                                      _model.cPasswordTextController.text) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text(
                                          'Passwords don\'t match!',
                                        ),
                                      ),
                                    );
                                    return;
                                  }

                                  final user =
                                      await authManager.createAccountWithEmail(
                                    context,
                                    _model.emailTextController.text,
                                    _model.passwordTextController.text,
                                  );
                                  if (user == null) {
                                    return;
                                  }

                                  _model.verificationCodeResult =
                                      await SupabaseEdgeFunctionsGroup
                                          .sendOtpCall
                                          .call(
                                    email: _model.emailTextController.text,
                                  );

                                  _model.insertUserRowResult =
                                      await SupabaseTablesGroup.addNewUserCall
                                          .call(
                                    userId: currentUserUid,
                                    email: currentUserEmail,
                                    phoneNumber:
                                        _model.phoneTextController.text,
                                    fullName: _model.fulNameTextController.text,
                                    deviceToken:
                                        AppState().currentDeviceToken,
                                  );

                                  context.goNamedAuth(
                                      VerifyEmailWidget.routeName,
                                      context.mounted);

                                  _provider.update(() {
                                    _model.fulNameTextController?.clear();
                                    _model.emailTextController?.clear();
                                    _model.phoneTextController?.clear();
                                    _model.passwordTextController?.clear();
                                    _model.cPasswordTextController?.clear();
                                  });
                                  if (AppState().currentDeviceToken == null ||
                                      AppState().currentDeviceToken == '') {
                                    await action_blocks.getFcmToken(context);
                                  }
                                } else {
                                  await actions.showToast(
                                    context,
                                    'Please accept terms & privacy policy ',
                                    2,
                                  );
                                }

                                _provider.update(() {});
                              },
                              text: 'Create Account',
                              icon: const FaIcon(
                                FontAwesomeIcons.arrowRight,
                                size: 16.0,
                              ),
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
                          ].divide(const SizedBox(height: AppConstants.spacing)),
                        ),
                      ),
                    ),
                  ),
                ),
                InkWell(
                  splashColor: Colors.transparent,
                  focusColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: () async {
                    context.goNamed(
                      LoginWidget.routeName,
                      extra: <String, dynamic>{
                        '__transition_info__': const TransitionInfo(
                          hasTransition: true,
                          transitionType: PageTransitionType.fade,
                          duration: Duration(milliseconds: 250),
                        ),
                      },
                    );
                  },
                  child: Container(
                    height: 30.0,
                    decoration: const BoxDecoration(),
                    alignment: const AlignmentDirectional(0.0, 0.0),
                    child: RichText(
                      textScaler: MediaQuery.of(context).textScaler,
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: 'Already have an account? ',
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
                                  letterSpacing: 0.0,
                                  fontWeight: AppTheme.of(context)
                                      .bodyMedium
                                      .fontWeight,
                                  fontStyle: AppTheme.of(context)
                                      .bodyMedium
                                      .fontStyle,
                                ),
                          ),
                          TextSpan(
                            text: 'Sign In',
                            style: GoogleFonts.inter(
                              color: AppTheme.of(context).primary,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        ],
                        style: AppTheme.of(context).bodyMedium.override(
                              font: GoogleFonts.manrope(
                                fontWeight: AppTheme.of(context)
                                    .bodyMedium
                                    .fontWeight,
                                fontStyle: AppTheme.of(context)
                                    .bodyMedium
                                    .fontStyle,
                              ),
                              letterSpacing: 0.0,
                              fontWeight: AppTheme.of(context)
                                  .bodyMedium
                                  .fontWeight,
                              fontStyle: AppTheme.of(context)
                                  .bodyMedium
                                  .fontStyle,
                            ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
