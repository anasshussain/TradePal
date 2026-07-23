import 'package:skeletonizer/skeletonizer.dart';

import '/auth/supabase_auth/auth_util.dart';
import '/repositories/api_requests/api_calls.dart';
import '/utils/enums/enums.dart';
import '/models/structs/index.dart';
import '/widgets/components/appbar_component/appbar_component_widget.dart';
import '/widgets/components/empty_list_component/empty_list_component_widget.dart';
import '/widgets/components/submitted_job_list_item/submitted_job_list_item_widget.dart';
import '/widgets/components/tp_navbar/tp_navbar_widget.dart';
import '/core/theme/app_theme.dart';
import '/utils/util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '/providers/tp_my_jobs_provider.dart';
import '/viewmodels/tp_my_jobs_model.dart';
export '/viewmodels/tp_my_jobs_model.dart';

class TpMyJobsWidget extends StatefulWidget {
  const TpMyJobsWidget({super.key});

  static String routeName = 'tp_my_jobs';
  static String routePath = '/tpMyJobs';

  @override
  State<TpMyJobsWidget> createState() => _TpMyJobsWidgetState();
}

class _TpMyJobsWidgetState extends State<TpMyJobsWidget>
    with TickerProviderStateMixin {
  late TpMyJobsModel _model;
  final TpMyJobsProvider _provider = TpMyJobsProvider();

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => TpMyJobsModel());

    _model.tabBarController = TabController(
      vsync: this,
      length: 3,
      initialIndex: 0,
    )..addListener(() => _provider.update(() {}));
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
    return ChangeNotifierProvider<TpMyJobsProvider>.value(
      value: _provider,
      child: Consumer<TpMyJobsProvider>(
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
        appBar: AppBar(
          backgroundColor: AppTheme.of(context).primaryBackground,
          automaticallyImplyLeading: false,
          title: wrapWithModel(
            model: _model.appbarComponentModel,
            updateCallback: () => _provider.update(() {}),
            child: AppbarComponentWidget(
              title: 'My jobs',
              showAction: false,
              action: () async {},
            ),
          ),
          actions: const [],
          centerTitle: true,
          elevation: 0.0,
        ),
        body: SafeArea(
          top: true,
          child: Stack(
            children: [
              Align(
                alignment: const AlignmentDirectional(0.0, 0.0),
                child: Column(
                  children: [
                    Align(
                      alignment: const Alignment(0.0, 0),
                      child: TabBar(
                        isScrollable: true,
                        tabAlignment: TabAlignment.center,
                        labelColor: AppTheme.of(context).primary,
                        unselectedLabelColor: AppTheme.of(context)
                            .secondaryText
                            .withOpacity(0.5),
                        labelStyle: AppTheme.of(context).titleMedium.override(
                          font: GoogleFonts.manrope(
                            fontWeight: FontWeight.w700,
                            fontStyle: AppTheme.of(context).titleMedium.fontStyle,
                          ),
                          fontSize: 16.0,
                          letterSpacing: 0.0,
                          fontWeight: FontWeight.w700,
                          fontStyle: AppTheme.of(context).titleMedium.fontStyle,
                        ),
                        unselectedLabelStyle: AppTheme.of(context).titleMedium.override(
                          font: GoogleFonts.manrope(
                            fontWeight: FontWeight.w500,
                            fontStyle: AppTheme.of(context).titleMedium.fontStyle,
                          ),
                          fontSize: 16.0,
                          letterSpacing: 0.0,
                          fontWeight: FontWeight.w500,
                          fontStyle: AppTheme.of(context).titleMedium.fontStyle,
                        ),
                        indicatorColor: AppTheme.of(context).primary,
                        indicatorWeight: 3.0,
                        padding: const EdgeInsets.all(6.0),
                        tabs: const [
                          Tab(text: 'Requested'),
                          Tab(text: 'in-Progress'),
                          Tab(text: 'Completed'),
                        ],
                        controller: _model.tabBarController,
                        onTap: (i) async {
                          [() async {}, () async {}, () async {}][i]();
                        },
                      ),
                    ),
                    Expanded(
                      child: TabBarView(
                        controller: _model.tabBarController,
                        children: [
                          Padding(
                            padding: EdgeInsets.all(valueOrDefault<double>(
                              AppConstants.parentPagePadding,
                              0.0,
                            )),
                            child: FutureBuilder<ApiCallResponse>(
                              future: SupabaseTablesGroup
                                  .getSubmittedJobsListCall
                                  .call(
                                userId: currentUserUid,
                                status: Status.ACTIVE.name,
                              ),
                              builder: (context, snapshot) {
                                if (!snapshot.hasData) {
                                  if (!TpMyJobsProvider.isLoadingRequested) {
                                    return const SizedBox.shrink();
                                  }
                                  return Skeletonizer(
                                    enabled: true,
                                    child: _buildJobsSkeletonList(),
                                  );
                                }
                                if (TpMyJobsProvider.isLoadingRequested) {
                                  TpMyJobsProvider.isLoadingRequested = false;
                                }
                                final listViewGetSubmittedJobsListResponse =
                                    snapshot.data!;

                                return Builder(
                                  builder: (context) {
                                    final activeJobs =
                                        (listViewGetSubmittedJobsListResponse
                                                        .jsonBody
                                                        .toList()
                                                        .map<SubmittedJobsListStruct?>(
                                                            SubmittedJobsListStruct
                                                                .maybeFromMap)
                                                        .toList()
                                                    as Iterable<
                                                        SubmittedJobsListStruct?>)
                                                .withoutNulls
                                                ?.sortedList(
                                                    keyOf: (e) =>
                                                        e.jobs.createdAt,
                                                    desc: true)
                                                ?.toList() ??
                                            [];
                                    if (activeJobs.isEmpty) {
                                      return EmptyListComponentWidget(
                                        icon: Icon(
                                          Icons.work_history_sharp,
                                          color: AppTheme.of(context)
                                              .tertiary,
                                          size: 40.0,
                                        ),
                                        title: 'REQUESTED',
                                        description: 'JOBS NOT FOUND',
                                      );
                                    }

                                    return ListView.separated(
                                      padding: const EdgeInsets.fromLTRB(
                                        0,
                                        0,
                                        0,
                                        100.0,
                                      ),
                                      primary: false,
                                      shrinkWrap: true,
                                      scrollDirection: Axis.vertical,
                                      itemCount: activeJobs.length,
                                      separatorBuilder: (_, __) => const SizedBox(
                                          height: AppConstants.childPadding),
                                      itemBuilder: (context, activeJobsIndex) {
                                        final activeJobsItem =
                                            activeJobs[activeJobsIndex];
                                        return SubmittedJobListItemWidget(
                                          key: Key(
                                              'Keyngq_${activeJobsIndex}_of_${activeJobs.length}'),
                                          jobData: activeJobsItem.jobs,
                                        );
                                      },
                                    );
                                  },
                                );
                              },
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(valueOrDefault<double>(
                              AppConstants.parentPagePadding,
                              0.0,
                            )),
                            child: FutureBuilder<ApiCallResponse>(
                              future: SupabaseTablesGroup
                                  .getSubmittedJobsListCall
                                  .call(
                                userId: currentUserUid,
                                status: Status.IN_PROGRESS.name,
                              ),
                              builder: (context, snapshot) {
                                // Customize what your widget looks like when it's loading.
                                if (!snapshot.hasData) {
                                  return Center(
                                    child: SizedBox(
                                      width: 50.0,
                                      height: 50.0,
                                      child: SpinKitFadingCube(
                                        color: AppTheme.of(context)
                                            .primary,
                                        size: 50.0,
                                      ),
                                    ),
                                  );
                                }
                                final listViewGetSubmittedJobsListResponse =
                                    snapshot.data!;

                                return Builder(
                                  builder: (context) {
                                    final inprogressJobs =
                                        (listViewGetSubmittedJobsListResponse
                                                        .jsonBody
                                                        .toList()
                                                        .map<SubmittedJobsListStruct?>(
                                                            SubmittedJobsListStruct
                                                                .maybeFromMap)
                                                        .toList()
                                                    as Iterable<
                                                        SubmittedJobsListStruct?>)
                                                .withoutNulls
                                                ?.sortedList(
                                                    keyOf: (e) =>
                                                        e.jobs.createdAt,
                                                    desc: true)
                                                ?.toList() ??
                                            [];
                                    if (inprogressJobs.isEmpty) {
                                      return EmptyListComponentWidget(
                                        icon: Icon(
                                          Icons.work_history_sharp,
                                          color: AppTheme.of(context)
                                              .tertiary,
                                          size: 40.0,
                                        ),
                                        title: 'IN PROGRESS',
                                        description: 'JOBS NOT FOUND',
                                      );
                                    }

                                    return ListView.separated(
                                      padding: const EdgeInsets.fromLTRB(
                                        0,
                                        0,
                                        0,
                                        100.0,
                                      ),
                                      primary: false,
                                      shrinkWrap: true,
                                      scrollDirection: Axis.vertical,
                                      itemCount: inprogressJobs.length,
                                      separatorBuilder: (_, __) => const SizedBox(
                                          height: AppConstants.childPadding),
                                      itemBuilder:
                                          (context, inprogressJobsIndex) {
                                        final inprogressJobsItem =
                                            inprogressJobs[inprogressJobsIndex];
                                        return SubmittedJobListItemWidget(
                                          key: Key(
                                              'Keysee_${inprogressJobsIndex}_of_${inprogressJobs.length}'),
                                          jobData: inprogressJobsItem.jobs,
                                        );
                                      },
                                    );
                                  },
                                );
                              },
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(valueOrDefault<double>(
                              AppConstants.parentPagePadding,
                              0.0,
                            )),
                            child: FutureBuilder<ApiCallResponse>(
                              future: SupabaseTablesGroup
                                  .getSubmittedJobsListCall
                                  .call(
                                userId: currentUserUid,
                                status: Status.COMPLETED.name,
                              ),
                              builder: (context, snapshot) {
                                // Customize what your widget looks like when it's loading.
                                if (!snapshot.hasData) {
                                  return Center(
                                    child: SizedBox(
                                      width: 50.0,
                                      height: 50.0,
                                      child: SpinKitFadingCube(
                                        color: AppTheme.of(context)
                                            .primary,
                                        size: 50.0,
                                      ),
                                    ),
                                  );
                                }
                                final listViewGetSubmittedJobsListResponse =
                                    snapshot.data!;

                                return Builder(
                                  builder: (context) {
                                    final completedJobs =
                                        (listViewGetSubmittedJobsListResponse
                                                        .jsonBody
                                                        .toList()
                                                        .map<SubmittedJobsListStruct?>(
                                                            SubmittedJobsListStruct
                                                                .maybeFromMap)
                                                        .toList()
                                                    as Iterable<
                                                        SubmittedJobsListStruct?>)
                                                .withoutNulls
                                                ?.sortedList(
                                                    keyOf: (e) =>
                                                        e.jobs.createdAt,
                                                    desc: true)
                                                ?.toList() ??
                                            [];
                                    if (completedJobs.isEmpty) {
                                      return EmptyListComponentWidget(
                                        icon: Icon(
                                          Icons.work_history_sharp,
                                          color: AppTheme.of(context)
                                              .tertiary,
                                          size: 40.0,
                                        ),
                                        title: 'COMPLETED',
                                        description: 'JOBS NOT FOUND',
                                      );
                                    }

                                    return ListView.separated(
                                      padding: const EdgeInsets.fromLTRB(
                                        0,
                                        0,
                                        0,
                                        100.0,
                                      ),
                                      primary: false,
                                      shrinkWrap: true,
                                      scrollDirection: Axis.vertical,
                                      itemCount: completedJobs.length,
                                      separatorBuilder: (_, __) => const SizedBox(
                                          height: AppConstants.childPadding),
                                      itemBuilder:
                                          (context, completedJobsIndex) {
                                        final completedJobsItem =
                                            completedJobs[completedJobsIndex];
                                        return SubmittedJobListItemWidget(
                                          key: Key(
                                              'Key707_${completedJobsIndex}_of_${completedJobs.length}'),
                                          jobData: completedJobsItem.jobs,
                                        );
                                      },
                                    );
                                  },
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Align(
                alignment: const AlignmentDirectional(0.0, 1.0),
                child: wrapWithModel(
                  model: _model.tpNavbarModel,
                  updateCallback: () => _provider.update(() {}),
                  child: const Hero(
                    tag: 'traderNavbar',
                    transitionOnUserGestures: true,
                    child: Material(
                      color: Colors.transparent,
                      child: TpNavbarWidget(
                        selectedIndex: 1,
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
  Widget _buildJobsSkeletonList() {
    return ListView.separated(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 100.0),
      primary: false,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 5,
      separatorBuilder: (_, __) =>
      const SizedBox(height: AppConstants.childPadding),
      itemBuilder: (context, index) => Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppTheme.of(context).secondaryBackground,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: AppTheme.of(context).alternate,
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
            const SizedBox(width: 12),
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text('Placeholder job title'),
                  SizedBox(height: 6),
                  Text('Placeholder job subtitle line'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
