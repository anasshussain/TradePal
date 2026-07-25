import 'package:flutter/foundation.dart';
import '/repositories/backend.dart';
import '/models/structs/index.dart';
import 'package:flutter/material.dart';

/// State management for the chat_page screen (migrated from setState).
class ChatPageProvider extends ChangeNotifier {
  ///  Local state fields for this page.


  bool loading = true;

  JobDataStruct? jobData;
  void updateJobDataStruct(Function(JobDataStruct) updateFn) {
    updateFn(jobData ??= JobDataStruct());
  }

  bool isAssigned = false;

  PayloadUpdateJobStruct? dad;
  void updateDadStruct(Function(PayloadUpdateJobStruct) updateFn) {
    updateFn(dad ??= PayloadUpdateJobStruct());
  }

  bool isProposalPaid = true;


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
