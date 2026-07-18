import 'dart:async';

import 'package:collection/collection.dart';

import '/models/util/firestore_util.dart';
import '/models/util/schema_util.dart';
import '/utils/enums/enums.dart';

import '/models/index.dart';
import '/utils/util.dart';

class UserInsuranceRecord extends FirestoreRecord {
  UserInsuranceRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "insurance_provider" field.
  String? _insuranceProvider;
  String get insuranceProvider => _insuranceProvider ?? '';
  bool hasInsuranceProvider() => _insuranceProvider != null;

  // "policy_number" field.
  String? _policyNumber;
  String get policyNumber => _policyNumber ?? '';
  bool hasPolicyNumber() => _policyNumber != null;

  // "user_ref" field.
  DocumentReference? _userRef;
  DocumentReference? get userRef => _userRef;
  bool hasUserRef() => _userRef != null;

  void _initializeFields() {
    _insuranceProvider = snapshotData['insurance_provider'] as String?;
    _policyNumber = snapshotData['policy_number'] as String?;
    _userRef = snapshotData['user_ref'] as DocumentReference?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('user_insurance');

  static Stream<UserInsuranceRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => UserInsuranceRecord.fromSnapshot(s));

  static Future<UserInsuranceRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => UserInsuranceRecord.fromSnapshot(s));

  static UserInsuranceRecord fromSnapshot(DocumentSnapshot snapshot) =>
      UserInsuranceRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static UserInsuranceRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      UserInsuranceRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'UserInsuranceRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is UserInsuranceRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createUserInsuranceRecordData({
  String? insuranceProvider,
  String? policyNumber,
  DocumentReference? userRef,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'insurance_provider': insuranceProvider,
      'policy_number': policyNumber,
      'user_ref': userRef,
    }.withoutNulls,
  );

  return firestoreData;
}

class UserInsuranceRecordDocumentEquality
    implements Equality<UserInsuranceRecord> {
  const UserInsuranceRecordDocumentEquality();

  @override
  bool equals(UserInsuranceRecord? e1, UserInsuranceRecord? e2) {
    return e1?.insuranceProvider == e2?.insuranceProvider &&
        e1?.policyNumber == e2?.policyNumber &&
        e1?.userRef == e2?.userRef;
  }

  @override
  int hash(UserInsuranceRecord? e) => const ListEquality()
      .hash([e?.insuranceProvider, e?.policyNumber, e?.userRef]);

  @override
  bool isValidKey(Object? o) => o is UserInsuranceRecord;
}
