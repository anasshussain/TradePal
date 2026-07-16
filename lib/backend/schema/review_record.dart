import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';
import '/backend/schema/enums/enums.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class ReviewRecord extends FirestoreRecord {
  ReviewRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "job_ref" field.
  DocumentReference? _jobRef;
  DocumentReference? get jobRef => _jobRef;
  bool hasJobRef() => _jobRef != null;

  // "rating" field.
  double? _rating;
  double get rating => _rating ?? 0.0;
  bool hasRating() => _rating != null;

  // "criteria" field.
  CriteriaStruct? _criteria;
  CriteriaStruct get criteria => _criteria ?? CriteriaStruct();
  bool hasCriteria() => _criteria != null;

  // "created_At" field.
  DateTime? _createdAt;
  DateTime? get createdAt => _createdAt;
  bool hasCreatedAt() => _createdAt != null;

  // "review_text" field.
  String? _reviewText;
  String get reviewText => _reviewText ?? '';
  bool hasReviewText() => _reviewText != null;

  // "is_public" field.
  bool? _isPublic;
  bool get isPublic => _isPublic ?? false;
  bool hasIsPublic() => _isPublic != null;

  // "status" field.
  Status? _status;
  Status? get status => _status;
  bool hasStatus() => _status != null;

  void _initializeFields() {
    _jobRef = snapshotData['job_ref'] as DocumentReference?;
    _rating = castToType<double>(snapshotData['rating']);
    _criteria = snapshotData['criteria'] is CriteriaStruct
        ? snapshotData['criteria']
        : CriteriaStruct.maybeFromMap(snapshotData['criteria']);
    _createdAt = snapshotData['created_At'] as DateTime?;
    _reviewText = snapshotData['review_text'] as String?;
    _isPublic = snapshotData['is_public'] as bool?;
    _status = snapshotData['status'] is Status
        ? snapshotData['status']
        : deserializeEnum<Status>(snapshotData['status']);
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('review');

  static Stream<ReviewRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => ReviewRecord.fromSnapshot(s));

  static Future<ReviewRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => ReviewRecord.fromSnapshot(s));

  static ReviewRecord fromSnapshot(DocumentSnapshot snapshot) => ReviewRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static ReviewRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      ReviewRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'ReviewRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is ReviewRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createReviewRecordData({
  DocumentReference? jobRef,
  double? rating,
  CriteriaStruct? criteria,
  DateTime? createdAt,
  String? reviewText,
  bool? isPublic,
  Status? status,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'job_ref': jobRef,
      'rating': rating,
      'criteria': CriteriaStruct().toMap(),
      'created_At': createdAt,
      'review_text': reviewText,
      'is_public': isPublic,
      'status': status,
    }.withoutNulls,
  );

  // Handle nested data for "criteria" field.
  addCriteriaStructData(firestoreData, criteria, 'criteria');

  return firestoreData;
}

class ReviewRecordDocumentEquality implements Equality<ReviewRecord> {
  const ReviewRecordDocumentEquality();

  @override
  bool equals(ReviewRecord? e1, ReviewRecord? e2) {
    return e1?.jobRef == e2?.jobRef &&
        e1?.rating == e2?.rating &&
        e1?.criteria == e2?.criteria &&
        e1?.createdAt == e2?.createdAt &&
        e1?.reviewText == e2?.reviewText &&
        e1?.isPublic == e2?.isPublic &&
        e1?.status == e2?.status;
  }

  @override
  int hash(ReviewRecord? e) => const ListEquality().hash([
        e?.jobRef,
        e?.rating,
        e?.criteria,
        e?.createdAt,
        e?.reviewText,
        e?.isPublic,
        e?.status
      ]);

  @override
  bool isValidKey(Object? o) => o is ReviewRecord;
}
