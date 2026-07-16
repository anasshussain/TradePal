// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';
import '/backend/schema/enums/enums.dart';

import 'index.dart';
import '/core/util.dart';

class ExtraDataStruct extends AppFirebaseStruct {
  ExtraDataStruct({
    MemberStruct? member,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _member = member,
        super(firestoreUtilData);

  // "member" field.
  MemberStruct? _member;
  MemberStruct get member => _member ?? MemberStruct();
  set member(MemberStruct? val) => _member = val;

  void updateMember(Function(MemberStruct) updateFn) {
    updateFn(_member ??= MemberStruct());
  }

  bool hasMember() => _member != null;

  static ExtraDataStruct fromMap(Map<String, dynamic> data) => ExtraDataStruct(
        member: data['member'] is MemberStruct
            ? data['member']
            : MemberStruct.maybeFromMap(data['member']),
      );

  static ExtraDataStruct? maybeFromMap(dynamic data) => data is Map
      ? ExtraDataStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'member': _member?.toMap(),
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'member': serializeParam(
          _member,
          ParamType.DataStruct,
        ),
      }.withoutNulls;

  static ExtraDataStruct fromSerializableMap(Map<String, dynamic> data) =>
      ExtraDataStruct(
        member: deserializeStructParam(
          data['member'],
          ParamType.DataStruct,
          false,
          structBuilder: MemberStruct.fromSerializableMap,
        ),
      );

  @override
  String toString() => 'ExtraDataStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is ExtraDataStruct && member == other.member;
  }

  @override
  int get hashCode => const ListEquality().hash([member]);
}

ExtraDataStruct createExtraDataStruct({
  MemberStruct? member,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    ExtraDataStruct(
      member: member ?? (clearUnsetFields ? MemberStruct() : null),
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

ExtraDataStruct? updateExtraDataStruct(
  ExtraDataStruct? extraData, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    extraData
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addExtraDataStructData(
  Map<String, dynamic> firestoreData,
  ExtraDataStruct? extraData,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (extraData == null) {
    return;
  }
  if (extraData.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && extraData.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final extraDataData = getExtraDataFirestoreData(extraData, forFieldValue);
  final nestedData = extraDataData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = extraData.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getExtraDataFirestoreData(
  ExtraDataStruct? extraData, [
  bool forFieldValue = false,
]) {
  if (extraData == null) {
    return {};
  }
  final firestoreData = mapToFirestore(extraData.toMap());

  // Handle nested data for "member" field.
  addMemberStructData(
    firestoreData,
    extraData.hasMember() ? extraData.member : null,
    'member',
    forFieldValue,
  );

  // Add any Firestore field values
  mapToFirestore(extraData.firestoreUtilData.fieldValues)
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getExtraDataListFirestoreData(
  List<ExtraDataStruct>? extraDatas,
) =>
    extraDatas?.map((e) => getExtraDataFirestoreData(e, true)).toList() ?? [];
