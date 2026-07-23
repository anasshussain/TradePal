import '/repositories/api_requests/api_calls.dart';
import '/widgets/components/appbar_component/appbar_component_widget.dart';
import '/widgets/components/loading_component/loading_component_widget.dart';
import '/utils/util.dart';
import '/customer_screens/customer_all_jobs/customer_all_jobs_widget.dart' show CustomerAllJobsWidget;
import 'package:flutter/material.dart';

class CustomerAllJobsModel extends AppModel<CustomerAllJobsWidget> {
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
