import 'package:flutter/foundation.dart';

import '/models/structs/index.dart';

/// State management for the Job Details screen.
///
/// Holds the page's business / view state that previously lived in
/// `JobDetailsModel` and was rebuilt through `setState`. Widgets observe this
/// provider (via `Consumer`/`context.watch`) and mutations are published with
/// [notify] / [update] instead of `setState`.
class JobDetailsProvider extends ChangeNotifier {
  static final Set<String> _loadedJobIds = {};
  bool loading = true;

  JobDataStruct? fetchedJob;
  void updateFetchedJobStruct(Function(JobDataStruct) updateFn) {
    updateFn(fetchedJob ??= JobDataStruct());
  }

  bool? isProposalSubmitted;

  List<ProposalListStruct> proposalsList = [];
  void addToProposalsList(ProposalListStruct item) => proposalsList.add(item);
  void removeFromProposalsList(ProposalListStruct item) =>
      proposalsList.remove(item);
  void removeAtIndexFromProposalsList(int index) =>
      proposalsList.removeAt(index);
  void insertAtIndexInProposalsList(int index, ProposalListStruct item) =>
      proposalsList.insert(index, item);
  void updateProposalsListAtIndex(
          int index, Function(ProposalListStruct) updateFn) =>
      proposalsList[index] = updateFn(proposalsList[index]);

  bool? isPaymentPaid;

  UserStruct? user;
  void updateUserStruct(Function(UserStruct) updateFn) {
    updateFn(user ??= UserStruct());
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
  bool isAlreadyLoaded(String? jobId) =>
      jobId != null && _loadedJobIds.contains(jobId);

  void markLoaded(String? jobId) {
    if (jobId != null) _loadedJobIds.add(jobId);
  }


  void update(VoidCallback fn) {
    fn();
    if (!_disposed) notifyListeners();
  }
}
