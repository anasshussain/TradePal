// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/models/util/firestore_util.dart';
import '/models/util/schema_util.dart';
import '/utils/enums/enums.dart';

import '/models/structs/index.dart';
import '/utils/util.dart';

class MembersStruct extends AppFirebaseStruct {
  MembersStruct({
    String? id,
    String? name,
    String? avatarUrl,
    String? deviceToken,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _id = id,
        _name = name,
        _avatarUrl = avatarUrl,
        _deviceToken = deviceToken,
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

  // "device_token" field.
  String? _deviceToken;
  String get deviceToken => _deviceToken ?? '';
  set deviceToken(String? val) => _deviceToken = val;

  bool hasDeviceToken() => _deviceToken != null;

  static MembersStruct fromMap(Map<String, dynamic> data) => MembersStruct(
        id: data['id'] as String?,
        name: data['name'] as String?,
        avatarUrl: data['avatar_url'] as String?,
        deviceToken: data['device_token'] as String?,
      );

  static MembersStruct? maybeFromMap(dynamic data) =>
      data is Map ? MembersStruct.fromMap(data.cast<String, dynamic>()) : null;

  Map<String, dynamic> toMap() => {
        'id': _id,
        'name': _name,
        'avatar_url': _avatarUrl,
        'device_token': _deviceToken,
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
        'device_token': serializeParam(
          _deviceToken,
          ParamType.String,
        ),
      }.withoutNulls;

  static MembersStruct fromSerializableMap(Map<String, dynamic> data) =>
      MembersStruct(
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
        deviceToken: deserializeParam(
          data['device_token'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'MembersStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is MembersStruct &&
        id == other.id &&
        name == other.name &&
        avatarUrl == other.avatarUrl &&
        deviceToken == other.deviceToken;
  }

  @override
  int get hashCode =>
      const ListEquality().hash([id, name, avatarUrl, deviceToken]);
}

MembersStruct createMembersStruct({
  String? id,
  String? name,
  String? avatarUrl,
  String? deviceToken,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    MembersStruct(
      id: id,
      name: name,
      avatarUrl: avatarUrl,
      deviceToken: deviceToken,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

MembersStruct? updateMembersStruct(
  MembersStruct? members, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    members
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addMembersStructData(
  Map<String, dynamic> firestoreData,
  MembersStruct? members,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (members == null) {
    return;
  }
  if (members.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && members.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final membersData = getMembersFirestoreData(members, forFieldValue);
  final nestedData = membersData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = members.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getMembersFirestoreData(
  MembersStruct? members, [
  bool forFieldValue = false,
]) {
  if (members == null) {
    return {};
  }
  final firestoreData = mapToFirestore(members.toMap());

  // Add any Firestore field values
  mapToFirestore(members.firestoreUtilData.fieldValues)
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getMembersListFirestoreData(
  List<MembersStruct>? memberss,
) =>
    memberss?.map((e) => getMembersFirestoreData(e, true)).toList() ?? [];
