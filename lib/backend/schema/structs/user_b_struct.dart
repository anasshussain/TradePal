// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';
import '/backend/schema/enums/enums.dart';

import 'index.dart';
import '/core/util.dart';

class UserBStruct extends AppFirebaseStruct {
  UserBStruct({
    String? id,
    String? name,
    String? avatarUrl,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _id = id,
        _name = name,
        _avatarUrl = avatarUrl,
        super(firestoreUtilData);

  // "id" field.
  String? _id;
  String get id => _id ?? '';
  set id(String? val) => _id = val;

  bool hasId() => _id != null;

  // "name" field.
  String? _name;
  String get name => _name ?? '';
  set name(String? val) => _name = val;

  bool hasName() => _name != null;

  // "avatar_url" field.
  String? _avatarUrl;
  String get avatarUrl => _avatarUrl ?? '';
  set avatarUrl(String? val) => _avatarUrl = val;

  bool hasAvatarUrl() => _avatarUrl != null;

  static UserBStruct fromMap(Map<String, dynamic> data) => UserBStruct(
        id: data['id'] as String?,
        name: data['name'] as String?,
        avatarUrl: data['avatar_url'] as String?,
      );

  static UserBStruct? maybeFromMap(dynamic data) =>
      data is Map ? UserBStruct.fromMap(data.cast<String, dynamic>()) : null;

  Map<String, dynamic> toMap() => {
        'id': _id,
        'name': _name,
        'avatar_url': _avatarUrl,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'id': serializeParam(
          _id,
          ParamType.String,
        ),
        'name': serializeParam(
          _name,
          ParamType.String,
        ),
        'avatar_url': serializeParam(
          _avatarUrl,
          ParamType.String,
        ),
      }.withoutNulls;

  static UserBStruct fromSerializableMap(Map<String, dynamic> data) =>
      UserBStruct(
        id: deserializeParam(
          data['id'],
          ParamType.String,
          false,
        ),
        name: deserializeParam(
          data['name'],
          ParamType.String,
          false,
        ),
        avatarUrl: deserializeParam(
          data['avatar_url'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'UserBStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is UserBStruct &&
        id == other.id &&
        name == other.name &&
        avatarUrl == other.avatarUrl;
  }

  @override
  int get hashCode => const ListEquality().hash([id, name, avatarUrl]);
}

UserBStruct createUserBStruct({
  String? id,
  String? name,
  String? avatarUrl,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    UserBStruct(
      id: id,
      name: name,
      avatarUrl: avatarUrl,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

UserBStruct? updateUserBStruct(
  UserBStruct? userB, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    userB
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addUserBStructData(
  Map<String, dynamic> firestoreData,
  UserBStruct? userB,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (userB == null) {
    return;
  }
  if (userB.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && userB.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final userBData = getUserBFirestoreData(userB, forFieldValue);
  final nestedData = userBData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = userB.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getUserBFirestoreData(
  UserBStruct? userB, [
  bool forFieldValue = false,
]) {
  if (userB == null) {
    return {};
  }
  final firestoreData = mapToFirestore(userB.toMap());

  // Add any Firestore field values
  mapToFirestore(userB.firestoreUtilData.fieldValues)
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getUserBListFirestoreData(
  List<UserBStruct>? userBs,
) =>
    userBs?.map((e) => getUserBFirestoreData(e, true)).toList() ?? [];
