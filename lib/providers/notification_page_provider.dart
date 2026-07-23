import 'package:flutter/foundation.dart';
import '/repositories/backend.dart';
import '/models/structs/index.dart';
import 'package:flutter/material.dart';

class NotificationPageProvider extends ChangeNotifier {
  bool isLoading = true;

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

  void setLoading(bool value) {
    isLoading = value;
    notify();
  }

  bool _disposed = false;

  @override
  void dispose() {
    _disposed = true;
    super.dispose();
  }

  void notify() {
    if (!_disposed) notifyListeners();
  }

  void update(VoidCallback fn) {
    fn();
    if (!_disposed) notifyListeners();
  }
}