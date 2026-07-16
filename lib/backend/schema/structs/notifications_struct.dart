// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';
import '/backend/schema/enums/enums.dart';

import 'index.dart';
import '/core/util.dart';

class NotificationsStruct extends AppFirebaseStruct {
  NotificationsStruct({
    String? id,
    String? userId,
    String? type,
    String? referenceId,
    bool? isRead,
    String? createdAt,
    String? message,
    String? title,
    ExtraDataStruct? extraData,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _id = id,
        _userId = userId,
        _type = type,
        _referenceId = referenceId,
        _isRead = isRead,
        _createdAt = createdAt,
        _message = message,
        _title = title,
        _extraData = extraData,
        super(firestoreUtilData);

  // "id" field.
  String? _id;
  String get id => _id ?? '';
  set id(String? val) => _id = val;

  bool hasId() => _id != null;

  // "user_id" field.
  String? _userId;
  String get userId => _userId ?? '';
  set userId(String? val) => _userId = val;

  bool hasUserId() => _userId != null;

  // "type" field.
  String? _type;
  String get type => _type ?? '';
  set type(String? val) => _type = val;

  bool hasType() => _type != null;

  // "reference_id" field.
  String? _referenceId;
  String get referenceId => _referenceId ?? '';
  set referenceId(String? val) => _referenceId = val;

  bool hasReferenceId() => _referenceId != null;

  // "is_read" field.
  bool? _isRead;
  bool get isRead => _isRead ?? false;
  set isRead(bool? val) => _isRead = val;

  bool hasIsRead() => _isRead != null;

  // "created_at" field.
  String? _createdAt;
  String get createdAt => _createdAt ?? '';
  set createdAt(String? val) => _createdAt = val;

  bool hasCreatedAt() => _createdAt != null;

  // "message" field.
  String? _message;
  String get message => _message ?? '';
  set message(String? val) => _message = val;

  bool hasMessage() => _message != null;

  // "title" field.
  String? _title;
  String get title => _title ?? '';
  set title(String? val) => _title = val;

  bool hasTitle() => _title != null;

  // "extra_data" field.
  ExtraDataStruct? _extraData;
  ExtraDataStruct get extraData => _extraData ?? ExtraDataStruct();
  set extraData(ExtraDataStruct? val) => _extraData = val;

  void updateExtraData(Function(ExtraDataStruct) updateFn) {
    updateFn(_extraData ??= ExtraDataStruct());
  }

  bool hasExtraData() => _extraData != null;

  static NotificationsStruct fromMap(Map<String, dynamic> data) =>
      NotificationsStruct(
        id: data['id'] as String?,
        userId: data['user_id'] as String?,
        type: data['type'] as String?,
        referenceId: data['reference_id'] as String?,
        isRead: data['is_read'] as bool?,
        createdAt: data['created_at'] as String?,
        message: data['message'] as String?,
        title: data['title'] as String?,
        extraData: data['extra_data'] is ExtraDataStruct
            ? data['extra_data']
            : ExtraDataStruct.maybeFromMap(data['extra_data']),
      );

  static NotificationsStruct? maybeFromMap(dynamic data) => data is Map
      ? NotificationsStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'id': _id,
        'user_id': _userId,
        'type': _type,
        'reference_id': _referenceId,
        'is_read': _isRead,
        'created_at': _createdAt,
        'message': _message,
        'title': _title,
        'extra_data': _extraData?.toMap(),
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'id': serializeParam(
          _id,
          ParamType.String,
        ),
        'user_id': serializeParam(
          _userId,
          ParamType.String,
        ),
        'type': serializeParam(
          _type,
          ParamType.String,
        ),
        'reference_id': serializeParam(
          _referenceId,
          ParamType.String,
        ),
        'is_read': serializeParam(
          _isRead,
          ParamType.bool,
        ),
        'created_at': serializeParam(
          _createdAt,
          ParamType.String,
        ),
        'message': serializeParam(
          _message,
          ParamType.String,
        ),
        'title': serializeParam(
          _title,
          ParamType.String,
        ),
        'extra_data': serializeParam(
          _extraData,
          ParamType.DataStruct,
        ),
      }.withoutNulls;

  static NotificationsStruct fromSerializableMap(Map<String, dynamic> data) =>
      NotificationsStruct(
        id: deserializeParam(
          data['id'],
          ParamType.String,
          false,
        ),
        userId: deserializeParam(
          data['user_id'],
          ParamType.String,
          false,
        ),
        type: deserializeParam(
          data['type'],
          ParamType.String,
          false,
        ),
        referenceId: deserializeParam(
          data['reference_id'],
          ParamType.String,
          false,
        ),
        isRead: deserializeParam(
          data['is_read'],
          ParamType.bool,
          false,
        ),
        createdAt: deserializeParam(
          data['created_at'],
          ParamType.String,
          false,
        ),
        message: deserializeParam(
          data['message'],
          ParamType.String,
          false,
        ),
        title: deserializeParam(
          data['title'],
          ParamType.String,
          false,
        ),
        extraData: deserializeStructParam(
          data['extra_data'],
          ParamType.DataStruct,
          false,
          structBuilder: ExtraDataStruct.fromSerializableMap,
        ),
      );

  @override
  String toString() => 'NotificationsStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is NotificationsStruct &&
        id == other.id &&
        userId == other.userId &&
        type == other.type &&
        referenceId == other.referenceId &&
        isRead == other.isRead &&
        createdAt == other.createdAt &&
        message == other.message &&
        title == other.title &&
        extraData == other.extraData;
  }

  @override
  int get hashCode => const ListEquality().hash([
        id,
        userId,
        type,
        referenceId,
        isRead,
        createdAt,
        message,
        title,
        extraData
      ]);
}

NotificationsStruct createNotificationsStruct({
  String? id,
  String? userId,
  String? type,
  String? referenceId,
  bool? isRead,
  String? createdAt,
  String? message,
  String? title,
  ExtraDataStruct? extraData,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    NotificationsStruct(
      id: id,
      userId: userId,
      type: type,
      referenceId: referenceId,
      isRead: isRead,
      createdAt: createdAt,
      message: message,
      title: title,
      extraData: extraData ?? (clearUnsetFields ? ExtraDataStruct() : null),
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

NotificationsStruct? updateNotificationsStruct(
  NotificationsStruct? notifications, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    notifications
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addNotificationsStructData(
  Map<String, dynamic> firestoreData,
  NotificationsStruct? notifications,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (notifications == null) {
    return;
  }
  if (notifications.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && notifications.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final notificationsData =
      getNotificationsFirestoreData(notifications, forFieldValue);
  final nestedData =
      notificationsData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = notifications.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getNotificationsFirestoreData(
  NotificationsStruct? notifications, [
  bool forFieldValue = false,
]) {
  if (notifications == null) {
    return {};
  }
  final firestoreData = mapToFirestore(notifications.toMap());

  // Handle nested data for "extra_data" field.
  addExtraDataStructData(
    firestoreData,
    notifications.hasExtraData() ? notifications.extraData : null,
    'extra_data',
    forFieldValue,
  );

  // Add any Firestore field values
  mapToFirestore(notifications.firestoreUtilData.fieldValues)
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getNotificationsListFirestoreData(
  List<NotificationsStruct>? notificationss,
) =>
    notificationss
        ?.map((e) => getNotificationsFirestoreData(e, true))
        .toList() ??
    [];
