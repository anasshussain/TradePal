// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';
import '/backend/schema/enums/enums.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class SubmittedProposalStruct extends FFFirebaseStruct {
  SubmittedProposalStruct({
    String? id,
    String? jobId,
    String? tradespersonId,
    String? message,
    int? quoteAmount,
    String? status,
    String? createdAt,
    String? duration,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _id = id,
        _jobId = jobId,
        _tradespersonId = tradespersonId,
        _message = message,
        _quoteAmount = quoteAmount,
        _status = status,
        _createdAt = createdAt,
        _duration = duration,
        super(firestoreUtilData);

  // "id" field.
  String? _id;
  String get id => _id ?? '';
  set id(String? val) => _id = val;

  bool hasId() => _id != null;

  // "job_id" field.
  String? _jobId;
  String get jobId => _jobId ?? '';
  set jobId(String? val) => _jobId = val;

  bool hasJobId() => _jobId != null;

  // "tradesperson_id" field.
  String? _tradespersonId;
  String get tradespersonId => _tradespersonId ?? '';
  set tradespersonId(String? val) => _tradespersonId = val;

  bool hasTradespersonId() => _tradespersonId != null;

  // "message" field.
  String? _message;
  String get message => _message ?? '';
  set message(String? val) => _message = val;

  bool hasMessage() => _message != null;

  // "quote_amount" field.
  int? _quoteAmount;
  int get quoteAmount => _quoteAmount ?? 0;
  set quoteAmount(int? val) => _quoteAmount = val;

  void incrementQuoteAmount(int amount) => quoteAmount = quoteAmount + amount;

  bool hasQuoteAmount() => _quoteAmount != null;

  // "status" field.
  String? _status;
  String get status => _status ?? '';
  set status(String? val) => _status = val;

  bool hasStatus() => _status != null;

  // "created_at" field.
  String? _createdAt;
  String get createdAt => _createdAt ?? '';
  set createdAt(String? val) => _createdAt = val;

  bool hasCreatedAt() => _createdAt != null;

  // "duration" field.
  String? _duration;
  String get duration => _duration ?? '';
  set duration(String? val) => _duration = val;

  bool hasDuration() => _duration != null;

  static SubmittedProposalStruct fromMap(Map<String, dynamic> data) =>
      SubmittedProposalStruct(
        id: data['id'] as String?,
        jobId: data['job_id'] as String?,
        tradespersonId: data['tradesperson_id'] as String?,
        message: data['message'] as String?,
        quoteAmount: castToType<int>(data['quote_amount']),
        status: data['status'] as String?,
        createdAt: data['created_at'] as String?,
        duration: data['duration'] as String?,
      );

  static SubmittedProposalStruct? maybeFromMap(dynamic data) => data is Map
      ? SubmittedProposalStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'id': _id,
        'job_id': _jobId,
        'tradesperson_id': _tradespersonId,
        'message': _message,
        'quote_amount': _quoteAmount,
        'status': _status,
        'created_at': _createdAt,
        'duration': _duration,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'id': serializeParam(
          _id,
          ParamType.String,
        ),
        'job_id': serializeParam(
          _jobId,
          ParamType.String,
        ),
        'tradesperson_id': serializeParam(
          _tradespersonId,
          ParamType.String,
        ),
        'message': serializeParam(
          _message,
          ParamType.String,
        ),
        'quote_amount': serializeParam(
          _quoteAmount,
          ParamType.int,
        ),
        'status': serializeParam(
          _status,
          ParamType.String,
        ),
        'created_at': serializeParam(
          _createdAt,
          ParamType.String,
        ),
        'duration': serializeParam(
          _duration,
          ParamType.String,
        ),
      }.withoutNulls;

  static SubmittedProposalStruct fromSerializableMap(
          Map<String, dynamic> data) =>
      SubmittedProposalStruct(
        id: deserializeParam(
          data['id'],
          ParamType.String,
          false,
        ),
        jobId: deserializeParam(
          data['job_id'],
          ParamType.String,
          false,
        ),
        tradespersonId: deserializeParam(
          data['tradesperson_id'],
          ParamType.String,
          false,
        ),
        message: deserializeParam(
          data['message'],
          ParamType.String,
          false,
        ),
        quoteAmount: deserializeParam(
          data['quote_amount'],
          ParamType.int,
          false,
        ),
        status: deserializeParam(
          data['status'],
          ParamType.String,
          false,
        ),
        createdAt: deserializeParam(
          data['created_at'],
          ParamType.String,
          false,
        ),
        duration: deserializeParam(
          data['duration'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'SubmittedProposalStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is SubmittedProposalStruct &&
        id == other.id &&
        jobId == other.jobId &&
        tradespersonId == other.tradespersonId &&
        message == other.message &&
        quoteAmount == other.quoteAmount &&
        status == other.status &&
        createdAt == other.createdAt &&
        duration == other.duration;
  }

  @override
  int get hashCode => const ListEquality().hash([
        id,
        jobId,
        tradespersonId,
        message,
        quoteAmount,
        status,
        createdAt,
        duration
      ]);
}

SubmittedProposalStruct createSubmittedProposalStruct({
  String? id,
  String? jobId,
  String? tradespersonId,
  String? message,
  int? quoteAmount,
  String? status,
  String? createdAt,
  String? duration,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    SubmittedProposalStruct(
      id: id,
      jobId: jobId,
      tradespersonId: tradespersonId,
      message: message,
      quoteAmount: quoteAmount,
      status: status,
      createdAt: createdAt,
      duration: duration,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

SubmittedProposalStruct? updateSubmittedProposalStruct(
  SubmittedProposalStruct? submittedProposal, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    submittedProposal
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addSubmittedProposalStructData(
  Map<String, dynamic> firestoreData,
  SubmittedProposalStruct? submittedProposal,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (submittedProposal == null) {
    return;
  }
  if (submittedProposal.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && submittedProposal.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final submittedProposalData =
      getSubmittedProposalFirestoreData(submittedProposal, forFieldValue);
  final nestedData =
      submittedProposalData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = submittedProposal.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getSubmittedProposalFirestoreData(
  SubmittedProposalStruct? submittedProposal, [
  bool forFieldValue = false,
]) {
  if (submittedProposal == null) {
    return {};
  }
  final firestoreData = mapToFirestore(submittedProposal.toMap());

  // Add any Firestore field values
  mapToFirestore(submittedProposal.firestoreUtilData.fieldValues)
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getSubmittedProposalListFirestoreData(
  List<SubmittedProposalStruct>? submittedProposals,
) =>
    submittedProposals
        ?.map((e) => getSubmittedProposalFirestoreData(e, true))
        .toList() ??
    [];
