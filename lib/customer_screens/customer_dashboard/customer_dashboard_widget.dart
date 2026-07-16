import '/auth/supabase_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/backend/schema/enums/enums.dart';
import '/components/appbar_component/appbar_component_widget.dart';
import '/components/customer_navbar/customer_navbar_widget.dart';
import '/components/jobs_list/jobs_list_widget.dart';
import '/components/stats/stats_widget.dart';
import '/components/text_button/text_button_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'customer_dashboard_model.dart';
export 'customer_dashboard_model.dart';

class CustomerDashboardWidget extends StatefulWidget {
  const CustomerDashboardWidget({super.key});

  static String routeName = 'customer_dashboard';
  static String routePath = '/customerDashboard';

  @override
  State<CustomerDashboardWidget> createState() =>
      _CustomerDashboardWidgetState();
}

class _CustomerDashboardWidgetState extends State<CustomerDashboardWidget> {
  late CustomerDashboardModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => CustomerDashboardModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {});

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        appBar: AppBar(
          backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
          automaticallyImplyLeading: false,
          title: wrapWithModel(
            model: _model.appbarComponentModel,
            updateCallback: () => safeSetState(() {}),
            child: AppbarComponentWidget(
              title: 'Home',
              showAction: true,
              actionIcon: Icon(
                Icons.notifications_rounded,
                color: FlutterFlowTheme.of(context).secondary,
                size: 26.0,
              ),
              action: () async {
                context.pushNamed(NotificationPageWidget.routeName);
              },
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
                  FFAppConstants.parentPagePadding,
                  0.0,
                )),
                child: FutureBuilder<ApiCallResponse>(
                  future: SupabaseTablesGroup.getJobsListCall.call(
                    params: '&status=eq.ACTIVE',
                    range: currentUserUid,
                  ),
                  builder: (context, snapshot) {
                    // Customize what your widget looks like when it's loading.
                    if (!snapshot.hasData) {
                      return Center(
                        child: SizedBox(
                          width: 50.0,
                          height: 50.0,
                          child: SpinKitFadingCube(
                            color: FlutterFlowTheme.of(context).primary,
                            size: 50.0,
                          ),
                        ),
                      );
                    }
                    final columnGetJobsListResponse = snapshot.data!;

                    return SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Align(
                            alignment: AlignmentDirectional(-1.0, 0.0),
                            child: Container(
                              decoration: BoxDecoration(
                                color: FlutterFlowTheme.of(context)
                                    .secondaryBackground,
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'DASHBOARD',
                                    style: FlutterFlowTheme.of(context)
                                        .bodyLarge
                                        .override(
                                          font: GoogleFonts.manrope(
                                            fontWeight:
                                                FlutterFlowTheme.of(context)
                                                    .bodyLarge
                                                    .fontWeight,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .bodyLarge
                                                    .fontStyle,
                                          ),
                                          color: FlutterFlowTheme.of(context)
                                              .primary,
                                          letterSpacing: 1.6,
                                          fontWeight:
                                              FlutterFlowTheme.of(context)
                                                  .bodyLarge
                                                  .fontWeight,
                                          fontStyle:
                                              FlutterFlowTheme.of(context)
                                                  .bodyLarge
                                                  .fontStyle,
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
                                Container(
                                  width: double.infinity,
                                  height: 8.0,
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [
                                        FlutterFlowTheme.of(context).primary,
                                        FlutterFlowTheme.of(context).secondary
                                      ],
                                      stops: [0.0, 1.0],
                                      begin: AlignmentDirectional(-1.0, 0.14),
                                      end: AlignmentDirectional(1.0, -0.14),
                                    ),
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(
                                          FlutterFlowTheme.of(context)
                                              .designToken
                                              .radius
                                              .lg),
                                      topRight: Radius.circular(
                                          FlutterFlowTheme.of(context)
                                              .designToken
                                              .radius
                                              .lg),
                                    ),
                                  ),
                                ),
                                Material(
                                  color: Colors.transparent,
                                  elevation: 0.0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(
                                          FlutterFlowTheme.of(context)
                                              .designToken
                                              .radius
                                              .lg),
                                      bottomRight: Radius.circular(
                                          FlutterFlowTheme.of(context)
                                              .designToken
                                              .radius
                                              .lg),
                                    ),
                                  ),
                                  child: Container(
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryBackground,
                                      boxShadow: [
                                        FlutterFlowTheme.of(context)
                                            .designToken
                                            .shadow
                                            .sm
                                      ],
                                      borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(
                                            FlutterFlowTheme.of(context)
                                                .designToken
                                                .radius
                                                .lg),
                                        bottomRight: Radius.circular(
                                            FlutterFlowTheme.of(context)
                                                .designToken
                                                .radius
                                                .lg),
                                      ),
                                    ),
                                    child: Padding(
                                      padding:
                                          EdgeInsets.all(valueOrDefault<double>(
                                        FFAppConstants.childPadding,
                                        0.0,
                                      )),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Need something done',
                                            style: FlutterFlowTheme.of(context)
                                                .headlineSmall
                                                .override(
                                                  font: GoogleFonts.inter(
                                                    fontWeight: FontWeight.w800,
                                                    fontStyle:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .headlineSmall
                                                            .fontStyle,
                                                  ),
                                                  letterSpacing: 0.0,
                                                  fontWeight: FontWeight.w800,
                                                  fontStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .headlineSmall
                                                          .fontStyle,
                                                ),
                                          ),
                                          Text(
                                            'Post your job and get responses from\ntrusted tradespeople.',
                                            style: FlutterFlowTheme.of(context)
                                                .bodyMedium
                                                .override(
                                                  font: GoogleFonts.manrope(
                                                    fontWeight:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .bodyMedium
                                                            .fontWeight,
                                                    fontStyle:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .bodyMedium
                                                            .fontStyle,
                                                  ),
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .secondaryText,
                                                  letterSpacing: 0.0,
                                                  fontWeight:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMedium
                                                          .fontWeight,
                                                  fontStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMedium
                                                          .fontStyle,
                                                ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.all(2.0),
                                            child: FFButtonWidget(
                                              onPressed: () async {
                                                context.pushNamed(
                                                    AddJobWidget.routeName);
                                              },
                                              text: 'Post a Job',
                                              icon: Icon(
                                                Icons.arrow_forward,
                                                size: 30.0,
                                              ),
                                              options: FFButtonOptions(
                                                width: double.infinity,
                                                height: 60.0,
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        16.0, 0.0, 16.0, 0.0),
                                                iconAlignment:
                                                    IconAlignment.end,
                                                iconPadding:
                                                    EdgeInsetsDirectional
                                                        .fromSTEB(
                                                            0.0, 0.0, 0.0, 0.0),
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .primary,
                                                textStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .titleSmall
                                                        .override(
                                                          font:
                                                              GoogleFonts.inter(
                                                            fontWeight:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .titleSmall
                                                                    .fontWeight,
                                                            fontStyle:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .titleSmall
                                                                    .fontStyle,
                                                          ),
                                                          color: Colors.white,
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .titleSmall
                                                                  .fontWeight,
                                                          fontStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .titleSmall
                                                                  .fontStyle,
                                                        ),
                                                elevation: 0.0,
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .designToken
                                                            .radius
                                                            .lg),
                                              ),
                                            ),
                                          ),
                                        ].divide(SizedBox(
                                            height:
                                                FFAppConstants.childSpacing)),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          wrapWithModel(
                            model: _model.statsModel1,
                            updateCallback: () => safeSetState(() {}),
                            child: StatsWidget(
                              iconBackgroundColor: Color(0x4E2C4EB8),
                              icon: Icon(
                                Icons.work_outline,
                                color: FlutterFlowTheme.of(context).primary,
                                size: 30.0,
                              ),
                              value: FFAppState().jobCache.jobs.length,
                              title: 'Active Jobs',
                              valueColor: FlutterFlowTheme.of(context).primary,
                            ),
                          ),
                          wrapWithModel(
                            model: _model.statsModel2,
                            updateCallback: () => safeSetState(() {}),
                            child: StatsWidget(
                              iconBackgroundColor:
                                  FlutterFlowTheme.of(context).accent2,
                              icon: Icon(
                                Icons.forum_rounded,
                                color: FlutterFlowTheme.of(context).secondary,
                                size: 30.0,
                              ),
                              value: functions.sumList(FFAppState()
                                  .jobCache
                                  .jobs
                                  .map((e) => e.applications.firstOrNull?.count)
                                  .withoutNulls
                                  .toList()),
                              title: 'Responses',
                              valueColor:
                                  FlutterFlowTheme.of(context).secondary,
                            ),
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'RECENT ACTIVITY',
                                style: FlutterFlowTheme.of(context)
                                    .headlineSmall
                                    .override(
                                      font: GoogleFonts.inter(
                                        fontWeight: FontWeight.w600,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .headlineSmall
                                            .fontStyle,
                                      ),
                                      letterSpacing: 0.0,
                                      fontWeight: FontWeight.w600,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .headlineSmall
                                          .fontStyle,
                                    ),
                              ),
                              wrapWithModel(
                                model: _model.textButtonModel,
                                updateCallback: () => safeSetState(() {}),
                                child: TextButtonWidget(
                                  label: 'View All',
                                  color: FlutterFlowTheme.of(context).primary,
                                  action: () async {
                                    context.pushNamed(
                                        CustomerAllJobsWidget.routeName);
                                  },
                                ),
                              ),
                            ],
                          ),
                          wrapWithModel(
                            model: _model.jobsListModel,
                            updateCallback: () => safeSetState(() {}),
                            child: JobsListWidget(
                              jobViewType: JobsViewType.DASHBOARD,
                            ),
                          ),
                        ]
                            .divide(SizedBox(height: FFAppConstants.spacing))
                            .addToEnd(SizedBox(height: 100.0)),
                      ),
                    );
                  },
                ),
              ),
              Align(
                alignment: AlignmentDirectional(0.0, 1.0),
                child: wrapWithModel(
                  model: _model.customerNavbarModel,
                  updateCallback: () => safeSetState(() {}),
                  child: CustomerNavbarWidget(
                    selectedIndex: 0,
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
