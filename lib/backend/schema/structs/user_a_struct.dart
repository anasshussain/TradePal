// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';
import '/backend/schema/enums/enums.dart';

import 'index.dart';
import '/core/util.dart';

class UserAStruct extends AppFirebaseStruct {
  UserAStruct({
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

  static UserAStruct fromMap(Map<String, dynamic> data) => UserAStruct(
        id: data['id'] as String?,
        name: data['name'] as String?,
        avatarUrl: data['avatar_url'] as String?,
      );

  static UserAStruct? maybeFromMap(dynamic data) =>
      data is Map ? UserAStruct.fromMap(data.cast<String, dynamic>()) : null;

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

  static UserAStruct fromSerializableMap(Map<String, dynamic> data) =>
      UserAStruct(
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
  String toString() => 'UserAStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is UserAStruct &&
        id == other.id &&
        name == other.name &&
        avatarUrl == other.avatarUrl;
  }

  @override
  int get hashCode => const ListEquality().hash([id, name, avatarUrl]);
}

UserAStruct createUserAStruct({
  String? id,
  String? name,
  String? avatarUrl,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    UserAStruct(
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

UserAStruct? updateUserAStruct(
  UserAStruct? userA, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    userA
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addUserAStructData(
  Map<String, dynamic> firestoreData,
  UserAStruct? userA,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (userA == null) {
    return;
  }
  if (userA.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && userA.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final userAData = getUserAFirestoreData(userA, forFieldValue);
  final nestedData = userAData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = userA.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getUserAFirestoreData(
  UserAStruct? userA, [
  bool forFieldValue = false,
]) {
  if (userA == null) {
    return {};
  }
  final firestoreData = mapToFirestore(userA.toMap());

  // Add any Firestore field values
  mapToFirestore(userA.firestoreUtilData.fieldValues)
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getUserAListFirestoreData(
  List<UserAStruct>? userAs,
) =>
    userAs?.map((e) => getUserAFirestoreData(e, true)).toList() ?? [];
