// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';
import '/backend/schema/enums/enums.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class MessagesStruct extends FFFirebaseStruct {
  MessagesStruct({
    String? id,
    String? conversationId,
    String? senderId,
    String? content,
    String? createdAt,
    String? messageType,
    bool? isRead,
    String? deliveredAt,
    String? seenAt,
    String? replyTo,
    String? receiverId,
    String? imageUrl,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _id = id,
        _conversationId = conversationId,
        _senderId = senderId,
        _content = content,
        _createdAt = createdAt,
        _messageType = messageType,
        _isRead = isRead,
        _deliveredAt = deliveredAt,
        _seenAt = seenAt,
        _replyTo = replyTo,
        _receiverId = receiverId,
        _imageUrl = imageUrl,
        super(firestoreUtilData);

  // "id" field.
  String? _id;
  String get id => _id ?? '';
  set id(String? val) => _id = val;

  bool hasId() => _id != null;

  // "conversation_id" field.
  String? _conversationId;
  String get conversationId => _conversationId ?? '';
  set conversationId(String? val) => _conversationId = val;

  bool hasConversationId() => _conversationId != null;

  // "sender_id" field.
  String? _senderId;
  String get senderId => _senderId ?? '';
  set senderId(String? val) => _senderId = val;

  bool hasSenderId() => _senderId != null;

  // "content" field.
  String? _content;
  String get content => _content ?? '';
  set content(String? val) => _content = val;

  bool hasContent() => _content != null;

  // "created_at" field.
  String? _createdAt;
  String get createdAt => _createdAt ?? '';
  set createdAt(String? val) => _createdAt = val;

  bool hasCreatedAt() => _createdAt != null;

  // "message_type" field.
  String? _messageType;
  String get messageType => _messageType ?? '';
  set messageType(String? val) => _messageType = val;

  bool hasMessageType() => _messageType != null;

  // "is_read" field.
  bool? _isRead;
  bool get isRead => _isRead ?? false;
  set isRead(bool? val) => _isRead = val;

  bool hasIsRead() => _isRead != null;

  // "delivered_at" field.
  String? _deliveredAt;
  String get deliveredAt => _deliveredAt ?? '';
  set deliveredAt(String? val) => _deliveredAt = val;

  bool hasDeliveredAt() => _deliveredAt != null;

  // "seen_at" field.
  String? _seenAt;
  String get seenAt => _seenAt ?? '';
  set seenAt(String? val) => _seenAt = val;

  bool hasSeenAt() => _seenAt != null;

  // "reply_to" field.
  String? _replyTo;
  String get replyTo => _replyTo ?? '';
  set replyTo(String? val) => _replyTo = val;

  bool hasReplyTo() => _replyTo != null;

  // "receiver_id" field.
  String? _receiverId;
  String get receiverId => _receiverId ?? '';
  set receiverId(String? val) => _receiverId = val;

  bool hasReceiverId() => _receiverId != null;

  // "image_url" field.
  String? _imageUrl;
  String get imageUrl => _imageUrl ?? '';
  set imageUrl(String? val) => _imageUrl = val;

  bool hasImageUrl() => _imageUrl != null;

  static MessagesStruct fromMap(Map<String, dynamic> data) => MessagesStruct(
        id: data['id'] as String?,
        conversationId: data['conversation_id'] as String?,
        senderId: data['sender_id'] as String?,
        content: data['content'] as String?,
        createdAt: data['created_at'] as String?,
        messageType: data['message_type'] as String?,
        isRead: data['is_read'] as bool?,
        deliveredAt: data['delivered_at'] as String?,
        seenAt: data['seen_at'] as String?,
        replyTo: data['reply_to'] as String?,
        receiverId: data['receiver_id'] as String?,
        imageUrl: data['image_url'] as String?,
      );

  static MessagesStruct? maybeFromMap(dynamic data) =>
      data is Map ? MessagesStruct.fromMap(data.cast<String, dynamic>()) : null;

  Map<String, dynamic> toMap() => {
        'id': _id,
        'conversation_id': _conversationId,
        'sender_id': _senderId,
        'content': _content,
        'created_at': _createdAt,
        'message_type': _messageType,
        'is_read': _isRead,
        'delivered_at': _deliveredAt,
        'seen_at': _seenAt,
        'reply_to': _replyTo,
        'receiver_id': _receiverId,
        'image_url': _imageUrl,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'id': serializeParam(
          _id,
          ParamType.String,
        ),
        'conversation_id': serializeParam(
          _conversationId,
          ParamType.String,
        ),
        'sender_id': serializeParam(
          _senderId,
          ParamType.String,
        ),
        'content': serializeParam(
          _content,
          ParamType.String,
        ),
        'created_at': serializeParam(
          _createdAt,
          ParamType.String,
        ),
        'message_type': serializeParam(
          _messageType,
          ParamType.String,
        ),
        'is_read': serializeParam(
          _isRead,
          ParamType.bool,
        ),
        'delivered_at': serializeParam(
          _deliveredAt,
          ParamType.String,
        ),
        'seen_at': serializeParam(
          _seenAt,
          ParamType.String,
        ),
        'reply_to': serializeParam(
          _replyTo,
          ParamType.String,
        ),
        'receiver_id': serializeParam(
          _receiverId,
          ParamType.String,
        ),
        'image_url': serializeParam(
          _imageUrl,
          ParamType.String,
        ),
      }.withoutNulls;

  static MessagesStruct fromSerializableMap(Map<String, dynamic> data) =>
      MessagesStruct(
        id: deserializeParam(
          data['id'],
          ParamType.String,
          false,
        ),
        conversationId: deserializeParam(
          data['conversation_id'],
          ParamType.String,
          false,
        ),
        senderId: deserializeParam(
          data['sender_id'],
          ParamType.String,
          false,
        ),
        content: deserializeParam(
          data['content'],
          ParamType.String,
          false,
        ),
        createdAt: deserializeParam(
          data['created_at'],
          ParamType.String,
          false,
        ),
        messageType: deserializeParam(
          data['message_type'],
          ParamType.String,
          false,
        ),
        isRead: deserializeParam(
          data['is_read'],
          ParamType.bool,
          false,
        ),
        deliveredAt: deserializeParam(
          data['delivered_at'],
          ParamType.String,
          false,
        ),
        seenAt: deserializeParam(
          data['seen_at'],
          ParamType.String,
          false,
        ),
        replyTo: deserializeParam(
          data['reply_to'],
          ParamType.String,
          false,
        ),
        receiverId: deserializeParam(
          data['receiver_id'],
          ParamType.String,
          false,
        ),
        imageUrl: deserializeParam(
          data['image_url'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'MessagesStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is MessagesStruct &&
        id == other.id &&
        conversationId == other.conversationId &&
        senderId == other.senderId &&
        content == other.content &&
        createdAt == other.createdAt &&
        messageType == other.messageType &&
        isRead == other.isRead &&
        deliveredAt == other.deliveredAt &&
        seenAt == other.seenAt &&
        replyTo == other.replyTo &&
        receiverId == other.receiverId &&
        imageUrl == other.imageUrl;
  }

  @override
  int get hashCode => const ListEquality().hash([
        id,
        conversationId,
        senderId,
        content,
        createdAt,
        messageType,
        isRead,
        deliveredAt,
        seenAt,
        replyTo,
        receiverId,
        imageUrl
      ]);
}

MessagesStruct createMessagesStruct({
  String? id,
  String? conversationId,
  String? senderId,
  String? content,
  String? createdAt,
  String? messageType,
  bool? isRead,
  String? deliveredAt,
  String? seenAt,
  String? replyTo,
  String? receiverId,
  String? imageUrl,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    MessagesStruct(
      id: id,
      conversationId: conversationId,
      senderId: senderId,
      content: content,
      createdAt: createdAt,
      messageType: messageType,
      isRead: isRead,
      deliveredAt: deliveredAt,
      seenAt: seenAt,
      replyTo: replyTo,
      receiverId: receiverId,
      imageUrl: imageUrl,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

MessagesStruct? updateMessagesStruct(
  MessagesStruct? messages, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    messages
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addMessagesStructData(
  Map<String, dynamic> firestoreData,
  MessagesStruct? messages,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (messages == null) {
    return;
  }
  if (messages.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && messages.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final messagesData = getMessagesFirestoreData(messages, forFieldValue);
  final nestedData = messagesData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = messages.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getMessagesFirestoreData(
  MessagesStruct? messages, [
  bool forFieldValue = false,
]) {
  if (messages == null) {
    return {};
  }
  final firestoreData = mapToFirestore(messages.toMap());

  // Add any Firestore field values
  mapToFirestore(messages.firestoreUtilData.fieldValues)
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getMessagesListFirestoreData(
  List<MessagesStruct>? messagess,
) =>
    messagess?.map((e) => getMessagesFirestoreData(e, true)).toList() ?? [];
