import '/auth/supabase_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/backend/backend.dart';
import '/backend/schema/enums/enums.dart';
import '/backend/schema/structs/index.dart';
import '/components/appbar_component/appbar_component_widget.dart';
import '/components/notification_item_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/index.dart';
import 'notification_page_widget.dart' show NotificationPageWidget;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class NotificationPageModel extends FlutterFlowModel<NotificationPageWidget> {
  ///  Local state fields for this page.

  List<NotificationsStruct> notificationsPageState = [];
  void addToNotificationsPageState(NotificationsStruct item) =>
      notificationsPageState.add(item);
  void removeFromNotificationsPageState(NotificationsStruct item) =>
      notificationsPageState.remove(item);
  void removeAtIndexFromNotificationsPageState(int index) =>
      notificationsPageState.removeAt(index);
  void insertAtIndexInNotificationsPageState(
          int index, NotificationsStruct item) =>
      notificationsPageState.insert(index, item);
  void updateNotificationsPageStateAtIndex(
          int index, Function(NotificationsStruct) updateFn) =>
      notificationsPageState[index] = updateFn(notificationsPageState[index]);

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Backend Call - API (get notifications)] action in NotificationPage widget.
  ApiCallResponse? notifications;
  // Model for appbar_component component.
  late AppbarComponentModel appbarComponentModel;

  @override
  void initState(BuildContext context) {
    appbarComponentModel = createModel(context, () => AppbarComponentModel());
  }

  @override
  void dispose() {
    appbarComponentModel.dispose();
  }
}
