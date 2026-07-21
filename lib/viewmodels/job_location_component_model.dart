import '/repositories/api_requests/api_calls.dart';
import '/repositories/backend.dart';
import '/models/structs/index.dart';
import '/core/theme/app_theme.dart';
import '/utils/util.dart';
import '/widgets/app_button.dart';
import 'dart:ui';
import '/widgets/components/job_location_component/job_location_component_widget.dart' show JobLocationComponentWidget;
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class JobLocationComponentModel
    extends AppModel<JobLocationComponentWidget> {
  ///  Local state fields for this component.

  LocationStruct? location;
  void updateLocationStruct(Function(LocationStruct) updateFn) {
    updateFn(location ??= LocationStruct());
  }

  bool loading = true;

  bool? showLocation;

  ///  State fields for stateful widgets in this component.

  // Stores action output result for [Backend Call - API (getJobLocation)] action in job_location_component widget.
  ApiCallResponse? queriedJobLocation;
  // State field(s) for Expandable widget.
  late ExpandableController expandableExpandableController;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    expandableExpandableController.dispose();
  }
}
