import '/repositories/api_requests/api_calls.dart';
import '/utils/util.dart';
import '/widgets/components/loading_component/loading_component_widget.dart'
    show LoadingComponentWidget;
import 'package:flutter/material.dart';

class LoadingComponentModel extends AppModel<LoadingComponentWidget> {
  late final Future<ApiCallResponse> getMessagesFuture;

  @override
  void initState(BuildContext context) {
    getMessagesFuture = SupabaseTablesGroup.getMessagesCall.call();
  }

  @override
  void dispose() {}
}
