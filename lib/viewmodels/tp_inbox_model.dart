import '/repositories/api_requests/api_calls.dart';
import '/widgets/components/tp_navbar/tp_navbar_widget.dart';
import '/utils/util.dart';
import 'dart:async';
import '/trader_screens/tp_inbox/tp_inbox_widget.dart' show TpInboxWidget;
import 'package:flutter/material.dart';

class TpInboxModel extends AppModel<TpInboxWidget> {
  ///  State fields for stateful widgets in this page.

  Completer<ApiCallResponse>? apiRequestCompleter;
  // State field(s) for search widget.
  FocusNode? searchFocusNode;
  TextEditingController? searchTextController;
  String? Function(BuildContext, String?)? searchTextControllerValidator;
  // Stores action output result for [Backend Call - API (search conversations)] action in search widget.
  ApiCallResponse? searchJobApiRespone;
  // Model for tp_navbar component.
  late TpNavbarModel tpNavbarModel;

  @override
  void initState(BuildContext context) {
    tpNavbarModel = createModel(context, () => TpNavbarModel());
  }

  @override
  void dispose() {
    searchFocusNode?.dispose();
    searchTextController?.dispose();

    tpNavbarModel.dispose();
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
