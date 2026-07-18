// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/models/util/firestore_util.dart';
import '/models/util/schema_util.dart';
import '/utils/enums/enums.dart';

import '/models/structs/index.dart';
import '/utils/util.dart';

class SubmittedJobsListStruct extends AppFirebaseStruct {
  SubmittedJobsListStruct({
    JobsStruct? jobs,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _jobs = jobs,
        super(firestoreUtilData);

  // "jobs" field.
  JobsStruct? _jobs;
  JobsStruct get jobs => _jobs ?? JobsStruct();
  set jobs(JobsStruct? val) => _jobs = val;

  void updateJobs(Function(JobsStruct) updateFn) {
    updateFn(_jobs ??= JobsStruct());
  }

  bool hasJobs() => _jobs != null;

  static SubmittedJobsListStruct fromMap(Map<String, dynamic> data) =>
      SubmittedJobsListStruct(
        jobs: data['jobs'] is JobsStruct
            ? data['jobs']
            : JobsStruct.maybeFromMap(data['jobs']),
      );

  static SubmittedJobsListStruct? maybeFromMap(dynamic data) => data is Map
      ? SubmittedJobsListStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'jobs': _jobs?.toMap(),
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'jobs': serializeParam(
          _jobs,
          ParamType.DataStruct,
        ),
      }.withoutNulls;

  static SubmittedJobsListStruct fromSerializableMap(
          Map<String, dynamic> data) =>
      SubmittedJobsListStruct(
        jobs: deserializeStructParam(
          data['jobs'],
          ParamType.DataStruct,
          false,
          structBuilder: JobsStruct.fromSerializableMap,
        ),
      );

  @override
  String toString() => 'SubmittedJobsListStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is SubmittedJobsListStruct && jobs == other.jobs;
  }

  @override
  int get hashCode => const ListEquality().hash([jobs]);
}

SubmittedJobsListStruct createSubmittedJobsListStruct({
  JobsStruct? jobs,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    SubmittedJobsListStruct(
      jobs: jobs ?? (clearUnsetFields ? JobsStruct() : null),
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

SubmittedJobsListStruct? updateSubmittedJobsListStruct(
  SubmittedJobsListStruct? submittedJobsList, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    submittedJobsList
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addSubmittedJobsListStructData(
  Map<String, dynamic> firestoreData,
  SubmittedJobsListStruct? submittedJobsList,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (submittedJobsList == null) {
    return;
  }
  if (submittedJobsList.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && submittedJobsList.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final submittedJobsListData =
      getSubmittedJobsListFirestoreData(submittedJobsList, forFieldValue);
  final nestedData =
      submittedJobsListData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = submittedJobsList.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getSubmittedJobsListFirestoreData(
  SubmittedJobsListStruct? submittedJobsList, [
  bool forFieldValue = false,
]) {
  if (submittedJobsList == null) {
    return {};
  }
  final firestoreData = mapToFirestore(submittedJobsList.toMap());

  // Handle nested data for "jobs" field.
  addJobsStructData(
    firestoreData,
    submittedJobsList.hasJobs() ? submittedJobsList.jobs : null,
    'jobs',
    forFieldValue,
  );

  // Add any Firestore field values
  mapToFirestore(submittedJobsList.firestoreUtilData.fieldValues)
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getSubmittedJobsListListFirestoreData(
  List<SubmittedJobsListStruct>? submittedJobsLists,
) =>
    submittedJobsLists
        ?.map((e) => getSubmittedJobsListFirestoreData(e, true))
        .toList() ??
    [];
