import 'package:flutter/foundation.dart';
import '/repositories/backend.dart';
import '/models/structs/index.dart';
import 'package:flutter/material.dart';

/// State management for the notification_page screen (migrated from setState).
class NotificationPageProvider extends ChangeNotifier {
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

  /// Notify observers without mutating state (replaces empty setState).
  bool _disposed = false;

  @override
  void dispose() {
    _disposed = true;
    super.dispose();
  }

  /// Notify observers without mutating state (replaces empty setState).
  void notify() {
    if (!_disposed) notifyListeners();
  }

  /// Run [fn] then notify observers (replaces setState(() => ...)).
  void update(VoidCallback fn) {
    fn();
    if (!_disposed) notifyListeners();
  }
}
