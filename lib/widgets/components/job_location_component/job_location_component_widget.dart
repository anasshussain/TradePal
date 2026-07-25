import '/repositories/api_requests/api_calls.dart';
import '/repositories/backend.dart';
import '/models/structs/index.dart';
import '/core/theme/app_theme.dart';
import '/utils/util.dart';
import '/widgets/app_button.dart';
import 'dart:ui';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '/viewmodels/job_location_component_model.dart';
export '/viewmodels/job_location_component_model.dart';

class JobLocationComponentWidget extends StatefulWidget {
  const JobLocationComponentWidget({
    super.key,
    required this.locatioId,
  });

  final String? locatioId;

  @override
  State<JobLocationComponentWidget> createState() =>
      _JobLocationComponentWidgetState();
}

class _JobLocationComponentWidgetState
    extends State<JobLocationComponentWidget> {
  late JobLocationComponentModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => JobLocationComponentModel());

    // On component load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      _model.loading = true;
      safeSetState(() {});
      _model.queriedJobLocation =
          await SupabaseTablesGroup.getJobLocationCall.call(
        locationId: widget!.locatioId,
      );

      if ((_model.queriedJobLocation?.succeeded ?? true)) {
        _model.location = ((_model.queriedJobLocation?.jsonBody ?? '')
                .toList()
                .map<LocationStruct?>(LocationStruct.maybeFromMap)
                .toList() as Iterable<LocationStruct?>)
            .withoutNulls
            ?.firstOrNull;
        _model.loading = false;
        safeSetState(() {});
      } else {
        _model.loading = false;
        safeSetState(() {});
      }
    });

    _model.expandableExpandableController =
        ExpandableController(initialExpanded: false)
          ..addListener(() => safeSetState(() {}));
    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      elevation: 0.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
            AppTheme.of(context).designToken.radius.lg),
      ),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppTheme.of(context).secondaryBackground,
          borderRadius: BorderRadius.circular(
              AppTheme.of(context).designToken.radius.lg),
          border: Border.all(
            color: AppTheme.of(context).alternate,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(valueOrDefault<double>(
            AppConstants.childPadding,
            0.0,
          )),
          child: Container(
            width: double.infinity,
            color: const Color(0x00000000),
            child: ExpandableNotifier(
              controller: _model.expandableExpandableController,
              child: ExpandablePanel(
                header: Text(
                  'ADDRESS',
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
                collapsed: Container(),
                expanded: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Builder(
                      builder: (context) {
                        if (!_model.loading) {
                          return Text(
                            valueOrDefault<String>(
                              '${_model.location?.street}, ${_model.location?.name},${_model.location?.address}',
                              'Unregistered location',
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
                          );
                        } else {
                          return Container(
                            width: double.infinity,
                            height: 30.0,
                            decoration: BoxDecoration(
                              color: AppTheme.of(context).alternate,
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          );
                        }
                      },
                    ),
                  ],
                ),
                theme: const ExpandableThemeData(
                  tapHeaderToExpand: true,
                  tapBodyToExpand: false,
                  tapBodyToCollapse: false,
                  headerAlignment: ExpandablePanelHeaderAlignment.center,
                  hasIcon: true,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
