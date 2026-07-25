import '/auth/supabase_auth/auth_util.dart';
import '/repositories/supabase/supabase.dart';
import '/widgets/components/applogo_component/applogo_component_widget.dart';
import '/widgets/components/info_cards_component/info_cards_component_widget.dart';
import '/widgets/components/testimonials_component/testimonials_component_widget.dart';
import '/core/utils/animations.dart';
import '/widgets/app_icon_button.dart';
import '/core/theme/app_theme.dart';
import '/utils/util.dart';
import '/widgets/app_button.dart';
import 'dart:ui';
import '/utils/custom_code/actions/index.dart' as actions;
import '/core/routes/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import '/viewmodels/home_model.dart';
export '/viewmodels/home_model.dart';

class HomeWidget extends StatefulWidget {
  const HomeWidget({super.key});

  static String routeName = 'home';
  static String routePath = '/home';

  @override
  State<HomeWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> with TickerProviderStateMixin {
  late HomeModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  final animationsMap = <String, AnimationInfo>{};

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => HomeModel());

    animationsMap.addAll({
      'columnOnPageLoadAnimation': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          FadeEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 250.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
          MoveEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 350.0.ms,
            begin: const Offset(0.0, 20.0),
            end: const Offset(0.0, 0.0),
          ),
        ],
      ),
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
        backgroundColor: AppTheme.of(context).secondaryBackground,
        body: SafeArea(
          top: true,
          child: Padding(
            padding: EdgeInsets.all(valueOrDefault<double>(
              AppConstants.parentPagePadding,
              0.0,
            )),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      wrapWithModel(
                        model: _model.applogoComponentModel,
                        updateCallback: () => safeSetState(() {}),
                        child: const Hero(
                          tag: 'logoTag',
                          transitionOnUserGestures: true,
                          child: Material(
                            color: Colors.transparent,
                            child: ApplogoComponentWidget(),
                          ),
                        ),
                      ),
                      AppIconButton(
                        borderRadius: 8.0,
                        buttonSize: 40.0,
                        fillColor:
                            AppTheme.of(context).primaryBackground,
                        icon: Icon(
                          Icons.logout_sharp,
                          color: AppTheme.of(context).primary,
                          size: 24.0,
                        ),
                        onPressed: () async {
                          GoRouter.of(context).prepareAuthEvent();
                          await authManager.signOut();
                          GoRouter.of(context).clearRedirectLocation();

                          context.goNamedAuth(
                              LoginWidget.routeName, context.mounted);
                        },
                      ),
                    ],
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: AppTheme.of(context).primaryBackground,
                      borderRadius: BorderRadius.circular(12.0),
                      border: Border.all(
                        color: AppTheme.of(context).border,
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(valueOrDefault<double>(
                        AppConstants.childPadding,
                        0.0,
                      )),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Whether you’re a customer looking for trusted tradespeople or a professional seeking new work, \'My Trade Pal\' makes it simple.',
                            textAlign: TextAlign.center,
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
                        ].divide(const SizedBox(height: AppConstants.spacing)),
                      ),
                    ),
                  ),
                  wrapWithModel(
                    model: _model.infoCardsComponentModel1,
                    updateCallback: () => safeSetState(() {}),
                    child: InfoCardsComponentWidget(
                      icon: Icon(
                        Icons.info_rounded,
                        color: AppTheme.of(context).primary,
                        size: 24.0,
                      ),
                      title: 'How My Trade Pal works',
                      description:
                          'Whether you’re a customer looking for trusted tradespeople or a professional seeking new work, \'My Trade Pal\' makes it simple',
                      image:
                          'https://plus.unsplash.com/premium_photo-1661295675442-f151fdf7ba52?fm=jpg&q=60&w=3000&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
                    ),
                  ),
                  wrapWithModel(
                    model: _model.infoCardsComponentModel2,
                    updateCallback: () => safeSetState(() {}),
                    child: InfoCardsComponentWidget(
                      icon: Icon(
                        Icons.info_rounded,
                        color: AppTheme.of(context).primary,
                        size: 24.0,
                      ),
                      title: 'Why choose Trade-Pal',
                      description:
                          '✅  Post your job or browse available work\n\n✅  Get matched with verified tradespeople\n\n✅  Compare trade profiles & get the job done',
                      image:
                          'https://media.istockphoto.com/id/2180759771/photo/a-carpenter-uses-a-power-drill-to-secure-beams-in-a-daylight-attic-renovation.webp?a=1&b=1&s=612x612&w=0&k=20&c=NZola5wnP5tIra21GXM-ePHj1qmO99KqEc1wt-PmpYE=',
                    ),
                  ),
                  wrapWithModel(
                    model: _model.infoCardsComponentModel3,
                    updateCallback: () => safeSetState(() {}),
                    child: InfoCardsComponentWidget(
                      icon: Icon(
                        Icons.verified_rounded,
                        color: AppTheme.of(context).success,
                        size: 24.0,
                      ),
                      title: 'Trusted and secure',
                      description:
                          '✅   Reviews are from real customers\n\n✅   Payments protected through Stripe\n\n✅   No hidden fees\n\n✅   You stay in control',
                      image:
                          'https://images.unsplash.com/photo-1603899122361-e99b4f6fecf5?fm=jpg&q=60&w=3000&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTR8fHNlY3VyZXxlbnwwfHwwfHx8MA%3D%3D',
                    ),
                  ),
                  Align(
                    alignment: const AlignmentDirectional(0.0, 0.0),
                    child: AppButton(
                      onPressed: () async {
                        await UsersTable().update(
                          data: {
                            'onboarding_step': 2,
                          },
                          matchingRows: (rows) => rows.eqOrNull(
                            'id',
                            currentUserUid,
                          ),
                        );
                        await actions.checkUserSession(
                          context,
                        );
                      },
                      text: 'Get Started',
                      icon: const FaIcon(
                        FontAwesomeIcons.share,
                        size: 15.0,
                      ),
                      options: AppButtonOptions(
                        width: 300.0,
                        height: 50.0,
                        padding: const EdgeInsetsDirectional.fromSTEB(
                            16.0, 0.0, 16.0, 0.0),
                        iconPadding:
                            const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                        color: AppTheme.of(context).primary,
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
                            AppTheme.of(context).designToken.radius.lg),
                      ),
                    ),
                  ),
                  wrapWithModel(
                    model: _model.testimonialsComponentModel,
                    updateCallback: () => safeSetState(() {}),
                    child: const TestimonialsComponentWidget(),
                  ),
                ]
                    .divide(const SizedBox(height: 32.0))
                    .addToStart(const SizedBox(height: 24.0))
                    .addToEnd(const SizedBox(height: 24.0)),
              ),
            ).animateOnPageLoad(animationsMap['columnOnPageLoadAnimation']!),
          ),
        ),
      ),
    );
  }
}