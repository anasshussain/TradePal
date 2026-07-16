// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';
import '/backend/schema/enums/enums.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class JobCacheStruct extends FFFirebaseStruct {
  JobCacheStruct({
    List<JobsListItemStruct>? jobs,
    String? lastCursor,
    String? firstCursor,
    bool? hasMore,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _jobs = jobs,
        _lastCursor = lastCursor,
        _firstCursor = firstCursor,
        _hasMore = hasMore,
        super(firestoreUtilData);

  // "jobs" field.
  List<JobsListItemStruct>? _jobs;
  List<JobsListItemStruct> get jobs => _jobs ?? const [];
  set jobs(List<JobsListItemStruct>? val) => _jobs = val;

  void updateJobs(Function(List<JobsListItemStruct>) updateFn) {
    updateFn(_jobs ??= []);
  }

  bool hasJobs() => _jobs != null;

  // "last_cursor" field.
  String? _lastCursor;
  String get lastCursor => _lastCursor ?? '';
  set lastCursor(String? val) => _lastCursor = val;

  bool hasLastCursor() => _lastCursor != null;

  // "first_cursor" field.
  String? _firstCursor;
  String get firstCursor => _firstCursor ?? '';
  set firstCursor(String? val) => _firstCursor = val;

  bool hasFirstCursor() => _firstCursor != null;

  // "has_more" field.
  bool? _hasMore;
  bool get hasMore => _hasMore ?? false;
  set hasMore(bool? val) => _hasMore = val;

  bool hasHasMore() => _hasMore != null;

  static JobCacheStruct fromMap(Map<String, dynamic> data) => JobCacheStruct(
        jobs: getStructList(
          data['jobs'],
          JobsListItemStruct.fromMap,
        ),
        lastCursor: data['last_cursor'] as String?,
        firstCursor: data['first_cursor'] as String?,
        hasMore: data['has_more'] as bool?,
      );

  static JobCacheStruct? maybeFromMap(dynamic data) =>
      data is Map ? JobCacheStruct.fromMap(data.cast<String, dynamic>()) : null;

  Map<String, dynamic> toMap() => {
        'jobs': _jobs?.map((e) => e.toMap()).toList(),
        'last_cursor': _lastCursor,
        'first_cursor': _firstCursor,
        'has_more': _hasMore,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'jobs': serializeParam(
          _jobs,
          ParamType.DataStruct,
          isList: true,
        ),
        'last_cursor': serializeParam(
          _lastCursor,
          ParamType.String,
        ),
        'first_cursor': serializeParam(
          _firstCursor,
          ParamType.String,
        ),
        'has_more': serializeParam(
          _hasMore,
          ParamType.bool,
        ),
      }.withoutNulls;

  static JobCacheStruct fromSerializableMap(Map<String, dynamic> data) =>
      JobCacheStruct(
        jobs: deserializeStructParam<JobsListItemStruct>(
          data['jobs'],
          ParamType.DataStruct,
          true,
          structBuilder: JobsListItemStruct.fromSerializableMap,
        ),
        lastCursor: deserializeParam(
          data['last_cursor'],
          ParamType.String,
          false,
        ),
        firstCursor: deserializeParam(
          data['first_cursor'],
          ParamType.String,
          false,
        ),
        hasMore: deserializeParam(
          data['has_more'],
          ParamType.bool,
          false,
        ),
      );

  @override
  String toString() => 'JobCacheStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    const listEquality = ListEquality();
    return other is JobCacheStruct &&
        listEquality.equals(jobs, other.jobs) &&
        lastCursor == other.lastCursor &&
        firstCursor == other.firstCursor &&
        hasMore == other.hasMore;
  }

  @override
  int get hashCode =>
      const ListEquality().hash([jobs, lastCursor, firstCursor, hasMore]);
}

JobCacheStruct createJobCacheStruct({
  String? lastCursor,
  String? firstCursor,
  bool? hasMore,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    JobCacheStruct(
      lastCursor: lastCursor,
      firstCursor: firstCursor,
      hasMore: hasMore,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

JobCacheStruct? updateJobCacheStruct(
  JobCacheStruct? jobCache, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    jobCache
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addJobCacheStructData(
  Map<String, dynamic> firestoreData,
  JobCacheStruct? jobCache,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (jobCache == null) {
    return;
  }
  if (jobCache.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && jobCache.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final jobCacheData = getJobCacheFirestoreData(jobCache, forFieldValue);
  final nestedData = jobCacheData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = jobCache.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getJobCacheFirestoreData(
  JobCacheStruct? jobCache, [
  bool forFieldValue = false,
]) {
  if (jobCache == null) {
    return {};
  }
  final firestoreData = mapToFirestore(jobCache.toMap());

  // Add any Firestore field values
  mapToFirestore(jobCache.firestoreUtilData.fieldValues)
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getJobCacheListFirestoreData(
  List<JobCacheStruct>? jobCaches,
) =>
    jobCaches?.map((e) => getJobCacheFirestoreData(e, true)).toList() ?? [];
