import '/auth/supabase_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/backend/schema/structs/index.dart';
import '/components/appbar_component/appbar_component_widget.dart';
import '/components/empty_list_component/empty_list_component_widget.dart';
import '/components/job_item/job_item_widget.dart';
import '/components/loading_component/loading_component_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'customer_all_jobs_widget.dart' show CustomerAllJobsWidget;
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class CustomerAllJobsModel extends FlutterFlowModel<CustomerAllJobsWidget> {
  ///  Local state fields for this page.

  bool loading = true;

  bool showSearchList = true;

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Backend Call - API (get jobs list)] action in customer_all_jobs widget.
  ApiCallResponse? viewAllJobsApi;
  // Model for appbar_component component.
  late AppbarComponentModel appbarComponentModel;
  // State field(s) for search widget.
  FocusNode? searchFocusNode;
  TextEditingController? searchTextController;
  String? Function(BuildContext, String?)? searchTextControllerValidator;
  // Stores action output result for [Backend Call - API (get jobs list)] action in search widget.
  ApiCallResponse? searchJobApiRespone;
  // Model for loading_component component.
  late LoadingComponentModel loadingComponentModel;

  @override
  void initState(BuildContext context) {
    appbarComponentModel = createModel(context, () => AppbarComponentModel());
    loadingComponentModel = createModel(context, () => LoadingComponentModel());
  }

  @override
  void dispose() {
    appbarComponentModel.dispose();
    searchFocusNode?.dispose();
    searchTextController?.dispose();

    loadingComponentModel.dispose();
  }
}
