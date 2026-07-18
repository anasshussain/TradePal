// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/models/util/firestore_util.dart';
import '/models/util/schema_util.dart';
import '/utils/enums/enums.dart';

import '/models/structs/index.dart';
import '/utils/util.dart';

class FutureRequirementsStruct extends AppFirebaseStruct {
  FutureRequirementsStruct({
    List<String>? currentlyDue,
    List<String>? errors,
    List<String>? pastDue,
    List<String>? pendingVerification,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _currentlyDue = currentlyDue,
        _errors = errors,
        _pastDue = pastDue,
        _pendingVerification = pendingVerification,
        super(firestoreUtilData);

  // "currently_due" field.
  List<String>? _currentlyDue;
  List<String> get currentlyDue => _currentlyDue ?? const [];
  set currentlyDue(List<String>? val) => _currentlyDue = val;

  void updateCurrentlyDue(Function(List<String>) updateFn) {
    updateFn(_currentlyDue ??= []);
  }

  bool hasCurrentlyDue() => _currentlyDue != null;

  // "errors" field.
  List<String>? _errors;
  List<String> get errors => _errors ?? const [];
  set errors(List<String>? val) => _errors = val;

  void updateErrors(Function(List<String>) updateFn) {
    updateFn(_errors ??= []);
  }

  bool hasErrors() => _errors != null;

  // "past_due" field.
  List<String>? _pastDue;
  List<String> get pastDue => _pastDue ?? const [];
  set pastDue(List<String>? val) => _pastDue = val;

  void updatePastDue(Function(List<String>) updateFn) {
    updateFn(_pastDue ??= []);
  }

  bool hasPastDue() => _pastDue != null;

  // "pending_verification" field.
  List<String>? _pendingVerification;
  List<String> get pendingVerification => _pendingVerification ?? const [];
  set pendingVerification(List<String>? val) => _pendingVerification = val;

  void updatePendingVerification(Function(List<String>) updateFn) {
    updateFn(_pendingVerification ??= []);
  }

  bool hasPendingVerification() => _pendingVerification != null;

  static FutureRequirementsStruct fromMap(Map<String, dynamic> data) =>
      FutureRequirementsStruct(
        currentlyDue: getDataList(data['currently_due']),
        errors: getDataList(data['errors']),
        pastDue: getDataList(data['past_due']),
        pendingVerification: getDataList(data['pending_verification']),
      );

  static FutureRequirementsStruct? maybeFromMap(dynamic data) => data is Map
      ? FutureRequirementsStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'currently_due': _currentlyDue,
        'errors': _errors,
        'past_due': _pastDue,
        'pending_verification': _pendingVerification,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'currently_due': serializeParam(
          _currentlyDue,
          ParamType.String,
          isList: true,
        ),
        'errors': serializeParam(
          _errors,
          ParamType.String,
          isList: true,
        ),
        'past_due': serializeParam(
          _pastDue,
          ParamType.String,
          isList: true,
        ),
        'pending_verification': serializeParam(
          _pendingVerification,
          ParamType.String,
          isList: true,
        ),
      }.withoutNulls;

  static FutureRequirementsStruct fromSerializableMap(
          Map<String, dynamic> data) =>
      FutureRequirementsStruct(
        currentlyDue: deserializeParam<String>(
          data['currently_due'],
          ParamType.String,
          true,
        ),
        errors: deserializeParam<String>(
          data['errors'],
          ParamType.String,
          true,
        ),
        pastDue: deserializeParam<String>(
          data['past_due'],
          ParamType.String,
          true,
        ),
        pendingVerification: deserializeParam<String>(
          data['pending_verification'],
          ParamType.String,
          true,
        ),
      );

  @override
  String toString() => 'FutureRequirementsStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    const listEquality = ListEquality();
    return other is FutureRequirementsStruct &&
        listEquality.equals(currentlyDue, other.currentlyDue) &&
        listEquality.equals(errors, other.errors) &&
        listEquality.equals(pastDue, other.pastDue) &&
        listEquality.equals(pendingVerification, other.pendingVerification);
  }

  @override
  int get hashCode => const ListEquality()
      .hash([currentlyDue, errors, pastDue, pendingVerification]);
}

FutureRequirementsStruct createFutureRequirementsStruct({
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    FutureRequirementsStruct(
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

FutureRequirementsStruct? updateFutureRequirementsStruct(
  FutureRequirementsStruct? futureRequirements, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    futureRequirements
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addFutureRequirementsStructData(
  Map<String, dynamic> firestoreData,
  FutureRequirementsStruct? futureRequirements,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (futureRequirements == null) {
    return;
  }
  if (futureRequirements.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && futureRequirements.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final futureRequirementsData =
      getFutureRequirementsFirestoreData(futureRequirements, forFieldValue);
  final nestedData =
      futureRequirementsData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields =
      futureRequirements.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getFutureRequirementsFirestoreData(
  FutureRequirementsStruct? futureRequirements, [
  bool forFieldValue = false,
]) {
  if (futureRequirements == null) {
    return {};
  }
  final firestoreData = mapToFirestore(futureRequirements.toMap());

  // Add any Firestore field values
  mapToFirestore(futureRequirements.firestoreUtilData.fieldValues)
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getFutureRequirementsListFirestoreData(
  List<FutureRequirementsStruct>? futureRequirementss,
) =>
    futureRequirementss
        ?.map((e) => getFutureRequirementsFirestoreData(e, true))
        .toList() ??
    [];
