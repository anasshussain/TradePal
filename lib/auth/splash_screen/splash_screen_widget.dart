import '/auth/supabase_auth/auth_util.dart';
import '/repositories/api_requests/api_calls.dart';
import '/models/structs/index.dart';
import '/core/theme/app_theme.dart';
import '/utils/util.dart';
import '/widgets/app_button.dart';
import 'dart:ui';
import '/utils/custom_code/actions/index.dart' as actions;
import '/core/routes/index.dart';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '/viewmodels/splash_screen_model.dart';
export '/viewmodels/splash_screen_model.dart';

class SplashScreenWidget extends StatefulWidget {
  const SplashScreenWidget({super.key});

  static String routeName = 'splash_screen';
  static String routePath = '/splashScreen';

  @override
  State<SplashScreenWidget> createState() => _SplashScreenWidgetState();
}

class _SplashScreenWidgetState extends State<SplashScreenWidget> {
  late SplashScreenModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SplashScreenModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      await Future.delayed(
        Duration(
          milliseconds: 3000,
        ),
      );
      if (AppState().onboarding == true) {
        await actions.checkUserSession(
          context,
        );
        await Future.wait([
          Future(() async {
            _model.apiResultUserProfile =
                await SupabaseTablesGroup.getUserCall.call(
              userId: currentUserUid,
            );

            if ((_model.apiResultUserProfile?.succeeded ?? true)) {
              AppState().userProfileCache =
                  ((_model.apiResultUserProfile?.jsonBody ?? '')
                          .toList()
                          .map<UserStruct?>(UserStruct.maybeFromMap)
                          .toList() as Iterable<UserStruct?>)
                      .withoutNulls
                      .firstOrNull!;
              AppState().update(() {});
            }
          }),
          Future(() async {
            _model.totalCount =
                await SupbaseRpcGroup.getTotalUnreadCall.call(
              authtoken: currentJwtToken,
            );
            debugPrint('Total Count: ${_model.totalCount?.jsonBody}');
            if ((_model.totalCount?.succeeded ?? true)) {
              AppState().totalMessagesCount = SupbaseRpcGroup
                      .getTotalUnreadCall
                      .totalCount(_model.totalCount?.jsonBody) ??
                  0;
            }
          }),
        ]);
      } else {
        context.goNamed(
          OnboardingWidget.routeName,
          extra: <String, dynamic>{
            '__transition_info__': TransitionInfo(
              hasTransition: true,
              transitionType: PageTransitionType.fade,
              duration: Duration(milliseconds: 0),
            ),
          },
        );
      }
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
    context.watch<AppState>();

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
          child: Stack(
            children: [
              Align(
                alignment: AlignmentDirectional(0.0, 0.0),
                child: Padding(
                  padding: EdgeInsets.all(valueOrDefault<double>(
                    AppConstants.parentPagePadding,
                    0.0,
                  )),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Material(
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
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: 1.0,
                                height: 20.0,
                                decoration: BoxDecoration(
                                  color: AppTheme.of(context).alternate,
                                ),
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width: 20.0,
                                    height: 1.0,
                                    decoration: BoxDecoration(
                                      color: AppTheme.of(context).alternate,
                                    ),
                                  ),
                                  Material(
                                    color: Colors.transparent,
                                    elevation: 0.0,
                                    child: Container(
                                      decoration: BoxDecoration(),
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                        child: Image.asset(
                                          'assets/images/logo-removebg-preview.png',
                                          width: 80.0,
                                          height: 80.0,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: 20.0,
                                    height: 1.0,
                                    decoration: BoxDecoration(
                                      color: AppTheme.of(context).alternate,
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                width: 1.0,
                                height: 20.0,
                                decoration: BoxDecoration(
                                  color: AppTheme.of(context).alternate,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Text(
                              'My Trade Pal',
                              style:
                                  AppTheme.of(context).displayMedium.override(
                                        font: GoogleFonts.manrope(
                                          fontWeight: AppTheme.of(context)
                                              .displayMedium
                                              .fontWeight,
                                          fontStyle: AppTheme.of(context)
                                              .displayMedium
                                              .fontStyle,
                                        ),
                                        letterSpacing: 0.0,
                                        fontWeight: AppTheme.of(context)
                                            .displayMedium
                                            .fontWeight,
                                        fontStyle: AppTheme.of(context)
                                            .displayMedium
                                            .fontStyle,
                                      ),
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  width: MediaQuery.sizeOf(context).width * 0.1,
                                  height: 2.0,
                                  decoration: BoxDecoration(
                                    color: AppTheme.of(context).alternate,
                                  ),
                                ),
                                Text(
                                  'Find Trusted Trades-Or Your Next Job',
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
                                        color:
                                            AppTheme.of(context).secondaryText,
                                        letterSpacing: 0.0,
                                        fontWeight: AppTheme.of(context)
                                            .labelSmall
                                            .fontWeight,
                                        fontStyle: AppTheme.of(context)
                                            .labelSmall
                                            .fontStyle,
                                      ),
                                ),
                                Container(
                                  width: MediaQuery.sizeOf(context).width * 0.1,
                                  height: 2.0,
                                  decoration: BoxDecoration(
                                    color: AppTheme.of(context).alternate,
                                  ),
                                ),
                              ].divide(
                                  SizedBox(width: AppConstants.childSpacing)),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        'The simplest way to connect skilled tradespeople with homeowners. No stress, no hidden fees, just quality local work.',
                        textAlign: TextAlign.center,
                        style: AppTheme.of(context).labelMedium.override(
                              font: GoogleFonts.inter(
                                fontWeight:
                                    AppTheme.of(context).labelMedium.fontWeight,
                                fontStyle:
                                    AppTheme.of(context).labelMedium.fontStyle,
                              ),
                              letterSpacing: 0.0,
                              fontWeight:
                                  AppTheme.of(context).labelMedium.fontWeight,
                              fontStyle:
                                  AppTheme.of(context).labelMedium.fontStyle,
                            ),
                      ),
                    ].divide(SizedBox(height: AppConstants.spacing)),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(valueOrDefault<double>(
                  AppConstants.parentPagePadding,
                  0.0,
                )),
                child: Transform.rotate(
                  angle: 90.0 * (math.pi / 180),
                  child: Container(
                    width: 100.0,
                    height: 112.0,
                    decoration: BoxDecoration(),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Align(
                          alignment: AlignmentDirectional(0.0, -1.0),
                          child: Container(
                            width: 100.0,
                            height: 93.0,
                            decoration: BoxDecoration(
                              color: AppTheme.of(context).primaryBackground,
                              boxShadow: [
                                BoxShadow(
                                  blurRadius: 0.0,
                                  color: AppTheme.of(context).alternate,
                                  offset: Offset(
                                    -1.0,
                                    1.0,
                                  ),
                                  spreadRadius: 0.0,
                                )
                              ],
                            ),
                            child: Align(
                              alignment: AlignmentDirectional(-1.0, 1.0),
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    valueOrDefault<double>(
                                      AppConstants.childPadding,
                                      0.0,
                                    ),
                                    0.0,
                                    0.0,
                                    0.0),
                                child: Text(
                                  'LEVEL 00',
                                  style: GoogleFonts.roboto(
                                    color: AppTheme.of(context).secondaryText,
                                    fontSize: 9.0,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Align(
                          alignment: AlignmentDirectional(-1.0, 1.0),
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                valueOrDefault<double>(
                                  AppConstants.childPadding,
                                  0.0,
                                ),
                                0.0,
                                0.0,
                                0.0),
                            child: Text(
                              'BASE',
                              style: GoogleFonts.roboto(
                                color: AppTheme.of(context).secondaryText,
                                fontSize: 9.0,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Align(
                alignment: AlignmentDirectional(1.0, 1.0),
                child: Container(
                  width: 97.0,
                  decoration: BoxDecoration(),
                  child: Padding(
                    padding: EdgeInsets.all(valueOrDefault<double>(
                      AppConstants.parentPagePadding,
                      0.0,
                    )),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          'System status',
                          textAlign: TextAlign.end,
                          style: AppTheme.of(context).labelSmall.override(
                                font: GoogleFonts.inter(
                                  fontWeight: AppTheme.of(context)
                                      .labelSmall
                                      .fontWeight,
                                  fontStyle:
                                      AppTheme.of(context).labelSmall.fontStyle,
                                ),
                                letterSpacing: 0.0,
                                fontWeight:
                                    AppTheme.of(context).labelSmall.fontWeight,
                                fontStyle:
                                    AppTheme.of(context).labelSmall.fontStyle,
                              ),
                        ),
                        Text(
                          'Calibrating Workspace',
                          textAlign: TextAlign.end,
                          style: AppTheme.of(context).bodySmall.override(
                                font: GoogleFonts.manrope(
                                  fontWeight:
                                      AppTheme.of(context).bodySmall.fontWeight,
                                  fontStyle:
                                      AppTheme.of(context).bodySmall.fontStyle,
                                ),
                                letterSpacing: 0.0,
                                fontWeight:
                                    AppTheme.of(context).bodySmall.fontWeight,
                                fontStyle:
                                    AppTheme.of(context).bodySmall.fontStyle,
                              ),
                        ),
                      ].divide(SizedBox(height: AppConstants.childSpacing)),
                    ),
                  ),
                ),
              ),
              Align(
                alignment: AlignmentDirectional(-1.0, 1.0),
                child: Padding(
                  padding: EdgeInsets.all(valueOrDefault<double>(
                    AppConstants.parentPagePadding,
                    0.0,
                  )),
                  child: Transform.rotate(
                    angle: 45.0 * (math.pi / 180),
                    child: Container(
                      width: 100.0,
                      height: 100.0,
                      decoration: BoxDecoration(
                        color: AppTheme.of(context).primaryBackground,
                        border: Border.all(
                          color: AppTheme.of(context).alternate,
                          width: 1.0,
                        ),
                      ),
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
