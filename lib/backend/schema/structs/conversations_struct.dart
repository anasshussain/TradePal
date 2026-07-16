// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';
import '/backend/schema/enums/enums.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class ConversationsStruct extends FFFirebaseStruct {
  ConversationsStruct({
    String? id,
    String? lastMessage,
    String? lastMessageAt,
    List<ConversationParticipantsStruct>? conversationParticipants,
    String? jobId,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _id = id,
        _lastMessage = lastMessage,
        _lastMessageAt = lastMessageAt,
        _conversationParticipants = conversationParticipants,
        _jobId = jobId,
        super(firestoreUtilData);

  // "id" field.
  String? _id;
  String get id => _id ?? '';
  set id(String? val) => _id = val;

  bool hasId() => _id != null;

  // "last_message" field.
  String? _lastMessage;
  String get lastMessage => _lastMessage ?? '';
  set lastMessage(String? val) => _lastMessage = val;

  bool hasLastMessage() => _lastMessage != null;

  // "last_message_at" field.
  String? _lastMessageAt;
  String get lastMessageAt => _lastMessageAt ?? '';
  set lastMessageAt(String? val) => _lastMessageAt = val;

  bool hasLastMessageAt() => _lastMessageAt != null;

  // "conversation_participants" field.
  List<ConversationParticipantsStruct>? _conversationParticipants;
  List<ConversationParticipantsStruct> get conversationParticipants =>
      _conversationParticipants ?? const [];
  set conversationParticipants(List<ConversationParticipantsStruct>? val) =>
      _conversationParticipants = val;

  void updateConversationParticipants(
      Function(List<ConversationParticipantsStruct>) updateFn) {
    updateFn(_conversationParticipants ??= []);
  }

  bool hasConversationParticipants() => _conversationParticipants != null;

  // "job_id" field.
  String? _jobId;
  String get jobId => _jobId ?? '';
  set jobId(String? val) => _jobId = val;

  bool hasJobId() => _jobId != null;

  static ConversationsStruct fromMap(Map<String, dynamic> data) =>
      ConversationsStruct(
        id: data['id'] as String?,
        lastMessage: data['last_message'] as String?,
        lastMessageAt: data['last_message_at'] as String?,
        conversationParticipants: getStructList(
          data['conversation_participants'],
          ConversationParticipantsStruct.fromMap,
        ),
        jobId: data['job_id'] as String?,
      );

  static ConversationsStruct? maybeFromMap(dynamic data) => data is Map
      ? ConversationsStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'id': _id,
        'last_message': _lastMessage,
        'last_message_at': _lastMessageAt,
        'conversation_participants':
            _conversationParticipants?.map((e) => e.toMap()).toList(),
        'job_id': _jobId,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'id': serializeParam(
          _id,
          ParamType.String,
        ),
        'last_message': serializeParam(
          _lastMessage,
          ParamType.String,
        ),
        'last_message_at': serializeParam(
          _lastMessageAt,
          ParamType.String,
        ),
        'conversation_participants': serializeParam(
          _conversationParticipants,
          ParamType.DataStruct,
          isList: true,
        ),
        'job_id': serializeParam(
          _jobId,
          ParamType.String,
        ),
      }.withoutNulls;

  static ConversationsStruct fromSerializableMap(Map<String, dynamic> data) =>
      ConversationsStruct(
        id: deserializeParam(
          data['id'],
          ParamType.String,
          false,
        ),
        lastMessage: deserializeParam(
          data['last_message'],
          ParamType.String,
          false,
        ),
        lastMessageAt: deserializeParam(
          data['last_message_at'],
          ParamType.String,
          false,
        ),
        conversationParticipants:
            deserializeStructParam<ConversationParticipantsStruct>(
          data['conversation_participants'],
          ParamType.DataStruct,
          true,
          structBuilder: ConversationParticipantsStruct.fromSerializableMap,
        ),
        jobId: deserializeParam(
          data['job_id'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'ConversationsStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    const listEquality = ListEquality();
    return other is ConversationsStruct &&
        id == other.id &&
        lastMessage == other.lastMessage &&
        lastMessageAt == other.lastMessageAt &&
        listEquality.equals(
            conversationParticipants, other.conversationParticipants) &&
        jobId == other.jobId;
  }

  @override
  int get hashCode => const ListEquality()
      .hash([id, lastMessage, lastMessageAt, conversationParticipants, jobId]);
}

ConversationsStruct createConversationsStruct({
  String? id,
  String? lastMessage,
  String? lastMessageAt,
  String? jobId,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    ConversationsStruct(
      id: id,
      lastMessage: lastMessage,
      lastMessageAt: lastMessageAt,
      jobId: jobId,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

ConversationsStruct? updateConversationsStruct(
  ConversationsStruct? conversations, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    conversations
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addConversationsStructData(
  Map<String, dynamic> firestoreData,
  ConversationsStruct? conversations,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (conversations == null) {
    return;
  }
  if (conversations.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && conversations.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final conversationsData =
      getConversationsFirestoreData(conversations, forFieldValue);
  final nestedData =
      conversationsData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = conversations.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getConversationsFirestoreData(
  ConversationsStruct? conversations, [
  bool forFieldValue = false,
]) {
  if (conversations == null) {
    return {};
  }
  final firestoreData = mapToFirestore(conversations.toMap());

  // Add any Firestore field values
  mapToFirestore(conversations.firestoreUtilData.fieldValues)
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getConversationsListFirestoreData(
  List<ConversationsStruct>? conversationss,
) =>
    conversationss
        ?.map((e) => getConversationsFirestoreData(e, true))
        .toList() ??
    [];
