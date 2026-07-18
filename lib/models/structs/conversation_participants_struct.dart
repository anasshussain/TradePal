// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/models/util/firestore_util.dart';
import '/models/util/schema_util.dart';
import '/utils/enums/enums.dart';

import '/models/structs/index.dart';
import '/utils/util.dart';

class ConversationParticipantsStruct extends AppFirebaseStruct {
  ConversationParticipantsStruct({
    MembersStruct? members,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _members = members,
        super(firestoreUtilData);

  // "members" field.
  MembersStruct? _members;
  MembersStruct get members => _members ?? MembersStruct();
  set members(MembersStruct? val) => _members = val;

  void updateMembers(Function(MembersStruct) updateFn) {
    updateFn(_members ??= MembersStruct());
  }

  bool hasMembers() => _members != null;

  static ConversationParticipantsStruct fromMap(Map<String, dynamic> data) =>
      ConversationParticipantsStruct(
        members: data['members'] is MembersStruct
            ? data['members']
            : MembersStruct.maybeFromMap(data['members']),
      );

  static ConversationParticipantsStruct? maybeFromMap(dynamic data) =>
      data is Map
          ? ConversationParticipantsStruct.fromMap(data.cast<String, dynamic>())
          : null;

  Map<String, dynamic> toMap() => {
        'members': _members?.toMap(),
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'members': serializeParam(
          _members,
          ParamType.DataStruct,
        ),
      }.withoutNulls;

  static ConversationParticipantsStruct fromSerializableMap(
          Map<String, dynamic> data) =>
      ConversationParticipantsStruct(
        members: deserializeStructParam(
          data['members'],
          ParamType.DataStruct,
          false,
          structBuilder: MembersStruct.fromSerializableMap,
        ),
      );

  @override
  String toString() => 'ConversationParticipantsStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is ConversationParticipantsStruct && members == other.members;
  }

  @override
  int get hashCode => const ListEquality().hash([members]);
}

ConversationParticipantsStruct createConversationParticipantsStruct({
  MembersStruct? members,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    ConversationParticipantsStruct(
      members: members ?? (clearUnsetFields ? MembersStruct() : null),
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

ConversationParticipantsStruct? updateConversationParticipantsStruct(
  ConversationParticipantsStruct? conversationParticipants, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    conversationParticipants
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addConversationParticipantsStructData(
  Map<String, dynamic> firestoreData,
  ConversationParticipantsStruct? conversationParticipants,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (conversationParticipants == null) {
    return;
  }
  if (conversationParticipants.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields = !forFieldValue &&
      conversationParticipants.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final conversationParticipantsData = getConversationParticipantsFirestoreData(
      conversationParticipants, forFieldValue);
  final nestedData =
      conversationParticipantsData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields =
      conversationParticipants.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getConversationParticipantsFirestoreData(
  ConversationParticipantsStruct? conversationParticipants, [
  bool forFieldValue = false,
]) {
  if (conversationParticipants == null) {
    return {};
  }
  final firestoreData = mapToFirestore(conversationParticipants.toMap());

  // Handle nested data for "members" field.
  addMembersStructData(
    firestoreData,
    conversationParticipants.hasMembers()
        ? conversationParticipants.members
        : null,
    'members',
    forFieldValue,
  );

  // Add any Firestore field values
  mapToFirestore(conversationParticipants.firestoreUtilData.fieldValues)
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getConversationParticipantsListFirestoreData(
  List<ConversationParticipantsStruct>? conversationParticipantss,
) =>
    conversationParticipantss
        ?.map((e) => getConversationParticipantsFirestoreData(e, true))
        .toList() ??
    [];
