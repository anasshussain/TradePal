import '/auth/supabase_auth/auth_util.dart';
import '/components/appbar_component/appbar_component_widget.dart';
import '/components/customer_navbar/customer_navbar_widget.dart';
import '/components/settings_component/settings_component_widget.dart';
import '/components/theme_picker/theme_picker_widget.dart';
import '/theme/app_theme.dart';
import '/core/util.dart';
import '/widgets/app_button.dart';
import 'dart:ui';
import '/actions/actions.dart' as action_blocks;
import '/index.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'customer_profile_model.dart';
export 'customer_profile_model.dart';

class CustomerProfileWidget extends StatefulWidget {
  const CustomerProfileWidget({super.key});

  static String routeName = 'customer_profile';
  static String routePath = '/customer_profile';

  @override
  State<CustomerProfileWidget> createState() => _CustomerProfileWidgetState();
}

class _CustomerProfileWidgetState extends State<CustomerProfileWidget> {
  late CustomerProfileModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => CustomerProfileModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<AppState>();

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
          title: wrapWithModel(
            model: _model.appbarComponentModel,
            updateCallback: () => safeSetState(() {}),
            child: AppbarComponentWidget(
              title: 'Profile',
              showAction: false,
              actionIcon: null,
              action: () async {},
            ),
          ),
          actions: [],
          centerTitle: false,
          elevation: 0.0,
        ),
        body: SafeArea(
          top: true,
          child: Stack(
            children: [
              Padding(
                padding: EdgeInsets.all(valueOrDefault<double>(
                  AppConstants.parentPagePadding,
                  0.0,
                )),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Stack(
                        alignment: AlignmentDirectional(0.0, 0.0),
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
                              width: 128.0,
                              height: 128.0,
                              decoration: BoxDecoration(
                                color: AppTheme.of(context)
                                    .secondaryBackground,
                                borderRadius: BorderRadius.circular(
                                    AppTheme.of(context)
                                        .designToken
                                        .radius
                                        .md),
                                border: Border.all(
                                  color: AppTheme.of(context).alternate,
                                  width: 2.0,
                                ),
                              ),
                            ),
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
                              width: 120.0,
                              height: 120.0,
                              decoration: BoxDecoration(
                                color: AppTheme.of(context)
                                    .secondaryBackground,
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: CachedNetworkImageProvider(
                                    AppState().userProfileCache.avatarUrl !=
                                                null &&
                                            AppState()
                                                    .userProfileCache
                                                    .avatarUrl !=
                                                ''
                                        ? AppState()
                                            .userProfileCache
                                            .avatarUrl
                                        : 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTpRGUcBVltEkFutN21fIqebRvrgP7fOv4CjcNwuka3BtXR_-jhpd7GheJ_RkvMtSsnsA8&usqp=CAU',
                                  ),
                                ),
                                borderRadius: BorderRadius.circular(
                                    AppTheme.of(context)
                                        .designToken
                                        .radius
                                        .md),
                                border: Border.all(
                                  color: Colors.white,
                                  width: 2.0,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Text(
                        valueOrDefault<String>(
                          AppState().userProfileCache.name,
                          'Guest user',
                        ),
                        style:
                            AppTheme.of(context).displaySmall.override(
                                  font: GoogleFonts.inter(
                                    fontWeight: FontWeight.w800,
                                    fontStyle: AppTheme.of(context)
                                        .displaySmall
                                        .fontStyle,
                                  ),
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.w800,
                                  fontStyle: AppTheme.of(context)
                                      .displaySmall
                                      .fontStyle,
                                ),
                      ),
                      AppButton(
                        onPressed: () async {
                          context.pushNamed(
                            EditCustomerProfieWidget.routeName,
                            extra: <String, dynamic>{
                              '__transition_info__': TransitionInfo(
                                hasTransition: true,
                                transitionType: PageTransitionType.rightToLeft,
                              ),
                            },
                          );
                        },
                        text: 'Edit Profile',
                        icon: Icon(
                          Icons.edit_rounded,
                          size: 26.0,
                        ),
                        options: AppButtonOptions(
                          width: 300.0,
                          height: 50.0,
                          padding: EdgeInsetsDirectional.fromSTEB(
                              16.0, 0.0, 16.0, 0.0),
                          iconPadding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 0.0, 0.0),
                          color: Colors.transparent,
                          textStyle:
                              AppTheme.of(context).titleSmall.override(
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
                      Align(
                        alignment: AlignmentDirectional(-1.0, -1.0),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0.0,
                              AppTheme.of(context)
                                  .designToken
                                  .spacing
                                  .lg,
                              0.0,
                              0.0),
                          child: Text(
                            'ACCOUNT DETAILS',
                            style: AppTheme.of(context)
                                .labelSmall
                                .override(
                                  font: GoogleFonts.inter(
                                    fontWeight: AppTheme.of(context)
                                        .labelSmall
                                        .fontWeight,
                                    fontStyle: AppTheme.of(context)
                                        .labelSmall
                                        .fontStyle,
                                  ),
                                  letterSpacing: 0.0,
                                  fontWeight: AppTheme.of(context)
                                      .labelSmall
                                      .fontWeight,
                                  fontStyle: AppTheme.of(context)
                                      .labelSmall
                                      .fontStyle,
                                ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            0.0,
                            AppTheme.of(context).designToken.spacing.md,
                            0.0,
                            0.0),
                        child: Material(
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
                                AppConstants.childPadding,
                                0.0,
                              )),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  wrapWithModel(
                                    model: _model.settingsComponentModel1,
                                    updateCallback: () => safeSetState(() {}),
                                    child: SettingsComponentWidget(
                                      icon: Icon(
                                        Icons.person_sharp,
                                        color:
                                            AppTheme.of(context).info,
                                      ),
                                      title: 'Personal information',
                                      description:
                                          'Name, email and contact details',
                                      showTrailingIcon: false,
                                      onTap: () async {
                                        context.pushNamed(
                                            EditCustomerProfieWidget.routeName);
                                      },
                                    ),
                                  ),
                                  Container(
                                    width: double.infinity,
                                    height: 1.0,
                                    decoration: BoxDecoration(
                                      color: AppTheme.of(context)
                                          .alternate,
                                    ),
                                  ),
                                  wrapWithModel(
                                    model: _model.settingsComponentModel2,
                                    updateCallback: () => safeSetState(() {}),
                                    child: SettingsComponentWidget(
                                      icon: Icon(
                                        Icons.credit_card_outlined,
                                        color:
                                            AppTheme.of(context).info,
                                      ),
                                      title: 'Payment methods',
                                      description:
                                          'Cards, transaction history and billing',
                                      showTrailingIcon: false,
                                      onTap: () async {},
                                    ),
                                  ),
                                ]
                                    .divide(SizedBox(
                                        height: AppConstants.childSpacing))
                                    .around(SizedBox(
                                        height: AppConstants.childSpacing)),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: AlignmentDirectional(-1.0, -1.0),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0.0,
                              AppTheme.of(context)
                                  .designToken
                                  .spacing
                                  .lg,
                              0.0,
                              0.0),
                          child: Text(
                            'MARKETPLACE ACTIVITY',
                            style: AppTheme.of(context)
                                .labelSmall
                                .override(
                                  font: GoogleFonts.inter(
                                    fontWeight: AppTheme.of(context)
                                        .labelSmall
                                        .fontWeight,
                                    fontStyle: AppTheme.of(context)
                                        .labelSmall
                                        .fontStyle,
                                  ),
                                  letterSpacing: 0.0,
                                  fontWeight: AppTheme.of(context)
                                      .labelSmall
                                      .fontWeight,
                                  fontStyle: AppTheme.of(context)
                                      .labelSmall
                                      .fontStyle,
                                ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            0.0,
                            AppTheme.of(context).designToken.spacing.md,
                            0.0,
                            0.0),
                        child: Material(
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
                                AppConstants.childPadding,
                                0.0,
                              )),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  wrapWithModel(
                                    model: _model.settingsComponentModel3,
                                    updateCallback: () => safeSetState(() {}),
                                    child: SettingsComponentWidget(
                                      icon: Icon(
                                        Icons.construction_rounded,
                                        color:
                                            AppTheme.of(context).info,
                                      ),
                                      title: 'My jobs',
                                      description:
                                          'Active, ongoing and completed jobs',
                                      showTrailingIcon: false,
                                      onTap: () async {
                                        context.pushNamed(
                                            CustomerAllJobsWidget.routeName);
                                      },
                                    ),
                                  ),
                                ].divide(SizedBox(
                                    height: AppConstants.childSpacing)),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: AlignmentDirectional(-1.0, -1.0),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0.0,
                              AppTheme.of(context)
                                  .designToken
                                  .spacing
                                  .lg,
                              0.0,
                              0.0),
                          child: Text(
                            'PREFERENCES & SECURITY',
                            style: AppTheme.of(context)
                                .labelSmall
                                .override(
                                  font: GoogleFonts.inter(
                                    fontWeight: AppTheme.of(context)
                                        .labelSmall
                                        .fontWeight,
                                    fontStyle: AppTheme.of(context)
                                        .labelSmall
                                        .fontStyle,
                                  ),
                                  letterSpacing: 0.0,
                                  fontWeight: AppTheme.of(context)
                                      .labelSmall
                                      .fontWeight,
                                  fontStyle: AppTheme.of(context)
                                      .labelSmall
                                      .fontStyle,
                                ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            0.0,
                            AppTheme.of(context).designToken.spacing.md,
                            0.0,
                            0.0),
                        child: Material(
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
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Padding(
                                  padding:
                                      EdgeInsets.all(valueOrDefault<double>(
                                    AppConstants.childPadding,
                                    0.0,
                                  )),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      wrapWithModel(
                                        model: _model.settingsComponentModel4,
                                        updateCallback: () =>
                                            safeSetState(() {}),
                                        child: SettingsComponentWidget(
                                          icon: Icon(
                                            Icons.notifications_sharp,
                                            color: AppTheme.of(context)
                                                .info,
                                          ),
                                          title: 'Notifications',
                                          description:
                                              'Push alerts and email settings',
                                          showTrailingIcon: false,
                                          onTap: () async {
                                            context.pushNamed(
                                                NotificationPageWidget
                                                    .routeName);
                                          },
                                        ),
                                      ),
                                      Divider(
                                        thickness: 1.0,
                                        color: AppTheme.of(context)
                                            .alternate,
                                      ),
                                      wrapWithModel(
                                        model: _model.settingsComponentModel5,
                                        updateCallback: () =>
                                            safeSetState(() {}),
                                        child: SettingsComponentWidget(
                                          icon: Icon(
                                            Icons.security,
                                            color: AppTheme.of(context)
                                                .info,
                                          ),
                                          title: 'Security',
                                          description:
                                              'Password, biometrics, 2FA',
                                          showTrailingIcon: false,
                                          onTap: () async {},
                                        ),
                                      ),
                                      Divider(
                                        thickness: 1.0,
                                        color: AppTheme.of(context)
                                            .alternate,
                                      ),
                                      wrapWithModel(
                                        model: _model.settingsComponentModel6,
                                        updateCallback: () =>
                                            safeSetState(() {}),
                                        child: SettingsComponentWidget(
                                          icon: Icon(
                                            Icons.password,
                                            color: AppTheme.of(context)
                                                .info,
                                          ),
                                          title: 'Change Password',
                                          description:
                                              'Update your password to keep your account secure.',
                                          showTrailingIcon: false,
                                          onTap: () async {
                                            context.pushNamed(
                                                ResetPasswordWidget.routeName);
                                          },
                                        ),
                                      ),
                                      Divider(
                                        thickness: 1.0,
                                        color: AppTheme.of(context)
                                            .alternate,
                                      ),
                                      wrapWithModel(
                                        model: _model.settingsComponentModel7,
                                        updateCallback: () =>
                                            safeSetState(() {}),
                                        child: SettingsComponentWidget(
                                          icon: Icon(
                                            Icons.help,
                                            color: AppTheme.of(context)
                                                .info,
                                          ),
                                          title: 'Help & Support',
                                          description:
                                              'FAQs, live chat, and guides',
                                          showTrailingIcon: false,
                                          onTap: () async {},
                                        ),
                                      ),
                                      Divider(
                                        thickness: 1.0,
                                        color: AppTheme.of(context)
                                            .alternate,
                                      ),
                                      Builder(
                                        builder: (context) => wrapWithModel(
                                          model: _model.settingsComponentModel8,
                                          updateCallback: () =>
                                              safeSetState(() {}),
                                          child: SettingsComponentWidget(
                                            icon: Icon(
                                              Icons.dark_mode_outlined,
                                              color:
                                                  AppTheme.of(context)
                                                      .info,
                                            ),
                                            title: 'Appearances',
                                            description: 'Dark or Light',
                                            showTrailingIcon: false,
                                            onTap: () async {
                                              await showDialog(
                                                context: context,
                                                builder: (dialogContext) {
                                                  return Dialog(
                                                    elevation: 0,
                                                    insetPadding:
                                                        EdgeInsets.zero,
                                                    backgroundColor:
                                                        Colors.transparent,
                                                    alignment:
                                                        AlignmentDirectional(
                                                                0.0, 0.0)
                                                            .resolve(
                                                                Directionality.of(
                                                                    context)),
                                                    child: GestureDetector(
                                                      onTap: () {
                                                        FocusScope.of(
                                                                dialogContext)
                                                            .unfocus();
                                                        FocusManager.instance
                                                            .primaryFocus
                                                            ?.unfocus();
                                                      },
                                                      child:
                                                          ThemePickerWidget(),
                                                    ),
                                                  );
                                                },
                                              );
                                            },
                                          ),
                                        ),
                                      ),
                                    ]
                                        .divide(SizedBox(
                                            height:
                                                AppConstants.childPadding))
                                        .around(SizedBox(
                                            height:
                                                AppConstants.childPadding)),
                                  ),
                                ),
                              ],
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
                          await action_blocks.deleteFcmFromBackend(context);
                          await action_blocks.clearAppData(context);
                          GoRouter.of(context).prepareAuthEvent();
                          await authManager.signOut();
                          GoRouter.of(context).clearRedirectLocation();

                          context.goNamedAuth(
                              SplashScreenWidget.routeName, context.mounted);
                        },
                        child: Container(
                          decoration: BoxDecoration(),
                          child: Padding(
                            padding: EdgeInsets.all(AppTheme.of(context)
                                .designToken
                                .spacing
                                .lg),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.logout,
                                  color: Color(0xFFBA1A1A),
                                  size: 24.0,
                                ),
                                Align(
                                  alignment: AlignmentDirectional(0.0, 0.0),
                                  child: Text(
                                    'LOGOUT FROM DEVICE',
                                    style: AppTheme.of(context)
                                        .titleSmall
                                        .override(
                                          font: GoogleFonts.manrope(
                                            fontWeight:
                                                AppTheme.of(context)
                                                    .titleSmall
                                                    .fontWeight,
                                            fontStyle:
                                                AppTheme.of(context)
                                                    .titleSmall
                                                    .fontStyle,
                                          ),
                                          color: Color(0xFFBA1A1A),
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
                                  ),
                                ),
                              ].divide(SizedBox(
                                  width: AppTheme.of(context)
                                      .designToken
                                      .spacing
                                      .md)),
                            ),
                          ),
                        ),
                      ),
                    ]
                        .divide(SizedBox(height: AppConstants.childSpacing))
                        .addToEnd(SizedBox(height: 50.0)),
                  ),
                ),
              ),
              Align(
                alignment: AlignmentDirectional(0.0, 1.0),
                child: wrapWithModel(
                  model: _model.customerNavbarModel,
                  updateCallback: () => safeSetState(() {}),
                  child: CustomerNavbarWidget(
                    selectedIndex: 2,
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
