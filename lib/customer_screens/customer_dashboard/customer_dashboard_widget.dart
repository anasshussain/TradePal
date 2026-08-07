import 'package:flutter/services.dart';
import 'package:my_trade_pal/widgets/exit_confirmation_dialog.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../widgets/page_header.dart';
import '/auth/supabase_auth/auth_util.dart';
import '/repositories/api_requests/api_calls.dart';
import '/utils/enums/enums.dart';
import '/models/structs/index.dart';
import '/widgets/components/appbar_component/appbar_component_widget.dart';
import '/widgets/components/customer_navbar/customer_navbar_widget.dart';
import '/widgets/components/jobs_list/jobs_list_widget.dart';
import '/widgets/components/stats/stats_widget.dart';
import '/widgets/components/text_button/text_button_widget.dart';
import '/core/theme/app_theme.dart';
import '/utils/util.dart';
import '/widgets/app_button.dart';
import 'dart:ui';
import '/utils/custom_functions.dart' as functions;
import '/core/routes/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '/providers/customer_dashboard_provider.dart';
import '/viewmodels/customer_dashboard_model.dart';
export '/viewmodels/customer_dashboard_model.dart';

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
  final CustomerDashboardProvider _provider = CustomerDashboardProvider();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  static bool _hasLoadedJobsOnce = false;
  late Future<ApiCallResponse> _jobsListFuture;

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => CustomerDashboardModel());
    _jobsListFuture = _fetchJobs();

    SchedulerBinding.instance.addPostFrameCallback((_) async {});
  }

  Future<ApiCallResponse> _fetchJobs() async {
    final response = await SupabaseTablesGroup.getJobsListCall.call(
      params: '&customer_id=eq.${currentUserUid}',
    );
    if (response.succeeded) {
      AppState().jobCache = JobCacheStruct(
        jobs: ((response.jsonBody ?? '')
                .toList()
                .map<JobsListItemStruct?>(JobsListItemStruct.maybeFromMap)
                .toList() as Iterable<JobsListItemStruct?>)
            .withoutNulls,
        lastCursor: '',
        firstCursor: '',
        hasMore: true,
      );
    }
    _hasLoadedJobsOnce = true;
    return response;
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
    return ChangeNotifierProvider<CustomerDashboardProvider>.value(
      value: _provider,
      child: Consumer<CustomerDashboardProvider>(
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
        // appBar: AppBar(
        //   backgroundColor: AppTheme.of(context).primaryBackground,
        //   automaticallyImplyLeading: false,
        //   title: wrapWithModel(
        //     model: _model.appbarComponentModel,
        //     updateCallback: () => _provider.update(() {}),
        //     child: AppbarComponentWidget(
        //       title: 'Home',
        //       showAction: true,
        //       actionIcon: SvgPicture.asset(
        //         'assets/images/bell.svg',
        //         width: 21.5,
        //         height: 21.5,
        //         colorFilter: const ColorFilter.mode(
        //           Color(0xFF1B7FA3),
        //           BlendMode.srcIn,
        //         ),
        //       ),
        //       action: () async {
        //         context.pushNamed(NotificationPageWidget.routeName);
        //       },
        //     ),
        //   ),
        //   actions: const [],
        //   centerTitle: false,
        //   elevation: 0.0,
        // ),
        body: SafeArea(
          // top: true,
          child: Stack(
            children: [
              Padding(
                padding: EdgeInsets.all(valueOrDefault<double>(
                  AppConstants.parentPagePadding,
                  0.0,
                )),
                child: FutureBuilder<ApiCallResponse>(
                  future: _jobsListFuture,
                  builder: (context, snapshot) {
                    final isLoading = !_hasLoadedJobsOnce &&
                        snapshot.connectionState == ConnectionState.waiting;

                    return RefreshIndicator(
                      color: AppTheme.of(context).primary,
                      onRefresh: () async {
                        final future = _fetchJobs();
                        setState(() {
                          _jobsListFuture = future;
                        });
                        await future;
                      },
                      child: SingleChildScrollView(
                        child: Skeletonizer(
                          enabled: isLoading,
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Align(
                                alignment:
                                    const AlignmentDirectional(-1.0, 0.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: AppTheme.of(context)
                                        .secondaryBackground,
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'DASHBOARD',
                                        style: AppTheme.of(context)
                                            .bodyLarge
                                            .override(
                                              font: GoogleFonts.manrope(
                                                fontWeight: AppTheme.of(context)
                                                    .bodyLarge
                                                    .fontWeight,
                                                fontStyle: AppTheme.of(context)
                                                    .bodyLarge
                                                    .fontStyle,
                                              ),
                                              color:
                                                  AppTheme.of(context).primary,
                                              letterSpacing: 1.6,
                                              fontWeight: AppTheme.of(context)
                                                  .bodyLarge
                                                  .fontWeight,
                                              fontStyle: AppTheme.of(context)
                                                  .bodyLarge
                                                  .fontStyle,
                                            ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                decoration: const BoxDecoration(),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Container(
                                      width: double.infinity,
                                      height: 8.0,
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          colors: [
                                            AppTheme.of(context).primary,
                                            AppTheme.of(context).secondary
                                          ],
                                          stops: const [0.0, 1.0],
                                          begin: const AlignmentDirectional(
                                              -1.0, 0.14),
                                          end: const AlignmentDirectional(
                                              1.0, -0.14),
                                        ),
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(
                                              AppTheme.of(context)
                                                  .designToken
                                                  .radius
                                                  .lg),
                                          topRight: Radius.circular(
                                              AppTheme.of(context)
                                                  .designToken
                                                  .radius
                                                  .lg),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      decoration: const BoxDecoration(),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Container(
                                            width: double.infinity,
                                            height: 8.0,
                                            decoration: BoxDecoration(
                                              color: AppTheme.of(context)
                                                  .secondaryBackground,
                                              boxShadow: [
                                                AppTheme.of(context)
                                                    .designToken
                                                    .radius
                                                    .lg),
                                          ),
                                        ),
                                        child: Padding(
                                          padding: EdgeInsets.all(
                                              valueOrDefault<double>(
                                            AppConstants.childPadding,
                                            0.0,
                                          )),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.max,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                ' Need something done',
                                                style: AppTheme.of(context)
                                                    .headlineSmall
                                                    .override(
                                                      font: GoogleFonts.inter(
                                                        fontWeight:
                                                            FontWeight.w800,
                                                        fontStyle:
                                                            AppTheme.of(context)
                                                                .headlineSmall
                                                                .fontStyle,
                                                      ),
                                                      letterSpacing: 0.0,
                                                      fontWeight:
                                                          FontWeight.w800,
                                                      fontStyle:
                                                          AppTheme.of(context)
                                                              .headlineSmall
                                                              .fontStyle,
                                                    ),
                                              ),
                                              Text(
                                                'Post your job and get responses from\ntrusted tradespeople.',
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
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(2.0),
                                                child: AppButton(
                                                  onPressed: () async {
                                                    context.pushNamed(
                                                        AddJobWidget.routeName);
                                                  },
                                                  text: 'Post a Job',
                                                  icon: const Icon(
                                                    Icons.arrow_forward,
                                                    size: 30.0,
                                                  ),
                                                  options: AppButtonOptions(
                                                    width: double.infinity,
                                                    height: 60.0,
                                                    padding:
                                                        const EdgeInsetsDirectional
                                                            .fromSTEB(16.0, 0.0,
                                                            16.0, 0.0),
                                                    iconAlignment:
                                                        IconAlignment.end,
                                                    iconPadding:
                                                        const EdgeInsetsDirectional
                                                            .fromSTEB(
                                                            0.0, 0.0, 0.0, 0.0),
                                                    color: AppTheme.of(context)
                                                        .primary,
                                                    textStyle: AppTheme.of(
                                                            context)
                                                        .titleSmall
                                                        .override(
                                                          font:
                                                              GoogleFonts.inter(
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
                                                          color: Colors.white,
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
                                                    elevation: 0.0,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            AppTheme.of(context)
                                                                .designToken
                                                                .radius
                                                                .lg),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets.all(2.0),
                                                    child: AppButton(
                                                      onPressed: () async {
                                                        context.pushNamed(
                                                            AddJobWidget.routeName);
                                                      },
                                                      text: 'Post a Job',
                                                      icon: const Icon(
                                                        Icons.arrow_forward,
                                                        size: 30.0,
                                                      ),
                                                      options: AppButtonOptions(
                                                        width: double.infinity,
                                                        height: 60.0,
                                                        padding: const EdgeInsetsDirectional
                                                            .fromSTEB(
                                                            16.0, 0.0, 16.0, 0.0),
                                                        iconAlignment:
                                                        IconAlignment.end,
                                                        iconPadding:
                                                        const EdgeInsetsDirectional
                                                            .fromSTEB(
                                                            0.0, 0.0, 0.0, 0.0),
                                                        color:
                                                        AppTheme.of(context)
                                                            .primary,
                                                        textStyle:
                                                        AppTheme.of(context)
                                                            .titleSmall
                                                            .override(
                                                          font:
                                                          GoogleFonts.inter(
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
                                                          elevation: 0.0,
                                                          borderRadius:
                                                          BorderRadius.circular(
                                                              AppTheme.of(
                                                                  context)
                                                                  .designToken
                                                                  .radius
                                                                  .lg),
                                                        ),
                                                      ),
                                                    ),
                                                  ].divide(const SizedBox(
                                                      height:
                                                      AppConstants.childSpacing)),
                                                ),
                                              ),
                                            ].divide(const SizedBox(
                                                height:
                                                    AppConstants.childSpacing)),
                                          ),
                                        ],
                                      ),
                                    ),
                                    wrapWithModel(
                                      model: _model.statsModel1,
                                      updateCallback: () => _provider.update(() {}),
                                      child: StatsWidget(
                                        iconBackgroundColor: const Color(0x4E2C4EB8),
                                        icon: Icon(
                                          Icons.work_outline,
                                          color: AppTheme.of(context).primary,
                                          size: 30.0,
                                        ),
                                        value: AppState().jobCache.jobs.length,
                                        title: 'Active Jobs',
                                        valueColor: AppTheme.of(context).primary,
                                      ),
                                    ),
                                  ),
                                  value: AppState().jobCache.jobs.length,
                                  title: 'Active Jobs',
                                  valueColor: AppTheme.of(context).primary,
                                ),
                              ),
                              wrapWithModel(
                                model: _model.statsModel2,
                                updateCallback: () => _provider.update(() {}),
                                child: StatsWidget(
                                  iconBackgroundColor:
                                      AppTheme.of(context).accent2,
                                  icon: Icon(
                                    Icons.forum_rounded,
                                    color: AppTheme.of(context).secondary,
                                    size: 30.0,
                                  ),
                                  value: functions.sumList(AppState()
                                      .jobCache
                                      .jobs
                                      .map((e) =>
                                          e.applications.firstOrNull?.count)
                                      .withoutNulls
                                      .toList()),
                                  title: 'Responses',
                                  valueColor: AppTheme.of(context).secondary,
                                ),
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'RECENT ACTIVITY',
                                    style: AppTheme.of(context)
                                        .headlineSmall
                                        .override(
                                          font: GoogleFonts.inter(
                                            fontWeight: FontWeight.w600,
                                            fontStyle: AppTheme.of(context)
                                                .headlineSmall
                                                .fontStyle,
                                          ),
                                        ),
                                  ),
                                  wrapWithModel(
                                    model: _model.textButtonModel,
                                    updateCallback: () =>
                                        _provider.update(() {}),
                                    child: TextButtonWidget(
                                      label: 'View All',
                                      color: AppTheme.of(context).primary,
                                      action: () async {
                                        context.pushNamed(
                                            CustomerAllJobsWidget.routeName);
                                      },
                                    ),
                                  ]
                                      .divide(const SizedBox(height: AppConstants.spacing))
                                      .addToEnd(const SizedBox(height: 100.0)),
                                ),
                              ),
                            ]
                                .divide(const SizedBox(
                                    height: AppConstants.spacing))
                                .addToEnd(const SizedBox(height: 100.0)),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Align(
                  alignment: const AlignmentDirectional(0.0, 1.0),
                  child: wrapWithModel(
                    model: _model.customerNavbarModel,
                    updateCallback: () => _provider.update(() {}),
                    child: const CustomerNavbarWidget(
                      selectedIndex: 0,
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
