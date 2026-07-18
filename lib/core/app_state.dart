import 'package:flutter/material.dart';
import '/repositories/backend.dart';
import '/models/structs/index.dart';
import '/utils/enums/enums.dart';
import '/repositories/api_requests/api_manager.dart';
import '/repositories/supabase/supabase.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '/utils/util.dart';

class AppState extends ChangeNotifier {
  static AppState _instance = AppState._internal();

  factory AppState() {
    return _instance;
  }

  AppState._internal();

  static void reset() {
    _instance = AppState._internal();
  }

  // Persisted-state keys. The `ff_`-prefixed names are what shipped builds
  // wrote, so they are still read once and migrated across; removing that
  // fallback would silently reset onboarding and drop the FCM device token
  // for every existing install.
  static const _kOnboarding = 'onboarding';
  static const _kCurrentDeviceToken = 'currentDeviceToken';
  static const _kLegacyOnboarding = 'ff_onboarding';
  static const _kLegacyCurrentDeviceToken = 'ff_currentDeviceToken';

  Future initializePersistedState() async {
    prefs = await SharedPreferences.getInstance();
    await _migrateLegacyKeys();
    _safeInit(() {
      _onboarding = prefs.getBool(_kOnboarding) ?? _onboarding;
    });
    _safeInit(() {
      _currentDeviceToken =
          prefs.getString(_kCurrentDeviceToken) ?? _currentDeviceToken;
    });
  }

  /// Moves values written under the legacy `ff_` keys onto the current keys.
  /// Runs once per install: after the copy the legacy key is removed, and the
  /// current key already existing means there is nothing left to migrate.
  Future<void> _migrateLegacyKeys() async {
    try {
      if (!prefs.containsKey(_kOnboarding) &&
          prefs.containsKey(_kLegacyOnboarding)) {
        final legacy = prefs.getBool(_kLegacyOnboarding);
        if (legacy != null) await prefs.setBool(_kOnboarding, legacy);
      }
      await prefs.remove(_kLegacyOnboarding);

      if (!prefs.containsKey(_kCurrentDeviceToken) &&
          prefs.containsKey(_kLegacyCurrentDeviceToken)) {
        final legacy = prefs.getString(_kLegacyCurrentDeviceToken);
        if (legacy != null) await prefs.setString(_kCurrentDeviceToken, legacy);
      }
      await prefs.remove(_kLegacyCurrentDeviceToken);
    } catch (_) {
      // A failed migration must not block startup; the fields keep their
      // defaults and will be repopulated as the user goes on.
    }
  }

  void update(VoidCallback callback) {
    callback();
    notifyListeners();
  }

  late SharedPreferences prefs;

  List<String> _jobSearches = [];
  List<String> get jobSearches => _jobSearches;
  set jobSearches(List<String> value) {
    _jobSearches = value;
  }

  void addToJobSearches(String value) {
    jobSearches.add(value);
  }

  void removeFromJobSearches(String value) {
    jobSearches.remove(value);
  }

  void removeAtIndexFromJobSearches(int index) {
    jobSearches.removeAt(index);
  }

  void updateJobSearchesAtIndex(
    int index,
    String Function(String) updateFn,
  ) {
    jobSearches[index] = updateFn(_jobSearches[index]);
  }

  void insertAtIndexInJobSearches(int index, String value) {
    jobSearches.insert(index, value);
  }

  List<DocumentReference> _recentlyViewedJobs = [];
  List<DocumentReference> get recentlyViewedJobs => _recentlyViewedJobs;
  set recentlyViewedJobs(List<DocumentReference> value) {
    _recentlyViewedJobs = value;
  }

  void addToRecentlyViewedJobs(DocumentReference value) {
    recentlyViewedJobs.add(value);
  }

  void removeFromRecentlyViewedJobs(DocumentReference value) {
    recentlyViewedJobs.remove(value);
  }

  void removeAtIndexFromRecentlyViewedJobs(int index) {
    recentlyViewedJobs.removeAt(index);
  }

  void updateRecentlyViewedJobsAtIndex(
    int index,
    DocumentReference Function(DocumentReference) updateFn,
  ) {
    recentlyViewedJobs[index] = updateFn(_recentlyViewedJobs[index]);
  }

  void insertAtIndexInRecentlyViewedJobs(int index, DocumentReference value) {
    recentlyViewedJobs.insert(index, value);
  }

