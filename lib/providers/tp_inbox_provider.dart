import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class TpInboxProvider extends ChangeNotifier {
  static bool isLoading = true;

  bool showSearchList = false;
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
