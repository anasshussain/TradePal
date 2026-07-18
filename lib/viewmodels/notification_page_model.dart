import '/repositories/api_requests/api_calls.dart';
import '/repositories/backend.dart';
import '/models/structs/index.dart';
import '/widgets/components/appbar_component/appbar_component_widget.dart';
import '/utils/util.dart';
import '/core/routes/index.dart';
import '/notification_page/notification_page_widget.dart' show NotificationPageWidget;
import 'package:flutter/material.dart';

class NotificationPageModel extends AppModel<NotificationPageWidget> {
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

  ApiCallResponse? notifications;
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