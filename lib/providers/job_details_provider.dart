import 'package:flutter/foundation.dart';
import '/models/structs/index.dart';

class JobDetailsProvider extends ChangeNotifier {
  static final Set<String> _loadedJobIds = {};

  static final Map<String, JobDataStruct?> _cachedJob = {};
  static final Map<String, List<ProposalListStruct>> _cachedProposals = {};
  static final Map<String, bool?> _cachedIsProposalSubmitted = {};
  static final Map<String, bool?> _cachedIsPaymentPaid = {};
  static final Map<String, UserStruct?> _cachedUser = {};

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

  void restoreFromCache(String? jobId) {
    if (jobId == null) return;
    fetchedJob = _cachedJob[jobId];
    proposalsList = _cachedProposals[jobId] ?? [];
    isProposalSubmitted = _cachedIsProposalSubmitted[jobId];
    isPaymentPaid = _cachedIsPaymentPaid[jobId];
    user = _cachedUser[jobId];
    loading = false;
  }

  void saveToCache(String? jobId) {
    if (jobId == null) return;
    _cachedJob[jobId] = fetchedJob;
    _cachedProposals[jobId] = proposalsList;
    _cachedIsProposalSubmitted[jobId] = isProposalSubmitted;
    _cachedIsPaymentPaid[jobId] = isPaymentPaid;
    _cachedUser[jobId] = user;
    markLoaded(jobId);
  }

  void update(VoidCallback fn) {
    fn();
    if (!_disposed) notifyListeners();
  }
}