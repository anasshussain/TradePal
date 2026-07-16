// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';
import '/backend/schema/enums/enums.dart';

import 'index.dart';
import '/core/util.dart';

class MetadataStruct extends AppFirebaseStruct {
  MetadataStruct({
    int? id,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _id = id,
        super(firestoreUtilData);

  // "id" field.
  int? _id;
  int get id => _id ?? 0;
  set id(int? val) => _id = val;

  void incrementId(int amount) => id = id + amount;

  bool hasId() => _id != null;

  static MetadataStruct fromMap(Map<String, dynamic> data) => MetadataStruct(
        id: castToType<int>(data['id']),
      );

  static MetadataStruct? maybeFromMap(dynamic data) =>
      data is Map ? MetadataStruct.fromMap(data.cast<String, dynamic>()) : null;

  Map<String, dynamic> toMap() => {
        'id': _id,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'id': serializeParam(
          _id,
          ParamType.int,
        ),
      }.withoutNulls;

  static MetadataStruct fromSerializableMap(Map<String, dynamic> data) =>
      MetadataStruct(
        id: deserializeParam(
          data['id'],
          ParamType.int,
          false,
        ),
      );

  @override
  String toString() => 'MetadataStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is MetadataStruct && id == other.id;
  }

  @override
  int get hashCode => const ListEquality().hash([id]);
}

MetadataStruct createMetadataStruct({
  int? id,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    MetadataStruct(
      id: id,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

MetadataStruct? updateMetadataStruct(
  MetadataStruct? metadata, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    metadata
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addMetadataStructData(
  Map<String, dynamic> firestoreData,
  MetadataStruct? metadata,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (metadata == null) {
    return;
  }
  if (metadata.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && metadata.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final metadataData = getMetadataFirestoreData(metadata, forFieldValue);
  final nestedData = metadataData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = metadata.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getMetadataFirestoreData(
  MetadataStruct? metadata, [
  bool forFieldValue = false,
]) {
  if (metadata == null) {
    return {};
  }
  final firestoreData = mapToFirestore(metadata.toMap());

  // Add any Firestore field values
  mapToFirestore(metadata.firestoreUtilData.fieldValues)
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getMetadataListFirestoreData(
  List<MetadataStruct>? metadatas,
) =>
    metadatas?.map((e) => getMetadataFirestoreData(e, true)).toList() ?? [];
