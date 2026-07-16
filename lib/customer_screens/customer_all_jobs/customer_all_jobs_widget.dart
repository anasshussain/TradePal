import '/auth/supabase_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/backend/schema/structs/index.dart';
import '/components/appbar_component/appbar_component_widget.dart';
import '/components/empty_list_component/empty_list_component_widget.dart';
import '/components/job_item/job_item_widget.dart';
import '/components/loading_component/loading_component_widget.dart';
import '/theme/app_theme.dart';
import '/core/util.dart';
import '/widgets/app_button.dart';
import 'dart:ui';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'customer_all_jobs_model.dart';
export 'customer_all_jobs_model.dart';

class CustomerAllJobsWidget extends StatefulWidget {
  const CustomerAllJobsWidget({super.key});

  static String routeName = 'customer_all_jobs';
  static String routePath = '/customerAllJobs';

  @override
  State<CustomerAllJobsWidget> createState() => _CustomerAllJobsWidgetState();
}

class _CustomerAllJobsWidgetState extends State<CustomerAllJobsWidget> {
  late CustomerAllJobsModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => CustomerAllJobsModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      _model.loading = true;
      _model.showSearchList = false;
      safeSetState(() {});
      _model.viewAllJobsApi = await SupabaseTablesGroup.getJobsListCall.call(
        params: '&customer_id=eq.${currentUserUid}',
      );

