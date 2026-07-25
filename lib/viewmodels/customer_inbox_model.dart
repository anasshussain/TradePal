import '/repositories/api_requests/api_calls.dart';
import '/widgets/components/appbar_component/appbar_component_widget.dart';
import '/widgets/components/customer_navbar/customer_navbar_widget.dart';
import '/widgets/components/page_header_sectiom/page_header_sectiom_widget.dart';
import '/utils/util.dart';
import '/customer_screens/customer_inbox/customer_inbox_widget.dart' show CustomerInboxWidget;
import 'dart:async';
import 'package:flutter/material.dart';

class CustomerInboxModel extends AppModel<CustomerInboxWidget> {
  ///  State fields for stateful widgets in this page.

  Completer<ApiCallResponse>? apiRequestCompleter;
  // Model for appbar_component component.
  late AppbarComponentModel appbarComponentModel;
  // Model for page_header_sectiom component.
  late PageHeaderSectiomModel pageHeaderSectiomModel;
  // State field(s) for search widget.
  FocusNode? searchFocusNode;
  TextEditingController? searchTextController;
  String? Function(BuildContext, String?)? searchTextControllerValidator;
  // Stores action output result for [Backend Call - API (search conversations)] action in search widget.
  ApiCallResponse? searchJobApiRespone;
  // Model for customer_navbar component.
  late CustomerNavbarModel customerNavbarModel;

  @override
  void initState(BuildContext context) {
    appbarComponentModel = createModel(context, () => AppbarComponentModel());
    pageHeaderSectiomModel =
        createModel(context, () => PageHeaderSectiomModel());
    customerNavbarModel = createModel(context, () => CustomerNavbarModel());
  }

  @override
  void dispose() {
    appbarComponentModel.dispose();
    pageHeaderSectiomModel.dispose();
    searchFocusNode?.dispose();
    searchTextController?.dispose();

    customerNavbarModel.dispose();
  }

  /// Additional helper methods.
  Future waitForApiRequestCompleted({
    double minWait = 0,
    double maxWait = double.infinity,
  }) async {
    final stopwatch = Stopwatch()..start();
    while (true) {
      await Future.delayed(const Duration(milliseconds: 50));
      final timeElapsed = stopwatch.elapsedMilliseconds;
      final requestComplete = apiRequestCompleter?.isCompleted ?? false;
      if (timeElapsed > maxWait || (requestComplete && timeElapsed > minWait)) {
        break;
      }
    }
  }
}
