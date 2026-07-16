// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';
import '/backend/schema/enums/enums.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class StartChatStruct extends FFFirebaseStruct {
  StartChatStruct({
    String? conversationId,
    UserAStruct? userA,
    UserBStruct? userB,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _conversationId = conversationId,
        _userA = userA,
        _userB = userB,
        super(firestoreUtilData);

  // "conversation_id" field.
  String? _conversationId;
  String get conversationId => _conversationId ?? '';
  set conversationId(String? val) => _conversationId = val;

  bool hasConversationId() => _conversationId != null;

  // "user_a" field.
  UserAStruct? _userA;
  UserAStruct get userA => _userA ?? UserAStruct();
  set userA(UserAStruct? val) => _userA = val;

  void updateUserA(Function(UserAStruct) updateFn) {
    updateFn(_userA ??= UserAStruct());
  }

  bool hasUserA() => _userA != null;

  // "user_b" field.
  UserBStruct? _userB;
  UserBStruct get userB => _userB ?? UserBStruct();
  set userB(UserBStruct? val) => _userB = val;

  void updateUserB(Function(UserBStruct) updateFn) {
    updateFn(_userB ??= UserBStruct());
  }

  bool hasUserB() => _userB != null;

  static StartChatStruct fromMap(Map<String, dynamic> data) => StartChatStruct(
        conversationId: data['conversation_id'] as String?,
        userA: data['user_a'] is UserAStruct
            ? data['user_a']
            : UserAStruct.maybeFromMap(data['user_a']),
        userB: data['user_b'] is UserBStruct
            ? data['user_b']
            : UserBStruct.maybeFromMap(data['user_b']),
      );

  static StartChatStruct? maybeFromMap(dynamic data) => data is Map
      ? StartChatStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'conversation_id': _conversationId,
        'user_a': _userA?.toMap(),
        'user_b': _userB?.toMap(),
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'conversation_id': serializeParam(
          _conversationId,
          ParamType.String,
        ),
        'user_a': serializeParam(
          _userA,
          ParamType.DataStruct,
        ),
        'user_b': serializeParam(
          _userB,
          ParamType.DataStruct,
        ),
      }.withoutNulls;

  static StartChatStruct fromSerializableMap(Map<String, dynamic> data) =>
      StartChatStruct(
        conversationId: deserializeParam(
          data['conversation_id'],
          ParamType.String,
          false,
        ),
        userA: deserializeStructParam(
          data['user_a'],
          ParamType.DataStruct,
          false,
          structBuilder: UserAStruct.fromSerializableMap,
        ),
        userB: deserializeStructParam(
          data['user_b'],
          ParamType.DataStruct,
          false,
          structBuilder: UserBStruct.fromSerializableMap,
        ),
      );

  @override
  String toString() => 'StartChatStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is StartChatStruct &&
        conversationId == other.conversationId &&
        userA == other.userA &&
        userB == other.userB;
  }

  @override
  int get hashCode => const ListEquality().hash([conversationId, userA, userB]);
}

StartChatStruct createStartChatStruct({
  String? conversationId,
  UserAStruct? userA,
  UserBStruct? userB,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    StartChatStruct(
      conversationId: conversationId,
      userA: userA ?? (clearUnsetFields ? UserAStruct() : null),
      userB: userB ?? (clearUnsetFields ? UserBStruct() : null),
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

StartChatStruct? updateStartChatStruct(
  StartChatStruct? startChat, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    startChat
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addStartChatStructData(
  Map<String, dynamic> firestoreData,
  StartChatStruct? startChat,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (startChat == null) {
    return;
  }
  if (startChat.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && startChat.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final startChatData = getStartChatFirestoreData(startChat, forFieldValue);
  final nestedData = startChatData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = startChat.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getStartChatFirestoreData(
  StartChatStruct? startChat, [
  bool forFieldValue = false,
]) {
  if (startChat == null) {
    return {};
  }
  final firestoreData = mapToFirestore(startChat.toMap());

  // Handle nested data for "user_a" field.
  addUserAStructData(
    firestoreData,
    startChat.hasUserA() ? startChat.userA : null,
    'user_a',
    forFieldValue,
  );

  // Handle nested data for "user_b" field.
  addUserBStructData(
    firestoreData,
    startChat.hasUserB() ? startChat.userB : null,
    'user_b',
    forFieldValue,
  );

  // Add any Firestore field values
  mapToFirestore(startChat.firestoreUtilData.fieldValues)
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getStartChatListFirestoreData(
  List<StartChatStruct>? startChats,
) =>
    startChats?.map((e) => getStartChatFirestoreData(e, true)).toList() ?? [];
