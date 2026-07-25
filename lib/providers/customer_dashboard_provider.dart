import 'package:flutter/foundation.dart';

class CustomerDashboardProvider extends ChangeNotifier {
  bool isLoading = true;
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