// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';
import '/backend/schema/enums/enums.dart';

import 'index.dart';
import '/core/util.dart';

class ProposalsForThisJobStruct extends AppFirebaseStruct {
  ProposalsForThisJobStruct({
    int? count,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _count = count,
        super(firestoreUtilData);

  // "count" field.
  int? _count;
  int get count => _count ?? 0;
  set count(int? val) => _count = val;

  void incrementCount(int amount) => count = count + amount;

  bool hasCount() => _count != null;

  static ProposalsForThisJobStruct fromMap(Map<String, dynamic> data) =>
      ProposalsForThisJobStruct(
        count: castToType<int>(data['count']),
      );

  static ProposalsForThisJobStruct? maybeFromMap(dynamic data) => data is Map
      ? ProposalsForThisJobStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'count': _count,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'count': serializeParam(
          _count,
          ParamType.int,
        ),
      }.withoutNulls;

  static ProposalsForThisJobStruct fromSerializableMap(
          Map<String, dynamic> data) =>
      ProposalsForThisJobStruct(
        count: deserializeParam(
          data['count'],
          ParamType.int,
          false,
        ),
      );

  @override
  String toString() => 'ProposalsForThisJobStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is ProposalsForThisJobStruct && count == other.count;
  }

  @override
  int get hashCode => const ListEquality().hash([count]);
}

ProposalsForThisJobStruct createProposalsForThisJobStruct({
  int? count,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    ProposalsForThisJobStruct(
      count: count,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

ProposalsForThisJobStruct? updateProposalsForThisJobStruct(
  ProposalsForThisJobStruct? proposalsForThisJob, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    proposalsForThisJob
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addProposalsForThisJobStructData(
  Map<String, dynamic> firestoreData,
  ProposalsForThisJobStruct? proposalsForThisJob,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (proposalsForThisJob == null) {
    return;
  }
  if (proposalsForThisJob.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && proposalsForThisJob.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final proposalsForThisJobData =
      getProposalsForThisJobFirestoreData(proposalsForThisJob, forFieldValue);
  final nestedData =
      proposalsForThisJobData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields =
      proposalsForThisJob.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getProposalsForThisJobFirestoreData(
  ProposalsForThisJobStruct? proposalsForThisJob, [
  bool forFieldValue = false,
]) {
  if (proposalsForThisJob == null) {
    return {};
  }
  final firestoreData = mapToFirestore(proposalsForThisJob.toMap());

  // Add any Firestore field values
  mapToFirestore(proposalsForThisJob.firestoreUtilData.fieldValues)
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getProposalsForThisJobListFirestoreData(
  List<ProposalsForThisJobStruct>? proposalsForThisJobs,
) =>
    proposalsForThisJobs
        ?.map((e) => getProposalsForThisJobFirestoreData(e, true))
        .toList() ??
    [];
