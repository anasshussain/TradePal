import 'package:flutter/foundation.dart';
import '/repositories/backend.dart';
import '/models/structs/index.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  double? acceptedQuoteAmount;

  bool isPaymentCompleted = false;

  static String _paymentCompletedKey(String? jobId) =>
      'chat_page_payment_completed_$jobId';

  /// Restores whether the final job payment was already completed for
  /// [jobId], persisted across app restarts.
  Future<void> restorePaymentCompleted(String? jobId) async {
    if (jobId == null) return;
    final prefs = await SharedPreferences.getInstance();
    isPaymentCompleted = prefs.getBool(_paymentCompletedKey(jobId)) ?? false;
    notify();
  }

  /// Marks the final job payment as completed for [jobId] and persists it.
  Future<void> markPaymentCompleted(String? jobId) async {
    isPaymentCompleted = true;
    notify();
    if (jobId == null) return;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_paymentCompletedKey(jobId), true);
  }

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
