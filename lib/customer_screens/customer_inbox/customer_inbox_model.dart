import '/auth/supabase_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/backend/schema/structs/index.dart';
import '/components/appbar_component/appbar_component_widget.dart';
import '/components/customer_navbar/customer_navbar_widget.dart';
import '/components/empty_list_component/empty_list_component_widget.dart';
import '/components/inbox_item/inbox_item_widget.dart';
import '/components/page_header_sectiom/page_header_sectiom_widget.dart';
import '/theme/app_theme.dart';
import '/core/util.dart';
import '/widgets/app_button.dart';
import 'dart:ui';
import '/custom_code/actions/index.dart' as actions;
import 'customer_inbox_widget.dart' show CustomerInboxWidget;
import 'dart:async';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class CustomerInboxModel extends AppModel<CustomerInboxWidget> {
  ///  Local state fields for this page.

  bool showSearchList = false;

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
      await Future.delayed(Duration(milliseconds: 50));
      final timeElapsed = stopwatch.elapsedMilliseconds;
      final requestComplete = apiRequestCompleter?.isCompleted ?? false;
      if (timeElapsed > maxWait || (requestComplete && timeElapsed > minWait)) {
        break;
      }
    }
  }
}