  bool _onboarding = false;
  bool get onboarding => _onboarding;
  set onboarding(bool value) {
    _onboarding = value;
    prefs.setBool(_kOnboarding, value);
  }

  UserStruct _userProfileCache = UserStruct();
  UserStruct get userProfileCache => _userProfileCache;
  set userProfileCache(UserStruct value) {
    _userProfileCache = value;
  }

  void updateUserProfileCacheStruct(Function(UserStruct) updateFn) {
    updateFn(_userProfileCache);
  }

  JobCacheStruct _jobCache = JobCacheStruct.fromSerializableMap(jsonDecode(
      '{\"jobs\":\"[]\",\"last_cursor\":\"0\",\"first_cursor\":\"0\",\"has_more\":\"true\"}'));
  JobCacheStruct get jobCache => _jobCache;
  set jobCache(JobCacheStruct value) {
    _jobCache = value;
  }

  void updateJobCacheStruct(Function(JobCacheStruct) updateFn) {
    updateFn(_jobCache);
  }

  List<String> _availableServices = [
    'Bathroom installer',
    'Brick layer',
    'Carpenter/Joiner',
    'Carpet fitter',
    'Chimney specialist',
    'Carpet cleaner',
    'Damp proofer',
    'Double glazing installer',
    'Electrician',
    'Ground worker',
    'Mason',
    'Driver way installer',
    'Loft conversion',
    'Kitchen installer',
    'Painter',
    'Tiler',
    'Tree surgeon'
  ];
  List<String> get availableServices => _availableServices;
  set availableServices(List<String> value) {
    _availableServices = value;
  }

  void addToAvailableServices(String value) {
    availableServices.add(value);
  }

  void removeFromAvailableServices(String value) {
    availableServices.remove(value);
  }

  void removeAtIndexFromAvailableServices(int index) {
    availableServices.removeAt(index);
  }

  void updateAvailableServicesAtIndex(
    int index,
    String Function(String) updateFn,
  ) {
    availableServices[index] = updateFn(_availableServices[index]);
  }

  void insertAtIndexInAvailableServices(int index, String value) {
    availableServices.insert(index, value);
  }

  List<SubmittedJobsListStruct> _submittedJobListCache = [];
  List<SubmittedJobsListStruct> get submittedJobListCache =>
      _submittedJobListCache;
  set submittedJobListCache(List<SubmittedJobsListStruct> value) {
    _submittedJobListCache = value;
  }

  void addToSubmittedJobListCache(SubmittedJobsListStruct value) {
    submittedJobListCache.add(value);
  }

  void removeFromSubmittedJobListCache(SubmittedJobsListStruct value) {
    submittedJobListCache.remove(value);
  }

  void removeAtIndexFromSubmittedJobListCache(int index) {
    submittedJobListCache.removeAt(index);
  }

  void updateSubmittedJobListCacheAtIndex(
    int index,
    SubmittedJobsListStruct Function(SubmittedJobsListStruct) updateFn,
  ) {
    submittedJobListCache[index] = updateFn(_submittedJobListCache[index]);
  }

  void insertAtIndexInSubmittedJobListCache(
      int index, SubmittedJobsListStruct value) {
    submittedJobListCache.insert(index, value);
  }

  String _selectedTheme = '';
  String get selectedTheme => _selectedTheme;
  set selectedTheme(String value) {
    _selectedTheme = value;
  }

  String _chatUploadedImage = '';
  String get chatUploadedImage => _chatUploadedImage;
  set chatUploadedImage(String value) {
    _chatUploadedImage = value;
  }

  int _totalMessagesCount = 0;
  int get totalMessagesCount => _totalMessagesCount;
  set totalMessagesCount(int value) {
    _totalMessagesCount = value;
  }

  String _currentDeviceToken = '';
  String get currentDeviceToken => _currentDeviceToken;
  set currentDeviceToken(String value) {
    _currentDeviceToken = value;
    prefs.setString(_kCurrentDeviceToken, value);
  }

  String _exception = '';
  String get exception => _exception;
  set exception(String value) {
    _exception = value;
  }

  String _paidJobId = '';
  String get paidJobId => _paidJobId;
  set paidJobId(String value) {
    _paidJobId = value;
  }
}

void _safeInit(Function() initializeField) {
  try {
    initializeField();
  } catch (_) {}
}

Future _safeInitAsync(Function() initializeField) async {
  try {
    await initializeField();
  } catch (_) {}
}
