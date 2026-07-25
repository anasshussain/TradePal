import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// State management for the tp_inbox screen (migrated from setState).
class TpInboxProvider extends ChangeNotifier {
  ///  Local state fields for this page.


  bool showSearchList = false;


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
