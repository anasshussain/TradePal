import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// State management for the customer_all_jobs screen (migrated from setState).
class CustomerAllJobsProvider extends ChangeNotifier {
  ///  Local state fields for this page.


  bool loading = true;

  bool showSearchList = true;


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