      if ((_model.viewAllJobsApi?.succeeded ?? true)) {
        AppState().jobCache = JobCacheStruct(
          jobs: ((_model.viewAllJobsApi?.jsonBody ?? '')
                  .toList()
                  .map<JobsListItemStruct?>(JobsListItemStruct.maybeFromMap)
                  .toList() as Iterable<JobsListItemStruct?>)
              .withoutNulls,
          lastCursor: ((_model.viewAllJobsApi?.jsonBody ?? '')
                  .toList()
                  .map<JobsListItemStruct?>(JobsListItemStruct.maybeFromMap)
                  .toList() as Iterable<JobsListItemStruct?>)
              .withoutNulls
              ?.firstOrNull
              ?.createdAt,
          firstCursor: ((_model.viewAllJobsApi?.jsonBody ?? '')
                  .toList()
                  .map<JobsListItemStruct?>(JobsListItemStruct.maybeFromMap)
                  .toList() as Iterable<JobsListItemStruct?>)
              .withoutNulls
              ?.lastOrNull
              ?.createdAt,
          hasMore: true,
        );
        safeSetState(() {});
      }
      _model.loading = false;
      safeSetState(() {});
    });

    _model.searchTextController ??= TextEditingController();
    _model.searchFocusNode ??= FocusNode();

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
              title: 'All Jobs',
              showAction: false,
              action: () async {
                context.safePop();
              },
            ),
          ),
          actions: [],
          centerTitle: false,
        ),
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
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Container(
                          width: 200.0,
                          child: TextFormField(
                            controller: _model.searchTextController,
                            focusNode: _model.searchFocusNode,
                            onChanged: (_) => EasyDebounce.debounce(
                              '_model.searchTextController',
                              Duration(milliseconds: 300),
                              () async {
                                _model.searchJobApiRespone =
                                    await SupabaseTablesGroup.getJobsListCall
                                        .call(
                                  params:
                                      '${'&customer_id=eq.${currentUserUid}&'}&or=(title.ilike.*${_model.searchTextController.text}*,category.ilike.*${_model.searchTextController.text}*)',
                                );

                                if ((_model.searchJobApiRespone?.succeeded ??
                                    true)) {
                                  if (_model.searchTextController.text !=
                                          null &&
                                      _model.searchTextController.text != '') {
                                    _model.showSearchList = true;
                                    safeSetState(() {});
                                  } else {
                                    _model.showSearchList = false;
                                    safeSetState(() {});
                                  }
                                }

                                safeSetState(() {});
                              },
                            ),
                            autofocus: false,
                            enabled: true,
                            obscureText: false,
                            decoration: InputDecoration(
                              isDense: false,
                              labelStyle: AppTheme.of(context)
                                  .labelMedium
                                  .override(
                                    font: GoogleFonts.inter(
                                      fontWeight: AppTheme.of(context)
                                          .labelMedium
                                          .fontWeight,
                                      fontStyle: AppTheme.of(context)
                                          .labelMedium
                                          .fontStyle,
                                    ),
                                    color: AppTheme.of(context)
                                        .secondaryText,
                                    fontSize: 12.0,
                                    letterSpacing: 0.0,
                                    fontWeight: AppTheme.of(context)
                                        .labelMedium
                                        .fontWeight,
                                    fontStyle: AppTheme.of(context)
                                        .labelMedium
                                        .fontStyle,
                                  ),
                              hintText: 'Search jobs',
                              hintStyle: AppTheme.of(context)
                                  .labelMedium
                                  .override(
                                    font: GoogleFonts.inter(
                                      fontWeight: FontWeight.normal,
                                      fontStyle: AppTheme.of(context)
                                          .labelMedium
                                          .fontStyle,
                                    ),
                                    color: AppTheme.of(context).hint,
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.normal,
                                    fontStyle: AppTheme.of(context)
                                        .labelMedium
                                        .fontStyle,
                                  ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0x00000000),
                                  width: 1.0,
                                ),
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: AppTheme.of(context).primary,
                                  width: 1.0,
                                ),
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: AppTheme.of(context).error,
                                  width: 1.0,
                                ),
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: AppTheme.of(context).error,
                                  width: 1.0,
                                ),
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              filled: true,
                              fillColor: AppTheme.of(context).alternate,
                              suffixIcon: _model
                                      .searchTextController!.text.isNotEmpty
                                  ? InkWell(
                                      onTap: () async {
                                        _model.searchTextController?.clear();
                                        _model.searchJobApiRespone =
                                            await SupabaseTablesGroup
                                                .getJobsListCall
                                                .call(
                                          params:
                                              '${'&customer_id=eq.${currentUserUid}&'}&or=(title.ilike.*${_model.searchTextController.text}*,category.ilike.*${_model.searchTextController.text}*)',
                                        );

                                        if ((_model.searchJobApiRespone
                                                ?.succeeded ??
                                            true)) {
                                          if (_model.searchTextController
                                                      .text !=
                                                  null &&
                                              _model.searchTextController
                                                      .text !=
                                                  '') {
                                            _model.showSearchList = true;
                                            safeSetState(() {});
                                          } else {
                                            _model.showSearchList = false;
                                            safeSetState(() {});
                                          }
                                        }

                                        safeSetState(() {});
                                        safeSetState(() {});
                                      },
                                      child: Icon(
                                        Icons.clear,
                                        color: AppTheme.of(context)
                                            .tertiary,
                                        size: 26.0,
                                      ),
                                    )
                                  : null,
                            ),
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
                            cursorColor:
                                AppTheme.of(context).primaryText,
                            enableInteractiveSelection: true,
                            validator: _model.searchTextControllerValidator
                                .asValidator(context),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Builder(
                    builder: (context) {
                      if (!_model.loading) {
                        return Padding(
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
                              final jobList = (_model.showSearchList
                                          ? ((_model.searchJobApiRespone
                                                              ?.jsonBody ??
                                                          '')
                                                      .toList()
                                                      .map<JobsListItemStruct?>(
                                                          JobsListItemStruct
                                                              .maybeFromMap)
                                                      .toList()
                                                  as Iterable<
                                                      JobsListItemStruct?>)
                                              .withoutNulls
                                              ?.sortedList(
                                                  keyOf: (e) => e.createdAt,
                                                  desc: true)
                                          : AppState()
                                              .jobCache
                                              .jobs
                                              .sortedList(
                                                  keyOf: (e) => e.createdAt,
                                                  desc: true))
                                      ?.toList() ??
                                  [];
                              if (jobList.isEmpty) {
                                return Center(
                                  child: Container(
                                    width: double.infinity,
                                    height: 200.0,
                                    child: EmptyListComponentWidget(
                                      icon: Icon(
                                        Icons.work_history_sharp,
                                        color: AppTheme.of(context)
                                            .tertiary,
                                        size: 40.0,
                                      ),
                                      title: 'No jobs yet',
                                      description:
                                          'You havent posted a job yet',
                                    ),
                                  ),
                                );
                              }

                              return ListView.separated(
                                padding: EdgeInsets.zero,
                                primary: false,
                                shrinkWrap: true,
                                scrollDirection: Axis.vertical,
                                itemCount: jobList.length,
                                separatorBuilder: (_, __) => SizedBox(
                                    height: AppConstants.childPadding),
                                itemBuilder: (context, jobListIndex) {
                                  final jobListItem = jobList[jobListIndex];
                                  return JobItemWidget(
                                    key: Key(
                                        'Keyem9_${jobListIndex}_of_${jobList.length}'),
                                    jobData: jobListItem,
                                  );
                                },
                              );
                            },
                          ),
                        );
                      } else {
                        return Align(
                          alignment: AlignmentDirectional(0.0, 0.0),
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 200.0, 0.0, 0.0),
                            child: wrapWithModel(
                              model: _model.loadingComponentModel,
                              updateCallback: () => safeSetState(() {}),
                              child: LoadingComponentWidget(),
                            ),
                          ),
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
