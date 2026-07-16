// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';
import '/backend/schema/enums/enums.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class ConversationStruct extends FFFirebaseStruct {
  ConversationStruct({
    String? conversationId,
    ConversationsStruct? conversations,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _conversationId = conversationId,
        _conversations = conversations,
        super(firestoreUtilData);

  // "conversation_id" field.
  String? _conversationId;
  String get conversationId => _conversationId ?? '';
  set conversationId(String? val) => _conversationId = val;

  bool hasConversationId() => _conversationId != null;

  // "conversations" field.
  ConversationsStruct? _conversations;
  ConversationsStruct get conversations =>
      _conversations ?? ConversationsStruct();
  set conversations(ConversationsStruct? val) => _conversations = val;

  void updateConversations(Function(ConversationsStruct) updateFn) {
    updateFn(_conversations ??= ConversationsStruct());
  }

  bool hasConversations() => _conversations != null;

  static ConversationStruct fromMap(Map<String, dynamic> data) =>
      ConversationStruct(
        conversationId: data['conversation_id'] as String?,
        conversations: data['conversations'] is ConversationsStruct
            ? data['conversations']
            : ConversationsStruct.maybeFromMap(data['conversations']),
      );

  static ConversationStruct? maybeFromMap(dynamic data) => data is Map
      ? ConversationStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'conversation_id': _conversationId,
        'conversations': _conversations?.toMap(),
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'conversation_id': serializeParam(
          _conversationId,
          ParamType.String,
        ),
        'conversations': serializeParam(
          _conversations,
          ParamType.DataStruct,
        ),
      }.withoutNulls;

  static ConversationStruct fromSerializableMap(Map<String, dynamic> data) =>
      ConversationStruct(
        conversationId: deserializeParam(
          data['conversation_id'],
          ParamType.String,
          false,
        ),
        conversations: deserializeStructParam(
          data['conversations'],
          ParamType.DataStruct,
          false,
          structBuilder: ConversationsStruct.fromSerializableMap,
        ),
      );

  @override
  String toString() => 'ConversationStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is ConversationStruct &&
        conversationId == other.conversationId &&
        conversations == other.conversations;
  }

  @override
  int get hashCode =>
      const ListEquality().hash([conversationId, conversations]);
}

ConversationStruct createConversationStruct({
  String? conversationId,
  ConversationsStruct? conversations,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    ConversationStruct(
      conversationId: conversationId,
      conversations:
          conversations ?? (clearUnsetFields ? ConversationsStruct() : null),
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

ConversationStruct? updateConversationStruct(
  ConversationStruct? conversation, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    conversation
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addConversationStructData(
  Map<String, dynamic> firestoreData,
  ConversationStruct? conversation,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (conversation == null) {
    return;
  }
  if (conversation.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && conversation.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final conversationData =
      getConversationFirestoreData(conversation, forFieldValue);
  final nestedData =
      conversationData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = conversation.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getConversationFirestoreData(
  ConversationStruct? conversation, [
  bool forFieldValue = false,
]) {
  if (conversation == null) {
    return {};
  }
  final firestoreData = mapToFirestore(conversation.toMap());

  // Handle nested data for "conversations" field.
  addConversationsStructData(
    firestoreData,
    conversation.hasConversations() ? conversation.conversations : null,
    'conversations',
    forFieldValue,
  );

  // Add any Firestore field values
  mapToFirestore(conversation.firestoreUtilData.fieldValues)
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getConversationListFirestoreData(
  List<ConversationStruct>? conversations,
) =>
    conversations?.map((e) => getConversationFirestoreData(e, true)).toList() ??
    [];
