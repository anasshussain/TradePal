// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';
import '/backend/schema/enums/enums.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class CriteriaStruct extends FFFirebaseStruct {
  CriteriaStruct({
    int? quality,
    int? communication,
    int? timeliness,
    int? professionalism,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _quality = quality,
        _communication = communication,
        _timeliness = timeliness,
        _professionalism = professionalism,
        super(firestoreUtilData);

  // "quality" field.
  int? _quality;
  int get quality => _quality ?? 0;
  set quality(int? val) => _quality = val;

  void incrementQuality(int amount) => quality = quality + amount;

  bool hasQuality() => _quality != null;

  // "communication" field.
  int? _communication;
  int get communication => _communication ?? 0;
  set communication(int? val) => _communication = val;

  void incrementCommunication(int amount) =>
      communication = communication + amount;

  bool hasCommunication() => _communication != null;

  // "timeliness" field.
  int? _timeliness;
  int get timeliness => _timeliness ?? 0;
  set timeliness(int? val) => _timeliness = val;

  void incrementTimeliness(int amount) => timeliness = timeliness + amount;

  bool hasTimeliness() => _timeliness != null;

  // "professionalism" field.
  int? _professionalism;
  int get professionalism => _professionalism ?? 0;
  set professionalism(int? val) => _professionalism = val;

  void incrementProfessionalism(int amount) =>
      professionalism = professionalism + amount;

  bool hasProfessionalism() => _professionalism != null;

  static CriteriaStruct fromMap(Map<String, dynamic> data) => CriteriaStruct(
        quality: castToType<int>(data['quality']),
        communication: castToType<int>(data['communication']),
        timeliness: castToType<int>(data['timeliness']),
        professionalism: castToType<int>(data['professionalism']),
      );

  static CriteriaStruct? maybeFromMap(dynamic data) =>
      data is Map ? CriteriaStruct.fromMap(data.cast<String, dynamic>()) : null;

  Map<String, dynamic> toMap() => {
        'quality': _quality,
        'communication': _communication,
        'timeliness': _timeliness,
        'professionalism': _professionalism,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'quality': serializeParam(
          _quality,
          ParamType.int,
        ),
        'communication': serializeParam(
          _communication,
          ParamType.int,
        ),
        'timeliness': serializeParam(
          _timeliness,
          ParamType.int,
        ),
        'professionalism': serializeParam(
          _professionalism,
          ParamType.int,
        ),
      }.withoutNulls;

  static CriteriaStruct fromSerializableMap(Map<String, dynamic> data) =>
      CriteriaStruct(
        quality: deserializeParam(
          data['quality'],
          ParamType.int,
          false,
        ),
        communication: deserializeParam(
          data['communication'],
          ParamType.int,
          false,
        ),
        timeliness: deserializeParam(
          data['timeliness'],
          ParamType.int,
          false,
        ),
        professionalism: deserializeParam(
          data['professionalism'],
          ParamType.int,
          false,
        ),
      );

  @override
  String toString() => 'CriteriaStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is CriteriaStruct &&
        quality == other.quality &&
        communication == other.communication &&
        timeliness == other.timeliness &&
        professionalism == other.professionalism;
  }

  @override
  int get hashCode => const ListEquality()
      .hash([quality, communication, timeliness, professionalism]);
}

CriteriaStruct createCriteriaStruct({
  int? quality,
  int? communication,
  int? timeliness,
  int? professionalism,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    CriteriaStruct(
      quality: quality,
      communication: communication,
      timeliness: timeliness,
      professionalism: professionalism,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

CriteriaStruct? updateCriteriaStruct(
  CriteriaStruct? criteria, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    criteria
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addCriteriaStructData(
  Map<String, dynamic> firestoreData,
  CriteriaStruct? criteria,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (criteria == null) {
    return;
  }
  if (criteria.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && criteria.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final criteriaData = getCriteriaFirestoreData(criteria, forFieldValue);
  final nestedData = criteriaData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = criteria.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getCriteriaFirestoreData(
  CriteriaStruct? criteria, [
  bool forFieldValue = false,
]) {
  if (criteria == null) {
    return {};
  }
  final firestoreData = mapToFirestore(criteria.toMap());

  // Add any Firestore field values
  mapToFirestore(criteria.firestoreUtilData.fieldValues)
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getCriteriaListFirestoreData(
  List<CriteriaStruct>? criterias,
) =>
    criterias?.map((e) => getCriteriaFirestoreData(e, true)).toList() ?? [];
