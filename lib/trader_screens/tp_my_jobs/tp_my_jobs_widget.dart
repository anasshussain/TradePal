import 'package:skeletonizer/skeletonizer.dart';

import '../../widgets/page_header.dart';
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

  static ApiCallResponse? _cachedRequested;
  static ApiCallResponse? _cachedInProgress;
  static ApiCallResponse? _cachedCompleted;

  late Future<ApiCallResponse> _requestedJobsFuture;
  late Future<ApiCallResponse> _inProgressJobsFuture;
  late Future<ApiCallResponse> _completedJobsFuture;

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => TpMyJobsModel());

    _requestedJobsFuture = _fetchSubmittedJobs(Status.ACTIVE.name, (r) {
      _cachedRequested = r;
    });
    _inProgressJobsFuture = _fetchSubmittedJobs(Status.IN_PROGRESS.name, (r) {
      _cachedInProgress = r;
    });
    _completedJobsFuture = _fetchSubmittedJobs(Status.COMPLETED.name, (r) {
      _cachedCompleted = r;
    });

    _model.tabBarController = TabController(
      vsync: this,
      length: 3,
      initialIndex: 0,
    )..addListener(() => _provider.update(() {}));
    WidgetsBinding.instance
        .addPostFrameCallback((_) => _provider.update(() {}));
  }

  Future<ApiCallResponse> _fetchSubmittedJobs(
      String status,
      void Function(ApiCallResponse response) onLoaded,
      ) async {
    final response = await SupabaseTablesGroup.getSubmittedJobsListCall.call(
      userId: currentUserUid,
      status: status,
    );
    onLoaded(response);
    return response;
  }
  Future<void> _refreshRequested() async {
    final future = _fetchSubmittedJobs(Status.ACTIVE.name, (r) {
      _cachedRequested = r;
    });
    setState(() {
      _requestedJobsFuture = future;
    });
    await future;
  }

  Future<void> _refreshInProgress() async {
    final future = _fetchSubmittedJobs(Status.IN_PROGRESS.name, (r) {
      _cachedInProgress = r;
    });
    setState(() {
      _inProgressJobsFuture = future;
    });
    await future;
  }

  Future<void> _refreshCompleted() async {
    final future = _fetchSubmittedJobs(Status.COMPLETED.name, (r) {
      _cachedCompleted = r;
    });
    setState(() {
      _completedJobsFuture = future;
    });
    await future;
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
        // appBar: AppBar(
        //   backgroundColor: AppTheme.of(context).primaryBackground,
        //   automaticallyImplyLeading: false,
        //   title: wrapWithModel(
        //     model: _model.appbarComponentModel,
        //     updateCallback: () => _provider.update(() {}),
        //     child: AppbarComponentWidget(
        //       title: 'My jobs',
        //       showAction: false,
        //       action: () async {},
        //     ),
        //   ),
        //   actions: const [],
        //   centerTitle: true,
        //   elevation: 0.0,
        // ),
        body: SafeArea(
          top: true,
          child: Builder(
            builder: (context) {
              final activeIndex = _model.tabBarController!.index;
              final activeFuture = [
                _requestedJobsFuture,
                _inProgressJobsFuture,
                _completedJobsFuture,
              ][activeIndex];
              final activeCached = [
                _cachedRequested,
                _cachedInProgress,
                _cachedCompleted,
              ][activeIndex];

              return FutureBuilder<ApiCallResponse>(
                future: activeFuture,
                initialData: activeCached,
                builder: (context, activeSnapshot) {
                  final isPageLoading = activeCached == null &&
                      activeSnapshot.connectionState ==
                          ConnectionState.waiting;
                  return Skeletonizer(
                    enabled: isPageLoading,
                    child: _buildTabsStack(context),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildTabsStack(BuildContext context) {
    return Stack(
      children: [
        Align(
          alignment: const AlignmentDirectional(0.0, 0.0),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(
                  valueOrDefault<double>(
                    AppConstants.parentPagePadding,
                    0.0,
                  ),
                ),
                child: const PageHeaderWidget(
                  title: 'My Jobs',
                  subtitle: 'Track your requested, in-progress, and completed jobs all in one place.',
                ),
              ),
              Align(
                alignment: const Alignment(0.0, 0),
                child: TabBar(
                  isScrollable: true,
                  tabAlignment: TabAlignment.center,
                  labelColor: AppTheme.of(context).primary,
                  unselectedLabelColor:
                  AppTheme.of(context).secondaryText.withOpacity(0.5),
                  labelStyle: AppTheme.of(context).titleMedium.override(
                    font: GoogleFonts.manrope(
                      fontWeight: FontWeight.w700,
                      fontStyle:
                      AppTheme.of(context).titleMedium.fontStyle,
                    ),
                    fontSize: 16.0,
                    letterSpacing: 0.0,
                    fontWeight: FontWeight.w700,
                    fontStyle:
                    AppTheme.of(context).titleMedium.fontStyle,
                  ),
                  unselectedLabelStyle:
                  AppTheme.of(context).titleMedium.override(
                    font: GoogleFonts.manrope(
                      fontWeight: FontWeight.w500,
                      fontStyle: AppTheme.of(context)
                          .titleMedium
                          .fontStyle,
                    ),
                    fontSize: 16.0,
                    letterSpacing: 0.0,
                    fontWeight: FontWeight.w500,
                    fontStyle:
                    AppTheme.of(context).titleMedium.fontStyle,
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
                      child: RefreshIndicator(
                        color: AppTheme.of(context).primary,
                        onRefresh: _refreshRequested,
                        child: _buildJobsTab(
                          future: _requestedJobsFuture,
                          cached: _cachedRequested,
                          title: 'REQUESTED',
                          keyPrefix: 'Keyngq',
                        ),
                      ),
                    ),
                    // ------------------- IN-PROGRESS TAB -------------------
                    Padding(
                      padding: EdgeInsets.all(valueOrDefault<double>(
                        AppConstants.parentPagePadding,
                        0.0,
                      )),
                      child: RefreshIndicator(
                        color: AppTheme.of(context).primary,
                        onRefresh: _refreshInProgress,
                        child: _buildJobsTab(
                          future: _inProgressJobsFuture,
                          cached: _cachedInProgress,
                          title: 'IN PROGRESS',
                          keyPrefix: 'Keysee',
                        ),
                      ),
                    ),
                    // ------------------- COMPLETED TAB -------------------
                    Padding(
                      padding: EdgeInsets.all(valueOrDefault<double>(
                        AppConstants.parentPagePadding,
                        0.0,
                      )),
                      child: RefreshIndicator(
                        color: AppTheme.of(context).primary,
                        onRefresh: _refreshCompleted,
                        child: _buildJobsTab(
                          future: _completedJobsFuture,
                          cached: _cachedCompleted,
                          title: 'COMPLETED',
                          keyPrefix: 'Key707',
                        ),
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
    );
  }

  Widget _buildJobsTab({
    required Future<ApiCallResponse> future,
    required ApiCallResponse? cached,
    required String title,
    required String keyPrefix,
  }) {
    return FutureBuilder<ApiCallResponse>(
      future: future,
      initialData: cached,
      builder: (context, snapshot) {
        final hasAnyData = snapshot.hasData;
        final isFirstEverLoad = cached == null &&
            snapshot.connectionState == ConnectionState.waiting;
        if (isFirstEverLoad) {
          return Skeletonizer(
            enabled: true,
            child: _buildJobsSkeletonList(),
          );
        }
        if (!hasAnyData) {
          // Wrapped in a scrollable so RefreshIndicator can still be
          // pulled even when there's no list to show yet.
          return SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: EmptyListComponentWidget(
              icon: Icon(
                Icons.error_outline,
                color: AppTheme.of(context).tertiary,
                size: 40.0,
              ),
              title: title,
              description: 'Jobs load nahi ho sake, dobara try karein',
            ),
          );
        }

        final response = snapshot.data!;

        final jobs = (response.jsonBody
            .toList()
            .map<SubmittedJobsListStruct?>(
            SubmittedJobsListStruct.maybeFromMap)
            .toList() as Iterable<SubmittedJobsListStruct?>)
            .withoutNulls
            ?.sortedList(
          keyOf: (e) => e.jobs.createdAt,
          desc: true,
        )
            ?.toList() ??
            [];

        if (jobs.isEmpty) {
          // Wrapped in a scrollable so RefreshIndicator can still be
          // pulled even when the list is empty.
          return SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: EmptyListComponentWidget(
              icon: Icon(
                Icons.work_history_sharp,
                color: AppTheme.of(context).tertiary,
                size: 40.0,
              ),
              title: title,
              description: 'JOBS NOT FOUND',
            ),
          );
        }

        return ListView.separated(
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 100.0),
          primary: false,
          shrinkWrap: true,
          physics: const AlwaysScrollableScrollPhysics(),
          scrollDirection: Axis.vertical,
          itemCount: jobs.length,
          separatorBuilder: (_, __) =>
          const SizedBox(height: AppConstants.childPadding),
          itemBuilder: (context, index) {
            final item = jobs[index];
            return SubmittedJobListItemWidget(
              key: Key('${keyPrefix}_${index}_of_${jobs.length}'),
              jobData: item.jobs,
            );
          },
        );
      },
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
                children: [
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