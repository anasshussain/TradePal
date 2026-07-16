// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';
import '/backend/schema/enums/enums.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class TradespersonStruct extends FFFirebaseStruct {
  TradespersonStruct({
    String? id,
    String? name,
    String? deviceToken,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _id = id,
        _name = name,
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

  // "device_token" field.
  String? _deviceToken;
  String get deviceToken => _deviceToken ?? '';
  set deviceToken(String? val) => _deviceToken = val;

  bool hasDeviceToken() => _deviceToken != null;

  static TradespersonStruct fromMap(Map<String, dynamic> data) =>
      TradespersonStruct(
        id: data['id'] as String?,
        name: data['name'] as String?,
        deviceToken: data['device_token'] as String?,
      );

  static TradespersonStruct? maybeFromMap(dynamic data) => data is Map
      ? TradespersonStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'id': _id,
        'name': _name,
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
        'device_token': serializeParam(
          _deviceToken,
          ParamType.String,
        ),
      }.withoutNulls;

  static TradespersonStruct fromSerializableMap(Map<String, dynamic> data) =>
      TradespersonStruct(
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
        deviceToken: deserializeParam(
          data['device_token'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'TradespersonStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is TradespersonStruct &&
        id == other.id &&
        name == other.name &&
        deviceToken == other.deviceToken;
  }

  @override
  int get hashCode => const ListEquality().hash([id, name, deviceToken]);
}

TradespersonStruct createTradespersonStruct({
  String? id,
  String? name,
  String? deviceToken,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    TradespersonStruct(
      id: id,
      name: name,
      deviceToken: deviceToken,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

TradespersonStruct? updateTradespersonStruct(
  TradespersonStruct? tradesperson, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    tradesperson
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addTradespersonStructData(
  Map<String, dynamic> firestoreData,
  TradespersonStruct? tradesperson,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (tradesperson == null) {
    return;
  }
  if (tradesperson.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && tradesperson.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final tradespersonData =
      getTradespersonFirestoreData(tradesperson, forFieldValue);
  final nestedData =
      tradespersonData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = tradesperson.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getTradespersonFirestoreData(
  TradespersonStruct? tradesperson, [
  bool forFieldValue = false,
]) {
  if (tradesperson == null) {
    return {};
  }
  final firestoreData = mapToFirestore(tradesperson.toMap());

  // Add any Firestore field values
  mapToFirestore(tradesperson.firestoreUtilData.fieldValues)
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getTradespersonListFirestoreData(
  List<TradespersonStruct>? tradespersons,
) =>
    tradespersons?.map((e) => getTradespersonFirestoreData(e, true)).toList() ??
    [];
