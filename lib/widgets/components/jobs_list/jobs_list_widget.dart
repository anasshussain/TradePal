import '/auth/supabase_auth/auth_util.dart';
import '/repositories/api_requests/api_calls.dart';
import '/utils/enums/enums.dart';
import '/models/structs/index.dart';
import '/widgets/components/empty_list_component/empty_list_component_widget.dart';
import '/widgets/components/job_item/job_item_widget.dart';
import '/core/theme/app_theme.dart';
import '/utils/util.dart';
import '/widgets/app_button.dart';
import 'dart:ui';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '/viewmodels/jobs_list_model.dart';
export '/viewmodels/jobs_list_model.dart';

class JobsListWidget extends StatefulWidget {
  const JobsListWidget({
    super.key,
    required this.jobViewType,
  });

  final JobsViewType? jobViewType;

  @override
  State<JobsListWidget> createState() => _JobsListWidgetState();
}

class _JobsListWidgetState extends State<JobsListWidget> {
  late JobsListModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => JobsListModel());

    // On component load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      if (widget!.jobViewType == JobsViewType.BROWSE) {
        _model.browseJobsRes = await SupabaseTablesGroup.getJobsListCall.call();

        if ((_model.browseJobsRes?.succeeded ?? true)) {
          AppState().jobCache = JobCacheStruct(
            jobs: ((_model.browseJobsRes?.jsonBody ?? '')
                    .toList()
                    .map<JobsListItemStruct?>(JobsListItemStruct.maybeFromMap)
                    .toList() as Iterable<JobsListItemStruct?>)
                .withoutNulls,
            lastCursor: ((_model.browseJobsRes?.jsonBody ?? '')
                    .toList()
                    .map<JobsListItemStruct?>(JobsListItemStruct.maybeFromMap)
                    .toList() as Iterable<JobsListItemStruct?>)
                .withoutNulls
                ?.lastOrNull
                ?.createdAt,
            firstCursor: ((_model.browseJobsRes?.jsonBody ?? '')
                    .toList()
                    .map<JobsListItemStruct?>(JobsListItemStruct.maybeFromMap)
                    .toList() as Iterable<JobsListItemStruct?>)
                .withoutNulls
                ?.firstOrNull
                ?.createdAt,
            hasMore: true,
          );
          _model.updatePage(() {});
        }
      } else {
        _model.dashboardJobsRes =
            await SupabaseTablesGroup.getJobsListCall.call(
          params: '&customer_id=eq.${currentUserUid}',
        );

        if ((_model.dashboardJobsRes?.succeeded ?? true)) {
          AppState().jobCache = JobCacheStruct(
            jobs: ((_model.dashboardJobsRes?.jsonBody ?? '')
                    .toList()
                    .map<JobsListItemStruct?>(JobsListItemStruct.maybeFromMap)
                    .toList() as Iterable<JobsListItemStruct?>)
                .withoutNulls,
            lastCursor: '',
            firstCursor: '',
            hasMore: true,
          );
          _model.updatePage(() {});
        }
      }
    });

    _model.searchTextController ??= TextEditingController();
    _model.searchFocusNode ??= FocusNode();

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<AppState>();

    return Column(
      mainAxisSize: MainAxisSize.max,
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
                          await SupabaseTablesGroup.getJobsListCall.call(
                        params:
                            '${widget!.jobViewType != JobsViewType.BROWSE ? '&customer_id=eq.${currentUserUid}&' : ''}&or=(title.ilike.*${_model.searchTextController.text}*,category.ilike.*${_model.searchTextController.text}*)',
                      );

                      if ((_model.searchJobApiRespone?.succeeded ?? true)) {
                        if (_model.searchTextController.text != null &&
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
                    labelStyle:
                        AppTheme.of(context).labelMedium.override(
                              font: GoogleFonts.inter(
                                fontWeight: AppTheme.of(context)
                                    .labelMedium
                                    .fontWeight,
                                fontStyle: AppTheme.of(context)
                                    .labelMedium
                                    .fontStyle,
                              ),
                              color: AppTheme.of(context).secondaryText,
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
                    hintStyle:
                        AppTheme.of(context).labelMedium.override(
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
                    suffixIcon: _model.searchTextController!.text.isNotEmpty
                        ? InkWell(
                            onTap: () async {
                              _model.searchTextController?.clear();
                              _model.searchJobApiRespone =
                                  await SupabaseTablesGroup.getJobsListCall
                                      .call(
                                params:
                                    '${widget!.jobViewType != JobsViewType.BROWSE ? '&customer_id=eq.${currentUserUid}&' : ''}&or=(title.ilike.*${_model.searchTextController.text}*,category.ilike.*${_model.searchTextController.text}*)',
                              );

                              if ((_model.searchJobApiRespone?.succeeded ??
                                  true)) {
                                if (_model.searchTextController.text != null &&
                                    _model.searchTextController.text != '') {
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
                              color: AppTheme.of(context).tertiary,
                              size: 26.0,
                            ),
                          )
                        : null,
                  ),
                  style: AppTheme.of(context).bodyMedium.override(
                        font: GoogleFonts.manrope(
                          fontWeight: AppTheme.of(context)
                              .bodyMedium
                              .fontWeight,
                          fontStyle:
                              AppTheme.of(context).bodyMedium.fontStyle,
                        ),
                        letterSpacing: 0.0,
                        fontWeight:
                            AppTheme.of(context).bodyMedium.fontWeight,
                        fontStyle:
                            AppTheme.of(context).bodyMedium.fontStyle,
                      ),
                  cursorColor: AppTheme.of(context).primaryText,
                  enableInteractiveSelection: true,
                  validator:
                      _model.searchTextControllerValidator.asValidator(context),
                ),
              ),
            ),
          ],
        ),
        Padding(
          padding: EdgeInsetsDirectional.fromSTEB(0.0,
              AppTheme.of(context).designToken.spacing.lg, 0.0, 0.0),
          child: Builder(
            builder: (context) {
              final jobList = () {
                    if (_model.showSearchList) {
                      return ((_model.searchJobApiRespone?.jsonBody ?? '')
                              .toList()
                              .map<JobsListItemStruct?>(
                                  JobsListItemStruct.maybeFromMap)
                              .toList() as Iterable<JobsListItemStruct?>)
                          .withoutNulls
                          ?.sortedList(keyOf: (e) => e.createdAt, desc: true);
                    } else if ((widget!.jobViewType ==
                            JobsViewType.DASHBOARD) &&
                        !_model.showSearchList) {
                      return AppState()
                          .jobCache
                          .jobs
                          .sortedList(keyOf: (e) => e.createdAt, desc: true)
                          .take(5)
                          .toList();
                    } else {
                      return AppState()
                          .jobCache
                          .jobs
                          .sortedList(keyOf: (e) => e.createdAt, desc: true);
                    }
                  }()
                      ?.toList() ??
                  [];
              if (jobList.isEmpty) {
                return Center(
                  child: EmptyListComponentWidget(
                    icon: Icon(
                      Icons.work_history_sharp,
                      color: AppTheme.of(context).tertiary,
                      size: 40.0,
                    ),
                    title: valueOrDefault<String>(
                      _model.showSearchList ? 'No jobs found' : 'No jobs yet',
                      'No jobs yet',
                    ),
                    description: valueOrDefault<String>(
                      _model.showSearchList
                          ? 'Try different keywords'
                          : 'You havent posted a job yet',
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
                separatorBuilder: (_, __) =>
                    SizedBox(height: AppConstants.childPadding),
                itemBuilder: (context, jobListIndex) {
                  final jobListItem = jobList[jobListIndex];
                  return JobItemWidget(
                    key: Key('Keygq7_${jobListIndex}_of_${jobList.length}'),
                    jobData: jobListItem,
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
