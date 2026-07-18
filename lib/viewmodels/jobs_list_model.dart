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
import '/widgets/components/jobs_list/jobs_list_widget.dart' show JobsListWidget;
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class JobsListModel extends AppModel<JobsListWidget> {
  ///  Local state fields for this component.

  bool showSearchList = false;

  ///  State fields for stateful widgets in this component.

  // Stores action output result for [Backend Call - API (get jobs list)] action in jobs_list widget.
  ApiCallResponse? browseJobsRes;
  // Stores action output result for [Backend Call - API (get jobs list)] action in jobs_list widget.
  ApiCallResponse? dashboardJobsRes;
  // State field(s) for search widget.
  FocusNode? searchFocusNode;
  TextEditingController? searchTextController;
  String? Function(BuildContext, String?)? searchTextControllerValidator;
  // Stores action output result for [Backend Call - API (get jobs list)] action in search widget.
  ApiCallResponse? searchJobApiRespone;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    searchFocusNode?.dispose();
    searchTextController?.dispose();
  }
}
