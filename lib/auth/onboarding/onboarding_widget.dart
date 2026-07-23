import '/widgets/app_icon_button.dart';
import '/core/theme/app_theme.dart';
import '/utils/util.dart';
import '/widgets/app_button.dart';
import 'dart:ui';
import '/core/routes/index.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart'
    as smooth_page_indicator;
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '/providers/onboarding_provider.dart';
import '/viewmodels/onboarding_model.dart';
export '/viewmodels/onboarding_model.dart';

class OnboardingWidget extends StatefulWidget {
  const OnboardingWidget({super.key});

  static String routeName = 'onboarding';
  static String routePath = '/onboarding';

  @override
  State<OnboardingWidget> createState() => _OnboardingWidgetState();
}

class _OnboardingWidgetState extends State<OnboardingWidget> {
  late OnboardingModel _model;
  final OnboardingProvider _provider = OnboardingProvider();

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => OnboardingModel());

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
    return ChangeNotifierProvider<OnboardingProvider>.value(
      value: _provider,
      child: Consumer<OnboardingProvider>(
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
          child: Padding(
            padding: EdgeInsets.all(valueOrDefault<double>(
              AppConstants.parentPagePadding,
              0.0,
            )),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Image.asset(
                            'assets/images/logo-removebg-preview.png',
                            width: 50.0,
                            height: 50.0,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Text(
                          'My Trade Pal',
                          style:
                              AppTheme.of(context).titleMedium.override(
                                    font: GoogleFonts.manrope(
                                      fontWeight: AppTheme.of(context)
                                          .titleMedium
                                          .fontWeight,
                                      fontStyle: AppTheme.of(context)
                                          .titleMedium
                                          .fontStyle,
                                    ),
                                    letterSpacing: 0.0,
                                    fontWeight: AppTheme.of(context)
                                        .titleMedium
                                        .fontWeight,
                                    fontStyle: AppTheme.of(context)
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
                    if (_model.pageViewCurrentIndex < 2)
                      InkWell(
                        splashColor: Colors.transparent,
                        focusColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () async {
                          AppState().onboarding = true;
                          _provider.update(() {});

                          context.goNamed(LoginWidget.routeName);
                        },
                        child: Container(
                          width: 50.0,
                          height: 50.0,
                          decoration: const BoxDecoration(),
                          alignment: const AlignmentDirectional(0.0, 0.0),
                          child: Text(
                            'Skip',
                            style: AppTheme.of(context)
                                .labelLarge
                                .override(
                                  font: GoogleFonts.inter(
                                    fontWeight: FontWeight.w500,
                                    fontStyle: AppTheme.of(context)
                                        .labelLarge
                                        .fontStyle,
                                  ),
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.w500,
                                  fontStyle: AppTheme.of(context)
                                      .labelLarge
                                      .fontStyle,
                                ),
                          ),
                        ),
                      ),
                  ],
                ),
                Expanded(
                  child: SizedBox(
                    width: double.infinity,
                    height: double.infinity,
                    child: Stack(
                      children: [
                        PageView(
                          controller: _model.pageViewController ??=
                              PageController(initialPage: 0),
                          scrollDirection: Axis.horizontal,
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
                                decoration: BoxDecoration(
                                  color: AppTheme.of(context)
                                      .secondaryBackground,
                                  borderRadius: BorderRadius.circular(
                                      AppTheme.of(context)
                                          .designToken
                                          .radius
                                          .lg),
                                  border: Border.all(
                                    color:
                                        AppTheme.of(context).alternate,
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      0.0, 0.0, 0.0, 30.0),
                                  child: SingleChildScrollView(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        SizedBox(
                                          width: double.infinity,
                                          height: 206.0,
                                          child: Stack(
                                            children: [
                                              ClipRRect(
                                                borderRadius: const BorderRadius.only(
                                                  topLeft: Radius.circular(8.0),
                                                  topRight:
                                                      Radius.circular(8.0),
                                                ),
                                                child: Image.asset(
                                                  'assets/images/onboarding_image.png',
                                                  width: double.infinity,
                                                  height: 206.0,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                              Align(
                                                alignment: const AlignmentDirectional(
                                                    0.8, -0.8),
                                                child: Container(
                                                  width: 150.0,
                                                  height: 40.0,
                                                  decoration: BoxDecoration(
                                                    color: AppTheme.of(
                                                            context)
                                                        .secondaryBackground,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8.0),
                                                  ),
                                                  child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8.0),
                                                        child: SvgPicture.asset(
                                                          'assets/images/vetted_expert.svg',
                                                          width: 22.0,
                                                          height: 21.0,
                                                          fit: BoxFit.cover,
                                                        ),
                                                      ),
                                                      Text(
                                                        'VETTED EXPERT',
                                                        style:
                                                            GoogleFonts.roboto(
                                                          color: AppTheme
                                                                  .of(context)
                                                              .primaryText,
                                                          fontSize: 12.0,
                                                        ),
                                                      ),
                                                    ].divide(SizedBox(
                                                        width:
                                                            AppTheme.of(
                                                                    context)
                                                                .designToken
                                                                .spacing
                                                                .sm)),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.all(
                                              valueOrDefault<double>(
                                            AppConstants.childPadding,
                                            0.0,
                                          )),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Align(
                                                alignment: const AlignmentDirectional(
                                                    -1.0, -1.0),
                                                child: Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          0.0,
                                                          AppTheme.of(
                                                                  context)
                                                              .designToken
                                                              .spacing
                                                              .md,
                                                          0.0,
                                                          0.0),
                                                  child: Text(
                                                    'Find Verified\nProfessionals',
                                                    style: AppTheme.of(
                                                            context)
                                                        .headlineMedium
                                                        .override(
                                                          font: GoogleFonts
                                                              .manrope(
                                                            fontWeight:
                                                                AppTheme.of(
                                                                        context)
                                                                    .headlineMedium
                                                                    .fontWeight,
                                                            fontStyle:
                                                                AppTheme.of(
                                                                        context)
                                                                    .headlineMedium
                                                                    .fontStyle,
                                                          ),
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              AppTheme.of(
                                                                      context)
                                                                  .headlineMedium
                                                                  .fontWeight,
                                                          fontStyle:
                                                              AppTheme.of(
                                                                      context)
                                                                  .headlineMedium
                                                                  .fontStyle,
                                                        ),
                                                  ),
                                                ),
                                              ),
                                              Align(
                                                alignment: const AlignmentDirectional(
                                                    -1.0, -1.0),
                                                child: Text(
                                                  'We test every professional\n before they join our app.\n Quality is guaranteed.',
                                                  style: AppTheme.of(
                                                          context)
                                                      .bodyLarge
                                                      .override(
                                                        font:
                                                            GoogleFonts.manrope(
                                                          fontWeight:
                                                              AppTheme.of(
                                                                      context)
                                                                  .bodyLarge
                                                                  .fontWeight,
                                                          fontStyle:
                                                              AppTheme.of(
                                                                      context)
                                                                  .bodyLarge
                                                                  .fontStyle,
                                                        ),
                                                        letterSpacing: 0.0,
                                                        fontWeight:
                                                            AppTheme.of(
                                                                    context)
                                                                .bodyLarge
                                                                .fontWeight,
                                                        fontStyle:
                                                            AppTheme.of(
                                                                    context)
                                                                .bodyLarge
                                                                .fontStyle,
                                                      ),
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        0.0,
                                                        AppTheme.of(
                                                                context)
                                                            .designToken
                                                            .spacing
                                                            .md,
                                                        0.0,
                                                        AppTheme.of(
                                                                context)
                                                            .designToken
                                                            .spacing
                                                            .md),
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Align(
                                                      alignment:
                                                          const AlignmentDirectional(
                                                              0.32, 0.0),
                                                      child: Padding(
                                                        padding: EdgeInsetsDirectional
                                                            .fromSTEB(
                                                                0.0,
                                                                AppTheme.of(
                                                                        context)
                                                                    .designToken
                                                                    .spacing
                                                                    .xs,
                                                                0.0,
                                                                0.0),
                                                        child: Material(
                                                          color: Colors
                                                              .transparent,
                                                          elevation: 0.0,
                                                          shape:
                                                              RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius.circular(
                                                                    valueOrDefault<
                                                                        double>(
                                                              AppConstants
                                                                  .radius3,
                                                              0.0,
                                                            )),
                                                          ),
                                                          child: Container(
                                                            width: 48.0,
                                                            height: 48.0,
                                                            decoration:
                                                                BoxDecoration(
                                                              color: const Color(
                                                                  0xFFE8E8EA),
                                                              borderRadius:
                                                                  BorderRadius.circular(
                                                                      valueOrDefault<
                                                                          double>(
                                                                AppConstants
                                                                    .radius3,
                                                                0.0,
                                                              )),
                                                            ),
                                                            alignment:
                                                                const AlignmentDirectional(
                                                                    0.0, 0.0),
                                                            child: ClipRRect(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          0.0),
                                                              child: SvgPicture
                                                                  .asset(
                                                                'assets/images/search_with_tick.svg',
                                                                width: 18.0,
                                                                height: 18.0,
                                                                fit: BoxFit
                                                                    .contain,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    Column(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Align(
                                                          alignment:
                                                              const AlignmentDirectional(
                                                                  -1.0, -1.0),
                                                          child: Text(
                                                            'Precision Matching',
                                                            style: AppTheme
                                                                    .of(context)
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
                                                        ),
                                                        Align(
                                                          alignment:
                                                              const AlignmentDirectional(
                                                                  -1.0, -1.0),
                                                          child: Text(
                                                            'Our system instantly finds\n the best person for\n your work.',
                                                            style: AppTheme
                                                                    .of(context)
                                                                .bodyMedium
                                                                .override(
                                                                  font: GoogleFonts
                                                                      .manrope(
                                                                    fontWeight: AppTheme.of(
                                                                            context)
                                                                        .bodyMedium
                                                                        .fontWeight,
                                                                    fontStyle: AppTheme.of(
                                                                            context)
                                                                        .bodyMedium
                                                                        .fontStyle,
                                                                  ),
                                                                  letterSpacing:
                                                                      0.0,
                                                                  fontWeight: AppTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .fontWeight,
                                                                  fontStyle: AppTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .fontStyle,
                                                                ),
                                                          ),
                                                        ),
                                                      ].divide(SizedBox(
                                                          height:
                                                              AppTheme.of(
                                                                      context)
                                                                  .designToken
                                                                  .spacing
                                                                  .xs)),
                                                    ),
                                                  ].divide(SizedBox(
                                                      width:
                                                          AppTheme.of(
                                                                  context)
                                                              .designToken
                                                              .spacing
                                                              .md)),
                                                ),
                                              ),
                                            ].divide(SizedBox(
                                                height:
                                                    AppTheme.of(context)
                                                        .designToken
                                                        .spacing
                                                        .md)),
                                          ),
                                        ),
                                        Container(
                                          width: double.infinity,
                                          decoration: BoxDecoration(
                                            color: AppTheme.of(context)
                                                .alternate,
                                            borderRadius: BorderRadius.circular(
                                                AppTheme.of(context)
                                                    .designToken
                                                    .radius
                                                    .md),
                                          ),
                                          child: Padding(
                                            padding: EdgeInsets.all(
                                                AppTheme.of(context)
                                                    .designToken
                                                    .spacing
                                                    .lg),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Align(
                                                  alignment:
                                                      const AlignmentDirectional(
                                                          -1.0, -1.0),
                                                  child: Text(
                                                    'TRUSTED ACTIONS',
                                                    style: AppTheme.of(
                                                            context)
                                                        .labelSmall
                                                        .override(
                                                          font:
                                                              GoogleFonts.inter(
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
                                                ),
                                                Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  children: [
                                                    Container(
                                                      height: 30.0,
                                                      decoration: BoxDecoration(
                                                        color: AppTheme
                                                                .of(context)
                                                            .secondaryBackground,
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                AppTheme.of(
                                                                        context)
                                                                    .designToken
                                                                    .radius
                                                                    .lg),
                                                      ),
                                                      child: Align(
                                                        alignment:
                                                            const AlignmentDirectional(
                                                                0.0, 0.0),
                                                        child: Padding(
                                                          padding: EdgeInsets.all(
                                                              AppTheme.of(
                                                                      context)
                                                                  .designToken
                                                                  .spacing
                                                                  .sm),
                                                          child: Text(
                                                            'Hire With Confidence',
                                                            style: AppTheme
                                                                    .of(context)
                                                                .bodySmall
                                                                .override(
                                                                  font: GoogleFonts
                                                                      .manrope(
                                                                    fontWeight: AppTheme.of(
                                                                            context)
                                                                        .bodySmall
                                                                        .fontWeight,
                                                                    fontStyle: AppTheme.of(
                                                                            context)
                                                                        .bodySmall
                                                                        .fontStyle,
                                                                  ),
                                                                  letterSpacing:
                                                                      0.0,
                                                                  fontWeight: AppTheme.of(
                                                                          context)
                                                                      .bodySmall
                                                                      .fontWeight,
                                                                  fontStyle: AppTheme.of(
                                                                          context)
                                                                      .bodySmall
                                                                      .fontStyle,
                                                                ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    Container(
                                                      height: 30.0,
                                                      decoration: BoxDecoration(
                                                        color: AppTheme
                                                                .of(context)
                                                            .secondaryBackground,
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                AppTheme.of(
                                                                        context)
                                                                    .designToken
                                                                    .radius
                                                                    .lg),
                                                      ),
                                                      child: Align(
                                                        alignment:
                                                            const AlignmentDirectional(
                                                                0.0, 0.0),
                                                        child: Padding(
                                                          padding: EdgeInsets.all(
                                                              AppTheme.of(
                                                                      context)
                                                                  .designToken
                                                                  .spacing
                                                                  .sm),
                                                          child: Text(
                                                            'Trusted Professionals',
                                                            style: AppTheme
                                                                    .of(context)
                                                                .bodySmall
                                                                .override(
                                                                  font: GoogleFonts
                                                                      .manrope(
                                                                    fontWeight: AppTheme.of(
                                                                            context)
                                                                        .bodySmall
                                                                        .fontWeight,
                                                                    fontStyle: AppTheme.of(
                                                                            context)
                                                                        .bodySmall
                                                                        .fontStyle,
                                                                  ),
                                                                  letterSpacing:
                                                                      0.0,
                                                                  fontWeight: AppTheme.of(
                                                                          context)
                                                                      .bodySmall
                                                                      .fontWeight,
                                                                  fontStyle: AppTheme.of(
                                                                          context)
                                                                      .bodySmall
                                                                      .fontStyle,
                                                                ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ].divide(SizedBox(
                                                      width:
                                                          AppTheme.of(
                                                                  context)
                                                              .designToken
                                                              .spacing
                                                              .md)),
                                                ),
                                                Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  children: [
                                                    Container(
                                                      height: 30.0,
                                                      decoration: BoxDecoration(
                                                        color: AppTheme
                                                                .of(context)
                                                            .secondaryBackground,
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                AppTheme.of(
                                                                        context)
                                                                    .designToken
                                                                    .radius
                                                                    .lg),
                                                      ),
                                                      child: Align(
                                                        alignment:
                                                            const AlignmentDirectional(
                                                                0.0, 0.0),
                                                        child: Padding(
                                                          padding: EdgeInsets.all(
                                                              AppTheme.of(
                                                                      context)
                                                                  .designToken
                                                                  .spacing
                                                                  .sm),
                                                          child: Text(
                                                            'Quality Work',
                                                            style: AppTheme
                                                                    .of(context)
                                                                .bodySmall
                                                                .override(
                                                                  font: GoogleFonts
                                                                      .manrope(
                                                                    fontWeight: AppTheme.of(
                                                                            context)
                                                                        .bodySmall
                                                                        .fontWeight,
                                                                    fontStyle: AppTheme.of(
                                                                            context)
                                                                        .bodySmall
                                                                        .fontStyle,
                                                                  ),
                                                                  letterSpacing:
                                                                      0.0,
                                                                  fontWeight: AppTheme.of(
                                                                          context)
                                                                      .bodySmall
                                                                      .fontWeight,
                                                                  fontStyle: AppTheme.of(
                                                                          context)
                                                                      .bodySmall
                                                                      .fontStyle,
                                                                ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    Container(
                                                      height: 30.0,
                                                      decoration: BoxDecoration(
                                                        color: AppTheme
                                                                .of(context)
                                                            .secondaryBackground,
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                AppTheme.of(
                                                                        context)
                                                                    .designToken
                                                                    .radius
                                                                    .lg),
                                                      ),
                                                      child: Align(
                                                        alignment:
                                                            const AlignmentDirectional(
                                                                0.0, 0.0),
                                                        child: Padding(
                                                          padding: EdgeInsets.all(
                                                              AppTheme.of(
                                                                      context)
                                                                  .designToken
                                                                  .spacing
                                                                  .sm),
                                                          child: Text(
                                                            'Trusted Experts',
                                                            style: AppTheme
                                                                    .of(context)
                                                                .bodySmall
                                                                .override(
                                                                  font: GoogleFonts
                                                                      .manrope(
                                                                    fontWeight: AppTheme.of(
                                                                            context)
                                                                        .bodySmall
                                                                        .fontWeight,
                                                                    fontStyle: AppTheme.of(
                                                                            context)
                                                                        .bodySmall
                                                                        .fontStyle,
                                                                  ),
                                                                  letterSpacing:
                                                                      0.0,
                                                                  fontWeight: AppTheme.of(
                                                                          context)
                                                                      .bodySmall
                                                                      .fontWeight,
                                                                  fontStyle: AppTheme.of(
                                                                          context)
                                                                      .bodySmall
                                                                      .fontStyle,
                                                                ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ].divide(SizedBox(
                                                      width:
                                                          AppTheme.of(
                                                                  context)
                                                              .designToken
                                                              .spacing
                                                              .md)),
                                                ),
                                                Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  children: [
                                                    Container(
                                                      height: 30.0,
                                                      decoration: BoxDecoration(
                                                        color: AppTheme
                                                                .of(context)
                                                            .secondaryBackground,
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                AppTheme.of(
                                                                        context)
                                                                    .designToken
                                                                    .radius
                                                                    .lg),
                                                      ),
                                                      child: Align(
                                                        alignment:
                                                            const AlignmentDirectional(
                                                                0.0, 0.0),
                                                        child: Padding(
                                                          padding: EdgeInsets.all(
                                                              AppTheme.of(
                                                                      context)
                                                                  .designToken
                                                                  .spacing
                                                                  .sm),
                                                          child: Text(
                                                            'Verified & Reliable',
                                                            style: AppTheme
                                                                    .of(context)
                                                                .bodySmall
                                                                .override(
                                                                  font: GoogleFonts
                                                                      .manrope(
                                                                    fontWeight: AppTheme.of(
                                                                            context)
                                                                        .bodySmall
                                                                        .fontWeight,
                                                                    fontStyle: AppTheme.of(
                                                                            context)
                                                                        .bodySmall
                                                                        .fontStyle,
                                                                  ),
                                                                  letterSpacing:
                                                                      0.0,
                                                                  fontWeight: AppTheme.of(
                                                                          context)
                                                                      .bodySmall
                                                                      .fontWeight,
                                                                  fontStyle: AppTheme.of(
                                                                          context)
                                                                      .bodySmall
                                                                      .fontStyle,
                                                                ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    Container(
                                                      height: 30.0,
                                                      decoration: BoxDecoration(
                                                        color: AppTheme
                                                                .of(context)
                                                            .secondaryBackground,
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                AppTheme.of(
                                                                        context)
                                                                    .designToken
                                                                    .radius
                                                                    .lg),
                                                      ),
                                                      child: Align(
                                                        alignment:
                                                            const AlignmentDirectional(
                                                                0.0, 0.0),
                                                        child: Padding(
                                                          padding: EdgeInsets.all(
                                                              AppTheme.of(
                                                                      context)
                                                                  .designToken
                                                                  .spacing
                                                                  .sm),
                                                          child: Text(
                                                            'Trusted Local Services',
                                                            style: AppTheme
                                                                    .of(context)
                                                                .bodySmall
                                                                .override(
                                                                  font: GoogleFonts
                                                                      .manrope(
                                                                    fontWeight: AppTheme.of(
                                                                            context)
                                                                        .bodySmall
                                                                        .fontWeight,
                                                                    fontStyle: AppTheme.of(
                                                                            context)
                                                                        .bodySmall
                                                                        .fontStyle,
                                                                  ),
                                                                  letterSpacing:
                                                                      0.0,
                                                                  fontWeight: AppTheme.of(
                                                                          context)
                                                                      .bodySmall
                                                                      .fontWeight,
                                                                  fontStyle: AppTheme.of(
                                                                          context)
                                                                      .bodySmall
                                                                      .fontStyle,
                                                                ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ].divide(SizedBox(
                                                      width:
                                                          AppTheme.of(
                                                                  context)
                                                              .designToken
                                                              .spacing
                                                              .md)),
                                                ),
                                              ].divide(SizedBox(
                                                  height: AppTheme.of(
                                                          context)
                                                      .designToken
                                                      .spacing
                                                      .md)),
                                            ),
                                          ),
                                        ),
                                      ].addToEnd(const SizedBox(height: 40.0)),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SingleChildScrollView(
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Text(
                                    'Manage Jobs\nEffortlessly',
                                    textAlign: TextAlign.center,
                                    style: AppTheme.of(context)
                                        .headlineLarge
                                        .override(
                                          font: GoogleFonts.manrope(
                                            fontWeight:
                                                AppTheme.of(context)
                                                    .headlineLarge
                                                    .fontWeight,
                                            fontStyle:
                                                AppTheme.of(context)
                                                    .headlineLarge
                                                    .fontStyle,
                                          ),
                                          letterSpacing: 0.0,
                                          fontWeight:
                                              AppTheme.of(context)
                                                  .headlineLarge
                                                  .fontWeight,
                                          fontStyle:
                                              AppTheme.of(context)
                                                  .headlineLarge
                                                  .fontStyle,
                                        ),
                                  ),
                                  Text(
                                    'Enjoy a smooth, smart dashboard experience. Track live bids and monitor your project in real time.',
                                    textAlign: TextAlign.center,
                                    style: AppTheme.of(context)
                                        .bodyLarge
                                        .override(
                                          font: GoogleFonts.manrope(
                                            fontWeight:
                                                AppTheme.of(context)
                                                    .bodyLarge
                                                    .fontWeight,
                                            fontStyle:
                                                AppTheme.of(context)
                                                    .bodyLarge
                                                    .fontStyle,
                                          ),
                                          letterSpacing: 0.0,
                                          fontWeight:
                                              AppTheme.of(context)
                                                  .bodyLarge
                                                  .fontWeight,
                                          fontStyle:
                                              AppTheme.of(context)
                                                  .bodyLarge
                                                  .fontStyle,
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
                                          color: AppTheme.of(context)
                                              .alternate,
                                        ),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.all(
                                            AppTheme.of(context)
                                                .designToken
                                                .spacing
                                                .lg),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Row(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  'My Trade pal',
                                                  style: AppTheme.of(
                                                          context)
                                                      .labelLarge
                                                      .override(
                                                        font: GoogleFonts.inter(
                                                          fontWeight:
                                                              AppTheme.of(
                                                                      context)
                                                                  .labelLarge
                                                                  .fontWeight,
                                                          fontStyle:
                                                              AppTheme.of(
                                                                      context)
                                                                  .labelLarge
                                                                  .fontStyle,
                                                        ),
                                                        color:
                                                            AppTheme.of(
                                                                    context)
                                                                .primary,
                                                        letterSpacing: 0.0,
                                                        fontWeight:
                                                            AppTheme.of(
                                                                    context)
                                                                .labelLarge
                                                                .fontWeight,
                                                        fontStyle:
                                                            AppTheme.of(
                                                                    context)
                                                                .labelLarge
                                                                .fontStyle,
                                                      ),
                                                ),
                                                Align(
                                                  alignment:
                                                      const AlignmentDirectional(
                                                          0.0, 0.0),
                                                  child: Stack(
                                                    alignment:
                                                        const AlignmentDirectional(
                                                            0.0, 0.0),
                                                    children: [
                                                      Opacity(
                                                        opacity: 0.6,
                                                        child: Container(
                                                          width: 90.0,
                                                          height: 40.0,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: const Color(
                                                                0xFF4169E1),
                                                            borderRadius: BorderRadius.circular(
                                                                AppTheme.of(
                                                                        context)
                                                                    .designToken
                                                                    .radius
                                                                    .lg),
                                                          ),
                                                        ),
                                                      ),
                                                      Align(
                                                        alignment:
                                                            const AlignmentDirectional(
                                                                0.0, 0.0),
                                                        child: Text(
                                                          'IN PROGRESS',
                                                          style: AppTheme
                                                                  .of(context)
                                                              .bodySmall
                                                              .override(
                                                                font: GoogleFonts
                                                                    .manrope(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontStyle: AppTheme.of(
                                                                          context)
                                                                      .bodySmall
                                                                      .fontStyle,
                                                                ),
                                                                color: AppTheme.of(
                                                                        context)
                                                                    .primaryText,
                                                                letterSpacing:
                                                                    0.0,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontStyle: AppTheme.of(
                                                                        context)
                                                                    .bodySmall
                                                                    .fontStyle,
                                                              ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Align(
                                              alignment: const AlignmentDirectional(
                                                  -1.0, -1.0),
                                              child: Text(
                                                'Kitchen\nRenovation',
                                                style: AppTheme.of(
                                                        context)
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
                                            ),
                                            Container(
                                              width: double.infinity,
                                              height: 84.0,
                                              decoration: BoxDecoration(
                                                color:
                                                    AppTheme.of(context)
                                                        .alternate,
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        AppTheme.of(
                                                                context)
                                                            .designToken
                                                            .radius
                                                            .md),
                                              ),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  Container(
                                                    width: 45.0,
                                                    height: 42.0,
                                                    decoration: BoxDecoration(
                                                      color:
                                                          AppTheme.of(
                                                                  context)
                                                              .accent1,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              12.0),
                                                    ),
                                                    child: Align(
                                                      alignment:
                                                          const AlignmentDirectional(
                                                              0.0, 0.0),
                                                      child: ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(0.0),
                                                        child: SvgPicture.asset(
                                                          'assets/images/order.svg',
                                                          width: 14.0,
                                                          height: 14.0,
                                                          fit: BoxFit.cover,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Column(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        'Active Bids',
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
                                                      Text(
                                                        '3 qualified contractors\nresponding',
                                                        style:
                                                            AppTheme.of(
                                                                    context)
                                                                .bodySmall
                                                                .override(
                                                                  font: GoogleFonts
                                                                      .manrope(
                                                                    fontWeight: AppTheme.of(
                                                                            context)
                                                                        .bodySmall
                                                                        .fontWeight,
                                                                    fontStyle: AppTheme.of(
                                                                            context)
                                                                        .bodySmall
                                                                        .fontStyle,
                                                                  ),
                                                                  letterSpacing:
                                                                      0.0,
                                                                  fontWeight: AppTheme.of(
                                                                          context)
                                                                      .bodySmall
                                                                      .fontWeight,
                                                                  fontStyle: AppTheme.of(
                                                                          context)
                                                                      .bodySmall
                                                                      .fontStyle,
                                                                ),
                                                      ),
                                                    ],
                                                  ),
                                                  Icon(
                                                    Icons.arrow_forward_ios,
                                                    color: AppTheme.of(
                                                            context)
                                                        .primaryText,
                                                    size: 24.0,
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Container(
                                              width: double.infinity,
                                              height: 84.0,
                                              decoration: BoxDecoration(
                                                color:
                                                    AppTheme.of(context)
                                                        .alternate,
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        AppTheme.of(
                                                                context)
                                                            .designToken
                                                            .radius
                                                            .md),
                                              ),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  Container(
                                                    width: 45.0,
                                                    height: 42.0,
                                                    decoration: BoxDecoration(
                                                      color:
                                                          AppTheme.of(
                                                                  context)
                                                              .accent1,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              12.0),
                                                    ),
                                                    child: Align(
                                                      alignment:
                                                          const AlignmentDirectional(
                                                              0.0, 0.0),
                                                      child: ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(0.0),
                                                        child: SvgPicture.asset(
                                                          'assets/images/compass_white.svg',
                                                          width: 14.0,
                                                          height: 14.0,
                                                          fit: BoxFit.cover,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Column(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        'Project\nMilestones',
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
                                                      Text(
                                                        'Foundation & Framing\ncomplete',
                                                        style:
                                                            AppTheme.of(
                                                                    context)
                                                                .bodySmall
                                                                .override(
                                                                  font: GoogleFonts
                                                                      .manrope(
                                                                    fontWeight: AppTheme.of(
                                                                            context)
                                                                        .bodySmall
                                                                        .fontWeight,
                                                                    fontStyle: AppTheme.of(
                                                                            context)
                                                                        .bodySmall
                                                                        .fontStyle,
                                                                  ),
                                                                  letterSpacing:
                                                                      0.0,
                                                                  fontWeight: AppTheme.of(
                                                                          context)
                                                                      .bodySmall
                                                                      .fontWeight,
                                                                  fontStyle: AppTheme.of(
                                                                          context)
                                                                      .bodySmall
                                                                      .fontStyle,
                                                                ),
                                                      ),
                                                    ],
                                                  ),
                                                  Icon(
                                                    Icons.arrow_forward_ios,
                                                    color: AppTheme.of(
                                                            context)
                                                        .primaryText,
                                                    size: 24.0,
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(
                                                      0.0,
                                                      AppTheme.of(
                                                              context)
                                                          .designToken
                                                          .spacing
                                                          .lg,
                                                      0.0,
                                                      0.0),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  Container(
                                                    width: 48.0,
                                                    height: 48.0,
                                                    decoration: BoxDecoration(
                                                      image: DecorationImage(
                                                        fit: BoxFit.cover,
                                                        image: Image.asset(
                                                          'assets/images/onboarding_image_png.png',
                                                        ).image,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              AppTheme.of(
                                                                      context)
                                                                  .designToken
                                                                  .radius
                                                                  .md),
                                                    ),
                                                  ),
                                                  Text(
                                                    '\"The platform handles the noise,\nallowing me to focus on the structure\nand design of my home.\"',
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
                                                ].divide(SizedBox(
                                                    width: AppTheme.of(
                                                            context)
                                                        .designToken
                                                        .spacing
                                                        .md)),
                                              ),
                                            ),
                                            Align(
                                              alignment: const AlignmentDirectional(
                                                  -1.0, -1.0),
                                              child: Material(
                                                color: Colors.transparent,
                                                elevation: 0.0,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          AppTheme.of(
                                                                  context)
                                                              .designToken
                                                              .radius
                                                              .md),
                                                ),
                                                child: Container(
                                                  width: double.infinity,
                                                  decoration: BoxDecoration(
                                                    color: AppTheme.of(
                                                            context)
                                                        .alternate,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            AppTheme.of(
                                                                    context)
                                                                .designToken
                                                                .radius
                                                                .md),
                                                  ),
                                                  child: Padding(
                                                    padding: EdgeInsets.all(
                                                        valueOrDefault<double>(
                                                      AppConstants
                                                          .childSpacing,
                                                      0.0,
                                                    )),
                                                    child: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        Align(
                                                          alignment:
                                                              const AlignmentDirectional(
                                                                  -1.0, -1.0),
                                                          child: ClipRRect(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        0.0),
                                                            child: SvgPicture
                                                                .asset(
                                                              'assets/images/99.svg',
                                                              width: 26.0,
                                                              height: 18.0,
                                                              fit: BoxFit.cover,
                                                            ),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding: EdgeInsets.all(
                                                              AppTheme.of(
                                                                      context)
                                                                  .designToken
                                                                  .spacing
                                                                  .xl),
                                                          child: Column(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .start,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Row(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .max,
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Stack(
                                                                    alignment:
                                                                        const AlignmentDirectional(
                                                                            0.0,
                                                                            0.0),
                                                                    children: [
                                                                      Opacity(
                                                                        opacity:
                                                                            0.6,
                                                                        child:
                                                                            Container(
                                                                          width:
                                                                              34.0,
                                                                          height:
                                                                              34.0,
                                                                          decoration:
                                                                              const BoxDecoration(
                                                                            color:
                                                                                Color(0xFF4169E1),
                                                                            shape:
                                                                                BoxShape.circle,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      Align(
                                                                        alignment: const AlignmentDirectional(
                                                                            0.0,
                                                                            0.0),
                                                                        child:
                                                                            Text(
                                                                          'SK',
                                                                          style: AppTheme.of(context)
                                                                              .titleSmall
                                                                              .override(
                                                                                font: GoogleFonts.manrope(
                                                                                  fontWeight: AppTheme.of(context).titleSmall.fontWeight,
                                                                                  fontStyle: AppTheme.of(context).titleSmall.fontStyle,
                                                                                ),
                                                                                letterSpacing: 0.0,
                                                                                fontWeight: AppTheme.of(context).titleSmall.fontWeight,
                                                                                fontStyle: AppTheme.of(context).titleSmall.fontStyle,
                                                                              ),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  Align(
                                                                    alignment:
                                                                        const AlignmentDirectional(
                                                                            -1.0,
                                                                            -1.0),
                                                                    child: Text(
                                                                      '— Sarah J.',
                                                                      style: AppTheme.of(
                                                                              context)
                                                                          .titleSmall
                                                                          .override(
                                                                            font:
                                                                                GoogleFonts.manrope(
                                                                              fontWeight: AppTheme.of(context).titleSmall.fontWeight,
                                                                              fontStyle: AppTheme.of(context).titleSmall.fontStyle,
                                                                            ),
                                                                            letterSpacing:
                                                                                0.0,
                                                                            fontWeight:
                                                                                AppTheme.of(context).titleSmall.fontWeight,
                                                                            fontStyle:
                                                                                AppTheme.of(context).titleSmall.fontStyle,
                                                                          ),
                                                                    ),
                                                                  ),
                                                                ].divide(SizedBox(
                                                                    width: AppTheme.of(
                                                                            context)
                                                                        .designToken
                                                                        .spacing
                                                                        .sm)),
                                                              ),
                                                              Text(
                                                                '\"Found a great plumber in\nminutes. The verification\nbadge gave me peace of\nmind.\"',
                                                                style: AppTheme.of(
                                                                        context)
                                                                    .bodyLarge
                                                                    .override(
                                                                      font: GoogleFonts
                                                                          .manrope(
                                                                        fontWeight: AppTheme.of(context)
                                                                            .bodyLarge
                                                                            .fontWeight,
                                                                        fontStyle: AppTheme.of(context)
                                                                            .bodyLarge
                                                                            .fontStyle,
                                                                      ),
                                                                      letterSpacing:
                                                                          0.0,
                                                                      fontWeight: AppTheme.of(
                                                                              context)
                                                                          .bodyLarge
                                                                          .fontWeight,
                                                                      fontStyle: AppTheme.of(
                                                                              context)
                                                                          .bodyLarge
                                                                          .fontStyle,
                                                                    ),
                                                              ),
                                                            ].divide(SizedBox(
                                                                height: AppTheme.of(
                                                                        context)
                                                                    .designToken
                                                                    .spacing
                                                                    .sm)),
                                                          ),
                                                        ),
                                                      ].divide(SizedBox(
                                                          height:
                                                              AppTheme.of(
                                                                      context)
                                                                  .designToken
                                                                  .spacing
                                                                  .sm)),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ].divide(SizedBox(
                                              height:
                                                  AppTheme.of(context)
                                                      .designToken
                                                      .spacing
                                                      .md)),
                                        ),
                                      ),
                                    ),
                                  ),
                                ]
                                    .divide(SizedBox(
                                        height: AppTheme.of(context)
                                            .designToken
                                            .spacing
                                            .lg))
                                    .addToEnd(const SizedBox(height: 50.0)),
                              ),
                            ),
                            SingleChildScrollView(
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Stack(
                                    alignment: const AlignmentDirectional(0.0, 0.0),
                                    children: [
                                      Opacity(
                                        opacity: 0.6,
                                        child: Align(
                                          alignment:
                                              const AlignmentDirectional(0.0, 0.0),
                                          child: Padding(
                                            padding:
                                                const EdgeInsetsDirectional.fromSTEB(
                                                    0.0, 3.0, 0.0, 0.0),
                                            child: Container(
                                              width: 64.0,
                                              height: 54.0,
                                              decoration: BoxDecoration(
                                                color: const Color(0xFF4169E1),
                                                borderRadius:
                                                    BorderRadius.circular(12.0),
                                              ),
                                              alignment: const AlignmentDirectional(
                                                  0.0, 0.0),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Align(
                                        alignment:
                                            const AlignmentDirectional(0.0, 0.0),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                          child: SvgPicture.asset(
                                            'assets/images/guard_blue.svg',
                                            width: 24.0,
                                            height: 30.0,
                                            fit: BoxFit.cover,
                                            alignment: const Alignment(0.0, 0.0),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    'Secure Payments &\nTrust',
                                    textAlign: TextAlign.center,
                                    style: AppTheme.of(context)
                                        .headlineLarge
                                        .override(
                                          font: GoogleFonts.manrope(
                                            fontWeight:
                                                AppTheme.of(context)
                                                    .headlineLarge
                                                    .fontWeight,
                                            fontStyle:
                                                AppTheme.of(context)
                                                    .headlineLarge
                                                    .fontStyle,
                                          ),
                                          letterSpacing: 0.0,
                                          fontWeight:
                                              AppTheme.of(context)
                                                  .headlineLarge
                                                  .fontWeight,
                                          fontStyle:
                                              AppTheme.of(context)
                                                  .headlineLarge
                                                  .fontStyle,
                                        ),
                                  ),
                                  Text(
                                    'Every transaction is protected by\ninstitutional-grade encryption, ensuring\nyour professional integrity is never\ncompromised.',
                                    textAlign: TextAlign.center,
                                    style: AppTheme.of(context)
                                        .bodyLarge
                                        .override(
                                          font: GoogleFonts.manrope(
                                            fontWeight:
                                                AppTheme.of(context)
                                                    .bodyLarge
                                                    .fontWeight,
                                            fontStyle:
                                                AppTheme.of(context)
                                                    .bodyLarge
                                                    .fontStyle,
                                          ),
                                          letterSpacing: 0.0,
                                          fontWeight:
                                              AppTheme.of(context)
                                                  .bodyLarge
                                                  .fontWeight,
                                          fontStyle:
                                              AppTheme.of(context)
                                                  .bodyLarge
                                                  .fontStyle,
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
                                          color: AppTheme.of(context)
                                              .alternate,
                                        ),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.all(
                                            AppTheme.of(context)
                                                .designToken
                                                .spacing
                                                .lg),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Align(
                                              alignment: const AlignmentDirectional(
                                                  -1.0, -1.0),
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                                child: SvgPicture.asset(
                                                  'assets/images/onboarding_icon_.svg',
                                                  width: 29.0,
                                                  height: 26.0,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                            Text(
                                              'Safe Holding',
                                              textAlign: TextAlign.center,
                                              style:
                                                  AppTheme.of(context)
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
                                            Text(
                                              'Funds are kept secure and released only after milestone approval. Our system ensures safe, transparent payments for both clients and contractors.\nFunds are kept secure and released only after milestone approval. Our system ensures safe, transparent payments for both clients and contractors.',
                                              textAlign: TextAlign.start,
                                              style:
                                                  AppTheme.of(context)
                                                      .bodyLarge
                                                      .override(
                                                        font:
                                                            GoogleFonts.manrope(
                                                          fontWeight:
                                                              AppTheme.of(
                                                                      context)
                                                                  .bodyLarge
                                                                  .fontWeight,
                                                          fontStyle:
                                                              AppTheme.of(
                                                                      context)
                                                                  .bodyLarge
                                                                  .fontStyle,
                                                        ),
                                                        letterSpacing: 0.0,
                                                        fontWeight:
                                                            AppTheme.of(
                                                                    context)
                                                                .bodyLarge
                                                                .fontWeight,
                                                        fontStyle:
                                                            AppTheme.of(
                                                                    context)
                                                                .bodyLarge
                                                                .fontStyle,
                                                      ),
                                            ),
                                            Row(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Container(
                                                  decoration: BoxDecoration(
                                                    color: AppTheme.of(
                                                            context)
                                                        .alternate,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            AppTheme.of(
                                                                    context)
                                                                .designToken
                                                                .radius
                                                                .lg),
                                                  ),
                                                  child: Padding(
                                                    padding: EdgeInsets.all(
                                                        AppTheme.of(
                                                                context)
                                                            .designToken
                                                            .radius
                                                            .sm),
                                                    child: Row(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        Icon(
                                                          Icons.check,
                                                          color: AppTheme
                                                                  .of(context)
                                                              .primaryText,
                                                          size: 14.0,
                                                        ),
                                                        Text(
                                                          'ENCRYPTED',
                                                          textAlign:
                                                              TextAlign.start,
                                                          style: AppTheme
                                                                  .of(context)
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
                                                      ].divide(SizedBox(
                                                          width: AppTheme
                                                                  .of(context)
                                                              .designToken
                                                              .spacing
                                                              .xs)),
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  decoration: BoxDecoration(
                                                    color: AppTheme.of(
                                                            context)
                                                        .alternate,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            AppTheme.of(
                                                                    context)
                                                                .designToken
                                                                .radius
                                                                .lg),
                                                  ),
                                                  child: Padding(
                                                    padding: EdgeInsets.all(
                                                        AppTheme.of(
                                                                context)
                                                            .designToken
                                                            .radius
                                                            .sm),
                                                    child: Row(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        Icon(
                                                          Icons.check,
                                                          color: AppTheme
                                                                  .of(context)
                                                              .primaryText,
                                                          size: 14.0,
                                                        ),
                                                        Text(
                                                          'Milestone-based',
                                                          textAlign:
                                                              TextAlign.start,
                                                          style: AppTheme
                                                                  .of(context)
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
                                                      ].divide(SizedBox(
                                                          width: AppTheme
                                                                  .of(context)
                                                              .designToken
                                                              .spacing
                                                              .xs)),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ].divide(SizedBox(
                                              height:
                                                  AppTheme.of(context)
                                                      .designToken
                                                      .spacing
                                                      .md)),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      color: AppTheme.of(context)
                                          .alternate,
                                      borderRadius: BorderRadius.circular(
                                          AppTheme.of(context)
                                              .designToken
                                              .radius
                                              .md),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.all(
                                          AppTheme.of(context)
                                              .designToken
                                              .spacing
                                              .lg),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Align(
                                            alignment:
                                                const AlignmentDirectional(0.0, 0.0),
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                              child: Image.network(
                                                'https://picsum.photos/seed/980/600',
                                                width: 96.0,
                                                height: 96.0,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                          RatingBar.builder(
                                            onRatingUpdate: (newValue) =>
                                                safeSetState(() => _model
                                                    .ratingBarValue = newValue),
                                            itemBuilder: (context, index) =>
                                                Icon(
                                              Icons.star_rounded,
                                              color:
                                                  AppTheme.of(context)
                                                      .primary,
                                            ),
                                            direction: Axis.horizontal,
                                            initialRating:
                                                _model.ratingBarValue ??= 4.0,
                                            unratedColor:
                                                AppTheme.of(context)
                                                    .accent1,
                                            itemCount: 5,
                                            itemSize: 20.0,
                                            glowColor:
                                                AppTheme.of(context)
                                                    .primary,
                                          ),
                                          Text(
                                            '\"The payment system is\ntransparent and secure. I felt\nconfident hiring through the\napp.\"',
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
                                          Text(
                                            '— ELENA R.',
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
                                                  color: AppTheme.of(
                                                          context)
                                                      .accent1,
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
                                            height: AppTheme.of(context)
                                                .designToken
                                                .spacing
                                                .lg)),
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
                                    child: Container(
                                      width: double.infinity,
                                      height: 84.0,
                                      decoration: BoxDecoration(
                                        color: AppTheme.of(context)
                                            .alternate,
                                        borderRadius: BorderRadius.circular(
                                            AppTheme.of(context)
                                                .designToken
                                                .radius
                                                .md),
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Icon(
                                            Icons.security,
                                            color: AppTheme.of(context)
                                                .accent1,
                                            size: 22.0,
                                          ),
                                          Text(
                                            'Active Bids',
                                            style: AppTheme.of(context)
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
                                        ]
                                            .divide(SizedBox(
                                                width:
                                                    AppTheme.of(context)
                                                        .designToken
                                                        .spacing
                                                        .lg))
                                            .around(SizedBox(
                                                width:
                                                    AppTheme.of(context)
                                                        .designToken
                                                        .spacing
                                                        .lg)),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: double.infinity,
                                    height: 84.0,
                                    decoration: BoxDecoration(
                                      color: AppTheme.of(context)
                                          .alternate,
                                      borderRadius: BorderRadius.circular(
                                          AppTheme.of(context)
                                              .designToken
                                              .radius
                                              .md),
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Icon(
                                          Icons.support_agent_outlined,
                                          color: AppTheme.of(context)
                                              .accent1,
                                          size: 22.0,
                                        ),
                                        Text(
                                          '24/7 Dispute Resolution',
                                          style: AppTheme.of(context)
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
                                      ]
                                          .divide(SizedBox(
                                              width:
                                                  AppTheme.of(context)
                                                      .designToken
                                                      .spacing
                                                      .lg))
                                          .around(SizedBox(
                                              width:
                                                  AppTheme.of(context)
                                                      .designToken
                                                      .spacing
                                                      .lg)),
                                    ),
                                  ),
                                ]
                                    .divide(SizedBox(
                                        height: AppTheme.of(context)
                                            .designToken
                                            .spacing
                                            .md))
                                    .addToEnd(const SizedBox(height: 50.0)),
                              ),
                            ),
                          ],
                        ),
                        Align(
                          alignment: const AlignmentDirectional(0.0, 1.0),
                          child: Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                0.0, 0.0, 0.0, 16.0),
                            child: smooth_page_indicator.SmoothPageIndicator(
                              controller: _model.pageViewController ??=
                                  PageController(initialPage: 0),
                              count: 3,
                              axisDirection: Axis.horizontal,
                              onDotClicked: (i) async {
                                await _model.pageViewController!.animateToPage(
                                  i,
                                  duration: const Duration(milliseconds: 500),
                                  curve: Curves.ease,
                                );
                                _provider.update(() {});
                              },
                              effect: smooth_page_indicator.SlideEffect(
                                spacing: 8.0,
                                radius: 8.0,
                                dotWidth: 8.0,
                                dotHeight: 8.0,
                                dotColor: AppTheme.of(context).accent1,
                                activeDotColor:
                                    AppTheme.of(context).primary,
                                paintStyle: PaintingStyle.stroke,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(
                      0.0,
                      AppTheme.of(context).designToken.spacing.lg,
                      0.0,
                      AppTheme.of(context).designToken.spacing.lg),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      if (_model.pageViewCurrentIndex > 0)
                        AppIconButton(
                          borderRadius: 8.0,
                          buttonSize: 56.0,
                          fillColor: Colors.transparent,
                          icon: Icon(
                            Icons.arrow_back,
                            color: AppTheme.of(context).primary,
                            size: 24.0,
                          ),
                          onPressed: () async {
                            await _model.pageViewController?.previousPage(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.ease,
                            );
                            _provider.update(() {});
                          },
                        ),
                      Container(
                        decoration: BoxDecoration(
                          color:
                              AppTheme.of(context).secondaryBackground,
                        ),
                      ),
                      AppIconButton(
                        borderRadius: 8.0,
                        buttonSize: 56.0,
                        fillColor: AppTheme.of(context).primary,
                        icon: Icon(
                          Icons.arrow_forward,
                          color: AppTheme.of(context).alternate,
                          size: 24.0,
                        ),
                        onPressed: () async {
                          if (_model.pageViewCurrentIndex != 2) {
                            AppState().onboarding = true;
                            await _model.pageViewController?.nextPage(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.ease,
                            );
                            _provider.update(() {});
                          } else {
                            context.goNamed(LoginWidget.routeName);
                          }
                        },
                      ),
                    ],
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
