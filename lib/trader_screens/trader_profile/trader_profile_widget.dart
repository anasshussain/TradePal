import '/auth/supabase_auth/auth_util.dart';
import '/widgets/components/appbar_component/appbar_component_widget.dart';
import '/widgets/components/settings_component/settings_component_widget.dart';
import '/widgets/components/theme_picker/theme_picker_widget.dart';
import '/widgets/components/tp_navbar/tp_navbar_widget.dart';
import '/widgets/app_choice_chips.dart';
import '/core/theme/app_theme.dart';
import '/utils/util.dart';
import '/widgets/app_button.dart';
import '/core/form_field_controller.dart';
import '/utils/action_blocks/actions.dart' as action_blocks;
import '/core/routes/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '/viewmodels/trader_profile_model.dart';
export '/viewmodels/trader_profile_model.dart';

class TraderProfileWidget extends StatefulWidget {
  const TraderProfileWidget({super.key});

  static String routeName = 'trader_profile';
  static String routePath = '/traderProfile';

  @override
  State<TraderProfileWidget> createState() => _TraderProfileWidgetState();
}

class _TraderProfileWidgetState extends State<TraderProfileWidget> {
  late TraderProfileModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => TraderProfileModel());

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
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: Image.network(
                                    AppState().userProfileCache.avatarUrl,
                                  ).image,
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
                          Align(
                            alignment: AlignmentDirectional(0.28, 0.0),
                            child: Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 95.0, 0.0, 0.0),
                              child: Material(
                                color: Colors.transparent,
                                elevation: 0.0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      valueOrDefault<double>(
                                    AppConstants.radius1,
                                    0.0,
                                  )),
                                ),
                                child: Container(
                                  width: 30.0,
                                  height: 30.0,
                                  decoration: BoxDecoration(
                                    color: AppTheme.of(context).primary,
                                    borderRadius: BorderRadius.circular(
                                        valueOrDefault<double>(
                                      AppConstants.radius1,
                                      0.0,
                                    )),
                                  ),
                                  alignment: AlignmentDirectional(0.0, 0.0),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(0.0),
                                    child: SvgPicture.asset(
                                      'assets/images/star.svg',
                                      width: 16.0,
                                      height: 16.0,
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Text(
                        valueOrDefault<String>(
                          AppState().userProfileCache.name,
                          'user name',
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
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            0.0,
                            0.0,
                            0.0,
                            AppTheme.of(context)
                                .designToken
                                .spacing
                                .md),
                        child: AppButton(
                          onPressed: () async {
                            context
                                .pushNamed(EditTraderProfileWidget.routeName);
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
                      ),
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
                              AppConstants.childPadding,
                              0.0,
                            )),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Personal Details',
                                  style: AppTheme.of(context)
                                      .titleMedium
                                      .override(
                                        font: GoogleFonts.manrope(
                                          fontWeight: FontWeight.bold,
                                          fontStyle:
                                              AppTheme.of(context)
                                                  .titleMedium
                                                  .fontStyle,
                                        ),
                                        letterSpacing: 0.0,
                                        fontWeight: FontWeight.bold,
                                        fontStyle: AppTheme.of(context)
                                            .titleMedium
                                            .fontStyle,
                                      ),
                                ),
                                Column(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'FULL NAME',
                                      style: AppTheme.of(context)
                                          .labelSmall
                                          .override(
                                            font: GoogleFonts.inter(
                                              fontWeight: FontWeight.bold,
                                              fontStyle:
                                                  AppTheme.of(context)
                                                      .labelSmall
                                                      .fontStyle,
                                            ),
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.bold,
                                            fontStyle:
                                                AppTheme.of(context)
                                                    .labelSmall
                                                    .fontStyle,
                                          ),
                                    ),
                                    Text(
                                      valueOrDefault<String>(
                                        AppState().userProfileCache.name,
                                        'name',
                                      ),
                                      style: AppTheme.of(context)
                                          .bodyLarge
                                          .override(
                                            font: GoogleFonts.manrope(
                                              fontWeight: FontWeight.w500,
                                              fontStyle:
                                                  AppTheme.of(context)
                                                      .bodyLarge
                                                      .fontStyle,
                                            ),
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.w500,
                                            fontStyle:
                                                AppTheme.of(context)
                                                    .bodyLarge
                                                    .fontStyle,
                                          ),
                                    ),
                                  ],
                                ),
                                if (AppState().userProfileCache.profession !=
                                        null &&
                                    AppState().userProfileCache.profession !=
                                        '')
                                  Column(
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'REGISTRATION NUMBER',
                                        style: AppTheme.of(context)
                                            .labelSmall
                                            .override(
                                              font: GoogleFonts.inter(
                                                fontWeight: FontWeight.bold,
                                                fontStyle:
                                                    AppTheme.of(context)
                                                        .labelSmall
                                                        .fontStyle,
                                              ),
                                              letterSpacing: 0.0,
                                              fontWeight: FontWeight.bold,
                                              fontStyle:
                                                  AppTheme.of(context)
                                                      .labelSmall
                                                      .fontStyle,
                                            ),
                                      ),
                                      Text(
                                        valueOrDefault<String>(
                                          AppState()
                                              .userProfileCache
                                              .registrationNumber,
                                          'reg no',
                                        ),
                                        style: AppTheme.of(context)
                                            .bodyLarge
                                            .override(
                                              font: GoogleFonts.manrope(
                                                fontWeight: FontWeight.w500,
                                                fontStyle:
                                                    AppTheme.of(context)
                                                        .bodyLarge
                                                        .fontStyle,
                                              ),
                                              letterSpacing: 0.0,
                                              fontWeight: FontWeight.w500,
                                              fontStyle:
                                                  AppTheme.of(context)
                                                      .bodyLarge
                                                      .fontStyle,
                                            ),
                                      ),
                                    ],
                                  ),
                                if (AppState().userProfileCache.serviceArea !=
                                        null &&
                                    AppState().userProfileCache.serviceArea !=
                                        '')
                                  Column(
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'SERVICE AREA',
                                        style: AppTheme.of(context)
                                            .labelSmall
                                            .override(
                                              font: GoogleFonts.inter(
                                                fontWeight: FontWeight.bold,
                                                fontStyle:
                                                    AppTheme.of(context)
                                                        .labelSmall
                                                        .fontStyle,
                                              ),
                                              letterSpacing: 0.0,
                                              fontWeight: FontWeight.bold,
                                              fontStyle:
                                                  AppTheme.of(context)
                                                      .labelSmall
                                                      .fontStyle,
                                            ),
                                      ),
                                      Text(
                                        valueOrDefault<String>(
                                          AppState()
                                              .userProfileCache
                                              .serviceArea,
                                          'service area',
                                        ),
                                        style: AppTheme.of(context)
                                            .bodyLarge
                                            .override(
                                              font: GoogleFonts.manrope(
                                                fontWeight: FontWeight.w500,
                                                fontStyle:
                                                    AppTheme.of(context)
                                                        .bodyLarge
                                                        .fontStyle,
                                              ),
                                              letterSpacing: 0.0,
                                              fontWeight: FontWeight.w500,
                                              fontStyle:
                                                  AppTheme.of(context)
                                                      .bodyLarge
                                                      .fontStyle,
                                            ),
                                      ),
                                    ],
                                  ),
                                if (AppState().userProfileCache.phone !=
                                        null &&
                                    AppState().userProfileCache.phone != '')
                                  Column(
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'PHONE',
                                        style: AppTheme.of(context)
                                            .labelSmall
                                            .override(
                                              font: GoogleFonts.inter(
                                                fontWeight: FontWeight.bold,
                                                fontStyle:
                                                    AppTheme.of(context)
                                                        .labelSmall
                                                        .fontStyle,
                                              ),
                                              letterSpacing: 0.0,
                                              fontWeight: FontWeight.bold,
                                              fontStyle:
                                                  AppTheme.of(context)
                                                      .labelSmall
                                                      .fontStyle,
                                            ),
                                      ),
                                      Text(
                                        valueOrDefault<String>(
                                          AppState().userProfileCache.phone,
                                          'Phone',
                                        ),
                                        style: AppTheme.of(context)
                                            .bodyLarge
                                            .override(
                                              font: GoogleFonts.manrope(
                                                fontWeight: FontWeight.w500,
                                                fontStyle:
                                                    AppTheme.of(context)
                                                        .bodyLarge
                                                        .fontStyle,
                                              ),
                                              letterSpacing: 0.0,
                                              fontWeight: FontWeight.w500,
                                              fontStyle:
                                                  AppTheme.of(context)
                                                      .bodyLarge
                                                      .fontStyle,
                                            ),
                                      ),
                                    ],
                                  ),
                              ].divide(SizedBox(
                                  height: AppConstants.childSpacing)),
                            ),
                          ),
                        ),
                      ),
                      if (responsiveVisibility(
                        context: context,
                        phone: false,
                        tablet: false,
                        tabletLandscape: false,
                        desktop: false,
                      ))
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
                              color: AppTheme.of(context).primary,
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
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0.0,
                                        AppTheme.of(context)
                                            .designToken
                                            .spacing
                                            .lg,
                                        0.0,
                                        0.0),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(8.0),
                                      child: SvgPicture.asset(
                                        'assets/images/card.svg',
                                        width: 22.0,
                                        height: 22.0,
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0.0,
                                        AppTheme.of(context)
                                            .designToken
                                            .spacing
                                            .md,
                                        0.0,
                                        0.0),
                                    child: Text(
                                      'Earnings Dashboard',
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
                                            color: Colors.white,
                                            letterSpacing: 0.0,
                                            fontWeight:
                                                AppTheme.of(context)
                                                    .titleMedium
                                                    .fontWeight,
                                            fontStyle:
                                                AppTheme.of(context)
                                                    .titleMedium
                                                    .fontStyle,
                                          ),
                                    ),
                                  ),
                                  Opacity(
                                    opacity: 0.8,
                                    child: Text(
                                      'View your recent payouts and financial analytics.',
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
                                            color: Colors.white,
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
                                  ),
                                  Opacity(
                                    opacity: 0.8,
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
                                        'CURRENT BALANCE',
                                        style: AppTheme.of(context)
                                            .labelSmall
                                            .override(
                                              font: GoogleFonts.inter(
                                                fontWeight:
                                                    AppTheme.of(context)
                                                        .labelSmall
                                                        .fontWeight,
                                                fontStyle:
                                                    AppTheme.of(context)
                                                        .labelSmall
                                                        .fontStyle,
                                              ),
                                              color: Colors.white,
                                              letterSpacing: 0.0,
                                              fontWeight:
                                                  AppTheme.of(context)
                                                      .labelSmall
                                                      .fontWeight,
                                              fontStyle:
                                                  AppTheme.of(context)
                                                      .labelSmall
                                                      .fontStyle,
                                            ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0.0,
                                        AppTheme.of(context)
                                            .designToken
                                            .spacing
                                            .sm,
                                        0.0,
                                        AppTheme.of(context)
                                            .designToken
                                            .spacing
                                            .md),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        RichText(
                                          textScaler:
                                              MediaQuery.of(context).textScaler,
                                          text: TextSpan(
                                            children: [
                                              TextSpan(
                                                text: '£',
                                                style: AppTheme.of(
                                                        context)
                                                    .headlineLarge
                                                    .override(
                                                      font: GoogleFonts.manrope(
                                                        fontWeight:
                                                            AppTheme.of(
                                                                    context)
                                                                .headlineLarge
                                                                .fontWeight,
                                                        fontStyle:
                                                            AppTheme.of(
                                                                    context)
                                                                .headlineLarge
                                                                .fontStyle,
                                                      ),
                                                      color: Colors.white,
                                                      fontSize: 30.0,
                                                      letterSpacing: 0.0,
                                                      fontWeight:
                                                          AppTheme.of(
                                                                  context)
                                                              .headlineLarge
                                                              .fontWeight,
                                                      fontStyle:
                                                          AppTheme.of(
                                                                  context)
                                                              .headlineLarge
                                                              .fontStyle,
                                                    ),
                                              ),
                                              TextSpan(
                                                text: '2,450.00',
                                                style: TextStyle(),
                                              )
                                            ],
                                            style: AppTheme.of(context)
                                                .headlineLarge
                                                .override(
                                                  font: GoogleFonts.manrope(
                                                    fontWeight:
                                                        AppTheme.of(
                                                                context)
                                                            .headlineLarge
                                                            .fontWeight,
                                                    fontStyle:
                                                        AppTheme.of(
                                                                context)
                                                            .headlineLarge
                                                            .fontStyle,
                                                  ),
                                                  color: Colors.white,
                                                  fontSize: 30.0,
                                                  letterSpacing: 0.0,
                                                  fontWeight:
                                                      AppTheme.of(
                                                              context)
                                                          .headlineLarge
                                                          .fontWeight,
                                                  fontStyle:
                                                      AppTheme.of(
                                                              context)
                                                          .headlineLarge
                                                          .fontStyle,
                                                ),
                                          ),
                                        ),
                                        Align(
                                          alignment:
                                              AlignmentDirectional(0.32, 0.0),
                                          child: Material(
                                            color: Colors.transparent,
                                            elevation: 0.0,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      valueOrDefault<double>(
                                                AppConstants.radius1,
                                                0.0,
                                              )),
                                            ),
                                            child: Container(
                                              width: 40.0,
                                              height: 40.0,
                                              decoration: BoxDecoration(
                                                color:
                                                    AppTheme.of(context)
                                                        .secondary,
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        valueOrDefault<double>(
                                                  AppConstants.radius1,
                                                  0.0,
                                                )),
                                              ),
                                              alignment: AlignmentDirectional(
                                                  0.0, 0.0),
                                              child: Icon(
                                                Icons.arrow_forward_ios,
                                                color: Colors.white,
                                                size: 14.0,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ].divide(SizedBox(
                                    height: AppTheme.of(context)
                                        .designToken
                                        .spacing
                                        .sm)),
                              ),
                            ),
                          ),
                        ),
                      if (AppState().userProfileCache.skills.isNotEmpty)
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0.0,
                              AppTheme.of(context)
                                  .designToken
                                  .spacing
                                  .md,
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0.0,
                                          AppTheme.of(context)
                                              .designToken
                                              .spacing
                                              .lg,
                                          0.0,
                                          0.0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                            child: SvgPicture.asset(
                                              'assets/images/compas.svg',
                                              width: 22.0,
                                              height: 22.0,
                                              fit: BoxFit.contain,
                                            ),
                                          ),
                                          Text(
                                            'Skills & Expertise',
                                            style: AppTheme.of(context)
                                                .titleMedium
                                                .override(
                                                  font: GoogleFonts.manrope(
                                                    fontWeight:
                                                        AppTheme.of(
                                                                context)
                                                            .titleMedium
                                                            .fontWeight,
                                                    fontStyle:
                                                        AppTheme.of(
                                                                context)
                                                            .titleMedium
                                                            .fontStyle,
                                                  ),
                                                  letterSpacing: 0.0,
                                                  fontWeight:
                                                      AppTheme.of(
                                                              context)
                                                          .titleMedium
                                                          .fontWeight,
                                                  fontStyle:
                                                      AppTheme.of(
                                                              context)
                                                          .titleMedium
                                                          .fontStyle,
                                                ),
                                          ),
                                        ].divide(SizedBox(
                                            width: AppTheme.of(context)
                                                .designToken
                                                .spacing
                                                .sm)),
                                      ),
                                    ),
                                    AppChoiceChips(
                                      options: AppState()
                                          .userProfileCache
                                          .skills
                                          .map((label) => ChipData(label))
                                          .toList(),
                                      onChanged: (val) => safeSetState(() =>
                                          _model.choiceChipsValue =
                                              val?.firstOrNull),
                                      selectedChipStyle: ChipStyle(
                                        backgroundColor:
                                            AppTheme.of(context)
                                                .secondaryBackground,
                                        textStyle: AppTheme.of(context)
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
                                              color:
                                                  AppTheme.of(context)
                                                      .secondaryText,
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
                                        iconColor: Colors.transparent,
                                        iconSize: 16.0,
                                        elevation: 0.0,
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      ),
                                      unselectedChipStyle: ChipStyle(
                                        backgroundColor:
                                            AppTheme.of(context)
                                                .secondaryBackground,
                                        textStyle: AppTheme.of(context)
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
                                              color:
                                                  AppTheme.of(context)
                                                      .secondaryText,
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
                                        iconColor: Colors.transparent,
                                        iconSize: 16.0,
                                        elevation: 0.0,
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      ),
                                      chipSpacing: 8.0,
                                      rowSpacing: 8.0,
                                      multiselect: false,
                                      alignment: WrapAlignment.start,
                                      controller:
                                          _model.choiceChipsValueController ??=
                                              FormFieldController<List<String>>(
                                        [],
                                      ),
                                      wrapped: true,
                                    ),
                                  ].divide(SizedBox(
                                      height: AppTheme.of(context)
                                          .designToken
                                          .spacing
                                          .sm)),
                                ),
                              ),
                            ),
                          ),
                        ),
                      if (AppState().userProfileCache.insuranceCompany !=
                              null &&
                          AppState().userProfileCache.insuranceCompany != '')
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0.0,
                              AppTheme.of(context)
                                  .designToken
                                  .spacing
                                  .md,
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
                              height: 218.0,
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
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: 8.0,
                                    height: 218.0,
                                    decoration: BoxDecoration(
                                      color:
                                          AppTheme.of(context).primary,
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(8.0),
                                        bottomLeft: Radius.circular(8.0),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding:
                                          EdgeInsets.all(valueOrDefault<double>(
                                        AppConstants.childPadding,
                                        0.0,
                                      )),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Row(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8.0),
                                                    child: SvgPicture.asset(
                                                      'assets/images/guard.svg',
                                                      width: 22.0,
                                                      height: 22.0,
                                                      fit: BoxFit.contain,
                                                    ),
                                                  ),
                                                  Text(
                                                    'Insurance Status',
                                                    style: AppTheme.of(
                                                            context)
                                                        .titleMedium
                                                        .override(
                                                          font: GoogleFonts
                                                              .manrope(
                                                            fontWeight:
                                                                AppTheme.of(
                                                                        context)
                                                                    .titleMedium
                                                                    .fontWeight,
                                                            fontStyle:
                                                                AppTheme.of(
                                                                        context)
                                                                    .titleMedium
                                                                    .fontStyle,
                                                          ),
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              AppTheme.of(
                                                                      context)
                                                                  .titleMedium
                                                                  .fontWeight,
                                                          fontStyle:
                                                              AppTheme.of(
                                                                      context)
                                                                  .titleMedium
                                                                  .fontStyle,
                                                        ),
                                                  ),
                                                ].divide(SizedBox(
                                                    width: AppTheme.of(
                                                            context)
                                                        .designToken
                                                        .spacing
                                                        .sm)),
                                              ),
                                              Container(
                                                width: 54.0,
                                                height: 19.0,
                                                decoration: BoxDecoration(
                                                  color: AppTheme.of(
                                                          context)
                                                      .primary,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          AppTheme.of(
                                                                  context)
                                                              .designToken
                                                              .radius
                                                              .sm),
                                                ),
                                                child: Align(
                                                  alignment:
                                                      AlignmentDirectional(
                                                          0.0, 0.0),
                                                  child: Text(
                                                    'ACTIVE',
                                                    style: AppTheme.of(
                                                            context)
                                                        .bodySmall
                                                        .override(
                                                          font: GoogleFonts
                                                              .manrope(
                                                            fontWeight:
                                                                AppTheme.of(
                                                                        context)
                                                                    .bodySmall
                                                                    .fontWeight,
                                                            fontStyle:
                                                                AppTheme.of(
                                                                        context)
                                                                    .bodySmall
                                                                    .fontStyle,
                                                          ),
                                                          color:
                                                              Color(0xFFF8F7FF),
                                                          fontSize: 10.0,
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              AppTheme.of(
                                                                      context)
                                                                  .bodySmall
                                                                  .fontWeight,
                                                          fontStyle:
                                                              AppTheme.of(
                                                                      context)
                                                                  .bodySmall
                                                                  .fontStyle,
                                                        ),
                                                  ),
                                                ),
                                              ),
                                            ].divide(SizedBox(
                                                width:
                                                    AppTheme.of(context)
                                                        .designToken
                                                        .spacing
                                                        .sm)),
                                          ),
                                          Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Text(
                                                'Provider',
                                                style:
                                                    AppTheme.of(context)
                                                        .labelMedium
                                                        .override(
                                                          font:
                                                              GoogleFonts.inter(
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
                                              Text(
                                                AppState()
                                                    .userProfileCache
                                                    .insuranceCompany,
                                                style: AppTheme.of(
                                                        context)
                                                    .titleSmall
                                                    .override(
                                                      font: GoogleFonts.manrope(
                                                        fontWeight:
                                                            AppTheme.of(
                                                                    context)
                                                                .titleSmall
                                                                .fontWeight,
                                                        fontStyle:
                                                            AppTheme.of(
                                                                    context)
                                                                .titleSmall
                                                                .fontStyle,
                                                      ),
                                                      fontSize: 14.0,
                                                      letterSpacing: 0.0,
                                                      fontWeight:
                                                          AppTheme.of(
                                                                  context)
                                                              .titleSmall
                                                              .fontWeight,
                                                      fontStyle:
                                                          AppTheme.of(
                                                                  context)
                                                              .titleSmall
                                                              .fontStyle,
                                                    ),
                                              ),
                                            ],
                                          ),
                                          Divider(
                                            thickness: 1.0,
                                            color: AppTheme.of(context)
                                                .alternate,
                                          ),
                                          Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Text(
                                                'Coverage',
                                                style:
                                                    AppTheme.of(context)
                                                        .labelMedium
                                                        .override(
                                                          font:
                                                              GoogleFonts.inter(
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
                                              RichText(
                                                textScaler:
                                                    MediaQuery.of(context)
                                                        .textScaler,
                                                text: TextSpan(
                                                  children: [
                                                    TextSpan(
                                                      text: '£',
                                                      style:
                                                          AppTheme.of(
                                                                  context)
                                                              .titleSmall
                                                              .override(
                                                                font: GoogleFonts
                                                                    .manrope(
                                                                  fontWeight: AppTheme.of(
                                                                          context)
                                                                      .titleSmall
                                                                      .fontWeight,
                                                                  fontStyle: AppTheme.of(
                                                                          context)
                                                                      .titleSmall
                                                                      .fontStyle,
                                                                ),
                                                                fontSize: 14.0,
                                                                letterSpacing:
                                                                    0.0,
                                                                fontWeight: AppTheme.of(
                                                                        context)
                                                                    .titleSmall
                                                                    .fontWeight,
                                                                fontStyle: AppTheme.of(
                                                                        context)
                                                                    .titleSmall
                                                                    .fontStyle,
                                                              ),
                                                    ),
                                                    TextSpan(
                                                      text: AppState()
                                                          .userProfileCache
                                                          .insuranceAmount,
                                                      style: TextStyle(),
                                                    )
                                                  ],
                                                  style: AppTheme.of(
                                                          context)
                                                      .titleSmall
                                                      .override(
                                                        font:
                                                            GoogleFonts.manrope(
                                                          fontWeight:
                                                              AppTheme.of(
                                                                      context)
                                                                  .titleSmall
                                                                  .fontWeight,
                                                          fontStyle:
                                                              AppTheme.of(
                                                                      context)
                                                                  .titleSmall
                                                                  .fontStyle,
                                                        ),
                                                        fontSize: 14.0,
                                                        letterSpacing: 0.0,
                                                        fontWeight:
                                                            AppTheme.of(
                                                                    context)
                                                                .titleSmall
                                                                .fontWeight,
                                                        fontStyle:
                                                            AppTheme.of(
                                                                    context)
                                                                .titleSmall
                                                                .fontStyle,
                                                      ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Divider(
                                            thickness: 1.0,
                                            color: AppTheme.of(context)
                                                .alternate,
                                          ),
                                          Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Text(
                                                'Expires',
                                                style:
                                                    AppTheme.of(context)
                                                        .labelMedium
                                                        .override(
                                                          font:
                                                              GoogleFonts.inter(
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
                                              Text(
                                                AppState()
                                                    .userProfileCache
                                                    .insuranceExpiry,
                                                style: AppTheme.of(
                                                        context)
                                                    .titleSmall
                                                    .override(
                                                      font: GoogleFonts.manrope(
                                                        fontWeight:
                                                            AppTheme.of(
                                                                    context)
                                                                .titleSmall
                                                                .fontWeight,
                                                        fontStyle:
                                                            AppTheme.of(
                                                                    context)
                                                                .titleSmall
                                                                .fontStyle,
                                                      ),
                                                      fontSize: 14.0,
                                                      letterSpacing: 0.0,
                                                      fontWeight:
                                                          AppTheme.of(
                                                                  context)
                                                              .titleSmall
                                                              .fontWeight,
                                                      fontStyle:
                                                          AppTheme.of(
                                                                  context)
                                                              .titleSmall
                                                              .fontStyle,
                                                    ),
                                              ),
                                            ],
                                          ),
                                          Divider(
                                            thickness: 1.0,
                                            color: AppTheme.of(context)
                                                .alternate,
                                          ),
                                        ].divide(SizedBox(
                                            height: AppTheme.of(context)
                                                .designToken
                                                .spacing
                                                .md)),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      if (responsiveVisibility(
                        context: context,
                        phone: false,
                        tablet: false,
                        tabletLandscape: false,
                        desktop: false,
                      ))
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
                                AppConstants.childPadding,
                                0.0,
                              )),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0.0,
                                        AppTheme.of(context)
                                            .designToken
                                            .spacing
                                            .lg,
                                        0.0,
                                        0.0),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Portfolio\nHighlights',
                                          style: AppTheme.of(context)
                                              .titleLarge
                                              .override(
                                                font: GoogleFonts.manrope(
                                                  fontWeight:
                                                      AppTheme.of(
                                                              context)
                                                          .titleLarge
                                                          .fontWeight,
                                                  fontStyle:
                                                      AppTheme.of(
                                                              context)
                                                          .titleLarge
                                                          .fontStyle,
                                                ),
                                                fontSize: 20.0,
                                                letterSpacing: 0.0,
                                                fontWeight:
                                                    AppTheme.of(context)
                                                        .titleLarge
                                                        .fontWeight,
                                                fontStyle:
                                                    AppTheme.of(context)
                                                        .titleLarge
                                                        .fontStyle,
                                              ),
                                        ),
                                        Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                              child: SvgPicture.asset(
                                                'assets/images/upload.svg',
                                                width: 12.0,
                                                height: 12.0,
                                                fit: BoxFit.contain,
                                              ),
                                            ),
                                            Text(
                                              'MANAGE\nGALLERY',
                                              style: AppTheme.of(
                                                      context)
                                                  .bodyMedium
                                                  .override(
                                                    font: GoogleFonts.manrope(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontStyle:
                                                          AppTheme.of(
                                                                  context)
                                                              .bodyMedium
                                                              .fontStyle,
                                                    ),
                                                    color: Color(0xFF214FC7),
                                                    letterSpacing: 0.0,
                                                    fontWeight: FontWeight.w600,
                                                    fontStyle:
                                                        AppTheme.of(
                                                                context)
                                                            .bodyMedium
                                                            .fontStyle,
                                                  ),
                                            ),
                                          ]
                                              .divide(SizedBox(
                                                  width: AppTheme.of(
                                                          context)
                                                      .designToken
                                                      .spacing
                                                      .lg))
                                              .around(SizedBox(
                                                  width: AppTheme.of(
                                                          context)
                                                      .designToken
                                                      .spacing
                                                      .lg)),
                                        ),
                                      ].divide(SizedBox(
                                          width: AppTheme.of(context)
                                              .designToken
                                              .spacing
                                              .sm)),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0.0,
                                        AppTheme.of(context)
                                            .designToken
                                            .spacing
                                            .lg,
                                        0.0,
                                        0.0),
                                    child: Builder(
                                      builder: (context) {
                                        final image = _model.images.toList();

                                        return GridView.builder(
                                          padding: EdgeInsets.zero,
                                          gridDelegate:
                                             const SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 2,
                                            crossAxisSpacing: 12.0,
                                            mainAxisSpacing: 12.0,
                                            childAspectRatio: 1.15,
                                          ),
                                          primary: false,
                                          shrinkWrap: true,
                                          scrollDirection: Axis.vertical,
                                          itemCount: image.length,
                                          itemBuilder: (context, imageIndex) {
                                            final imageItem = image[imageIndex];
                                            return ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                              child: Image.network(
                                                'https://images.pexels.com/photos/36815599/pexels-photo-36815599.jpeg',
                                                width: 131.0,
                                                fit: BoxFit.cover,
                                              ),
                                            );
                                          },
                                        );
                                      },
                                    ),
                                  ),
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
                                            .lg),
                                    child: InkWell(
                                      splashColor: Colors.transparent,
                                      focusColor: Colors.transparent,
                                      hoverColor: Colors.transparent,
                                      highlightColor: Colors.transparent,
                                      onTap: () async {
                                        _model.addToImages('1');
                                        safeSetState(() {});
                                      },
                                      child: Container(
                                        width: 131.0,
                                        height: 120.0,
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
                                                .border,
                                            width: 1.0,
                                          ),
                                        ),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Icon(
                                              Icons.camera_enhance,
                                              color:
                                                  AppTheme.of(context)
                                                      .primaryText,
                                              size: 24.0,
                                            ),
                                            Text(
                                              'ADD PROJECT',
                                              style:
                                                  AppTheme.of(context)
                                                      .labelSmall
                                                      .override(
                                                        font: GoogleFonts.inter(
                                                          fontWeight:
                                                              AppTheme.of(
                                                                      context)
                                                                  .labelSmall
                                                                  .fontWeight,
                                                          fontStyle:
                                                              AppTheme.of(
                                                                      context)
                                                                  .labelSmall
                                                                  .fontStyle,
                                                        ),
                                                        letterSpacing: 0.0,
                                                        fontWeight:
                                                            AppTheme.of(
                                                                    context)
                                                                .labelSmall
                                                                .fontWeight,
                                                        fontStyle:
                                                            AppTheme.of(
                                                                    context)
                                                                .labelSmall
                                                                .fontStyle,
                                                      ),
                                            ),
                                          ].divide(SizedBox(
                                              height:
                                                  AppTheme.of(context)
                                                      .designToken
                                                      .spacing
                                                      .sm)),
                                        ),
                                      ),
                                    ),
                                  ),
                                ].divide(SizedBox(
                                    height: AppTheme.of(context)
                                        .designToken
                                        .spacing
                                        .sm)),
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
                                  .lg),
                        ),
                        child: Container(
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
                                      Icons.payment,
                                      color: Colors.white,
                                      size: 22.0,
                                    ),
                                    title: 'Payout Methods',
                                    description:
                                        'Receive your payments directly into \nyour bank account.',
                                    showTrailingIcon: false,
                                    onTap: () async {
                                      context
                                          .pushNamed(BankCardsWidget.routeName);
                                    },
                                  ),
                                ),
                                SizedBox(
                                  width: 337.0,
                                  child: Divider(
                                    thickness: 1.0,
                                    color:
                                        AppTheme.of(context).alternate,
                                  ),
                                ),
                                wrapWithModel(
                                  model: _model.settingsComponentModel2,
                                  updateCallback: () => safeSetState(() {}),
                                  child: SettingsComponentWidget(
                                    icon: Icon(
                                      Icons.lock_outline,
                                      color: Colors.white,
                                      size: 22.0,
                                    ),
                                    title: 'Security',
                                    description: '2FA ENABLED',
                                    showTrailingIcon: false,
                                    onTap: () async {},
                                  ),
                                ),
                                SizedBox(
                                  width: 337.0,
                                  child: Divider(
                                    thickness: 1.0,
                                    color:
                                        AppTheme.of(context).alternate,
                                  ),
                                ),
                                wrapWithModel(
                                  model: _model.settingsComponentModel3,
                                  updateCallback: () => safeSetState(() {}),
                                  child: SettingsComponentWidget(
                                    icon: Icon(
                                      Icons.lock_outline,
                                      color: Colors.white,
                                      size: 22.0,
                                    ),
                                    title: 'Notifications',
                                    description:
                                        'Push alerts and email settings',
                                    showTrailingIcon: false,
                                    onTap: () async {
                                      context.pushNamed(
                                          NotificationPageWidget.routeName);
                                    },
                                  ),
                                ),
                                SizedBox(
                                  width: 337.0,
                                  child: Divider(
                                    thickness: 1.0,
                                    color:
                                        AppTheme.of(context).alternate,
                                  ),
                                ),
                                wrapWithModel(
                                  model: _model.settingsComponentModel4,
                                  updateCallback: () => safeSetState(() {}),
                                  child: SettingsComponentWidget(
                                    icon: Icon(
                                      Icons.notifications_none,
                                      color: Colors.white,
                                      size: 22.0,
                                    ),
                                    title: 'Preferences',
                                    description: 'PUSH & EMAIL ACTIVE',
                                    showTrailingIcon: false,
                                    onTap: () async {},
                                  ),
                                ),
                                Divider(
                                  thickness: 2.0,
                                  color: AppTheme.of(context).alternate,
                                ),
                                wrapWithModel(
                                  model: _model.settingsComponentModel5,
                                  updateCallback: () => safeSetState(() {}),
                                  child: SettingsComponentWidget(
                                    icon: Icon(
                                      Icons.password,
                                      color: AppTheme.of(context).info,
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
                                  thickness: 2.0,
                                  color: AppTheme.of(context).alternate,
                                ),
                                Builder(
                                  builder: (context) => wrapWithModel(
                                    model: _model.settingsComponentModel6,
                                    updateCallback: () => safeSetState(() {}),
                                    child: SettingsComponentWidget(
                                      icon: Icon(
                                        Icons.dark_mode_outlined,
                                        color: Colors.white,
                                        size: 22.0,
                                      ),
                                      title: 'Appearances',
                                      description: 'LIGHT, DARK, or SYSTEM',
                                      showTrailingIcon: false,
                                      onTap: () async {
                                        await showDialog(
                                          context: context,
                                          builder: (dialogContext) {
                                            return Dialog(
                                              elevation: 0,
                                              insetPadding: EdgeInsets.zero,
                                              backgroundColor:
                                                  Colors.transparent,
                                              alignment:
                                                  AlignmentDirectional(0.0, 0.0)
                                                      .resolve(
                                                          Directionality.of(
                                                              context)),
                                              child: GestureDetector(
                                                onTap: () {
                                                  FocusScope.of(dialogContext)
                                                      .unfocus();
                                                  FocusManager
                                                      .instance.primaryFocus
                                                      ?.unfocus();
                                                },
                                                child: ThemePickerWidget(),
                                              ),
                                            );
                                          },
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              ].divide(SizedBox(
                                  height: AppConstants.childSpacing)),
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
                  model: _model.tpNavbarModel,
                  updateCallback: () => safeSetState(() {}),
                  child: TpNavbarWidget(
                    selectedIndex: 3,
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
