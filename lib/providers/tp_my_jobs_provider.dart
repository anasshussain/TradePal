import 'package:flutter/foundation.dart';

class TpMyJobsProvider extends ChangeNotifier {
  static bool isLoadingRequested = true;
  static bool isLoadingInProgress = true;
  static bool isLoadingCompleted = true;

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