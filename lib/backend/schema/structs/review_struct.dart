// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';
import '/backend/schema/enums/enums.dart';

import 'index.dart';
import '/core/util.dart';

class ReviewStruct extends AppFirebaseStruct {
  ReviewStruct({
    String? id,
    String? comment,
    String? createdAt,
    List<String>? imageUrls,
    int? overallRating,
    int? qualityRating,
    int? communicationRating,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _id = id,
        _comment = comment,
        _createdAt = createdAt,
        _imageUrls = imageUrls,
        _overallRating = overallRating,
        _qualityRating = qualityRating,
        _communicationRating = communicationRating,
        super(firestoreUtilData);

  // "id" field.
  String? _id;
  String get id => _id ?? '';
  set id(String? val) => _id = val;

  bool hasId() => _id != null;

  // "comment" field.
  String? _comment;
  String get comment => _comment ?? '';
  set comment(String? val) => _comment = val;

  bool hasComment() => _comment != null;

  // "created_at" field.
  String? _createdAt;
  String get createdAt => _createdAt ?? '';
  set createdAt(String? val) => _createdAt = val;

  bool hasCreatedAt() => _createdAt != null;

  // "image_urls" field.
  List<String>? _imageUrls;
  List<String> get imageUrls => _imageUrls ?? const [];
  set imageUrls(List<String>? val) => _imageUrls = val;

  void updateImageUrls(Function(List<String>) updateFn) {
    updateFn(_imageUrls ??= []);
  }

  bool hasImageUrls() => _imageUrls != null;

  // "overall_rating" field.
  int? _overallRating;
  int get overallRating => _overallRating ?? 0;
  set overallRating(int? val) => _overallRating = val;

  void incrementOverallRating(int amount) =>
      overallRating = overallRating + amount;

  bool hasOverallRating() => _overallRating != null;

  // "quality_rating" field.
  int? _qualityRating;
  int get qualityRating => _qualityRating ?? 0;
  set qualityRating(int? val) => _qualityRating = val;

  void incrementQualityRating(int amount) =>
      qualityRating = qualityRating + amount;

  bool hasQualityRating() => _qualityRating != null;

  // "communication_rating" field.
  int? _communicationRating;
  int get communicationRating => _communicationRating ?? 0;
  set communicationRating(int? val) => _communicationRating = val;

  void incrementCommunicationRating(int amount) =>
      communicationRating = communicationRating + amount;

  bool hasCommunicationRating() => _communicationRating != null;

  static ReviewStruct fromMap(Map<String, dynamic> data) => ReviewStruct(
        id: data['id'] as String?,
        comment: data['comment'] as String?,
        createdAt: data['created_at'] as String?,
        imageUrls: getDataList(data['image_urls']),
        overallRating: castToType<int>(data['overall_rating']),
        qualityRating: castToType<int>(data['quality_rating']),
        communicationRating: castToType<int>(data['communication_rating']),
      );

  static ReviewStruct? maybeFromMap(dynamic data) =>
      data is Map ? ReviewStruct.fromMap(data.cast<String, dynamic>()) : null;

  Map<String, dynamic> toMap() => {
        'id': _id,
        'comment': _comment,
        'created_at': _createdAt,
        'image_urls': _imageUrls,
        'overall_rating': _overallRating,
        'quality_rating': _qualityRating,
        'communication_rating': _communicationRating,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'id': serializeParam(
          _id,
          ParamType.String,
        ),
        'comment': serializeParam(
          _comment,
          ParamType.String,
        ),
        'created_at': serializeParam(
          _createdAt,
          ParamType.String,
        ),
        'image_urls': serializeParam(
          _imageUrls,
          ParamType.String,
          isList: true,
        ),
        'overall_rating': serializeParam(
          _overallRating,
          ParamType.int,
        ),
        'quality_rating': serializeParam(
          _qualityRating,
          ParamType.int,
        ),
        'communication_rating': serializeParam(
          _communicationRating,
          ParamType.int,
        ),
      }.withoutNulls;

  static ReviewStruct fromSerializableMap(Map<String, dynamic> data) =>
      ReviewStruct(
        id: deserializeParam(
          data['id'],
          ParamType.String,
          false,
        ),
        comment: deserializeParam(
          data['comment'],
          ParamType.String,
          false,
        ),
        createdAt: deserializeParam(
          data['created_at'],
          ParamType.String,
          false,
        ),
        imageUrls: deserializeParam<String>(
          data['image_urls'],
          ParamType.String,
          true,
        ),
        overallRating: deserializeParam(
          data['overall_rating'],
          ParamType.int,
          false,
        ),
        qualityRating: deserializeParam(
          data['quality_rating'],
          ParamType.int,
          false,
        ),
        communicationRating: deserializeParam(
          data['communication_rating'],
          ParamType.int,
          false,
        ),
      );

  @override
  String toString() => 'ReviewStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    const listEquality = ListEquality();
    return other is ReviewStruct &&
        id == other.id &&
        comment == other.comment &&
        createdAt == other.createdAt &&
        listEquality.equals(imageUrls, other.imageUrls) &&
        overallRating == other.overallRating &&
        qualityRating == other.qualityRating &&
        communicationRating == other.communicationRating;
  }

  @override
  int get hashCode => const ListEquality().hash([
        id,
        comment,
        createdAt,
        imageUrls,
        overallRating,
        qualityRating,
        communicationRating
      ]);
}

ReviewStruct createReviewStruct({
  String? id,
  String? comment,
  String? createdAt,
  int? overallRating,
  int? qualityRating,
  int? communicationRating,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    ReviewStruct(
      id: id,
      comment: comment,
      createdAt: createdAt,
      overallRating: overallRating,
      qualityRating: qualityRating,
      communicationRating: communicationRating,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

ReviewStruct? updateReviewStruct(
  ReviewStruct? review, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    review
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addReviewStructData(
  Map<String, dynamic> firestoreData,
  ReviewStruct? review,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (review == null) {
    return;
  }
  if (review.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && review.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final reviewData = getReviewFirestoreData(review, forFieldValue);
  final nestedData = reviewData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = review.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getReviewFirestoreData(
  ReviewStruct? review, [
  bool forFieldValue = false,
]) {
  if (review == null) {
    return {};
  }
  final firestoreData = mapToFirestore(review.toMap());

  // Add any Firestore field values
  mapToFirestore(review.firestoreUtilData.fieldValues)
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getReviewListFirestoreData(
  List<ReviewStruct>? reviews,
) =>
    reviews?.map((e) => getReviewFirestoreData(e, true)).toList() ?? [];
