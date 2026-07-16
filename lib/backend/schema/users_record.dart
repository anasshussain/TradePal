import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';
import '/backend/schema/enums/enums.dart';

import 'index.dart';
import '/core/util.dart';

class UsersRecord extends FirestoreRecord {
  UsersRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "email" field.
  String? _email;

  /// email
  String get email => _email ?? '';
  bool hasEmail() => _email != null;

  // "display_name" field.
  String? _displayName;
  String get displayName => _displayName ?? '';
  bool hasDisplayName() => _displayName != null;

  // "uid" field.
  String? _uid;
  String get uid => _uid ?? '';
  bool hasUid() => _uid != null;

  // "phone_number" field.
  String? _phoneNumber;
  String get phoneNumber => _phoneNumber ?? '';
  bool hasPhoneNumber() => _phoneNumber != null;

  // "photo_url" field.
  String? _photoUrl;
  String get photoUrl => _photoUrl ?? '';
  bool hasPhotoUrl() => _photoUrl != null;

  // "created_time" field.
  DateTime? _createdTime;
  DateTime? get createdTime => _createdTime;
  bool hasCreatedTime() => _createdTime != null;

  // "status" field.
  Status? _status;
  Status? get status => _status;
  bool hasStatus() => _status != null;

  // "system_role" field.
  SystemRole? _systemRole;
  SystemRole? get systemRole => _systemRole;
  bool hasSystemRole() => _systemRole != null;

  // "user_role" field.
  UserRole? _userRole;
  UserRole? get userRole => _userRole;
  bool hasUserRole() => _userRole != null;

  // "qualifications" field.
  String? _qualifications;
  String get qualifications => _qualifications ?? '';
  bool hasQualifications() => _qualifications != null;

  // "insurance_info" field.
  DocumentReference? _insuranceInfo;
  DocumentReference? get insuranceInfo => _insuranceInfo;
  bool hasInsuranceInfo() => _insuranceInfo != null;

  // "address" field.
  String? _address;
  String get address => _address ?? '';
  bool hasAddress() => _address != null;

  // "about" field.
  String? _about;
  String get about => _about ?? '';
  bool hasAbout() => _about != null;

  // "years_in_business" field.
  int? _yearsInBusiness;
  int get yearsInBusiness => _yearsInBusiness ?? 0;
  bool hasYearsInBusiness() => _yearsInBusiness != null;

  // "trade" field.
  String? _trade;
  String get trade => _trade ?? '';
  bool hasTrade() => _trade != null;

  void _initializeFields() {
    _email = snapshotData['email'] as String?;
    _displayName = snapshotData['display_name'] as String?;
    _uid = snapshotData['uid'] as String?;
    _phoneNumber = snapshotData['phone_number'] as String?;
    _photoUrl = snapshotData['photo_url'] as String?;
    _createdTime = snapshotData['created_time'] as DateTime?;
    _status = snapshotData['status'] is Status
        ? snapshotData['status']
        : deserializeEnum<Status>(snapshotData['status']);
    _systemRole = snapshotData['system_role'] is SystemRole
        ? snapshotData['system_role']
        : deserializeEnum<SystemRole>(snapshotData['system_role']);
    _userRole = snapshotData['user_role'] is UserRole
        ? snapshotData['user_role']
        : deserializeEnum<UserRole>(snapshotData['user_role']);
    _qualifications = snapshotData['qualifications'] as String?;
    _insuranceInfo = snapshotData['insurance_info'] as DocumentReference?;
    _address = snapshotData['address'] as String?;
    _about = snapshotData['about'] as String?;
    _yearsInBusiness = castToType<int>(snapshotData['years_in_business']);
    _trade = snapshotData['trade'] as String?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('Users');

  static Stream<UsersRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => UsersRecord.fromSnapshot(s));

  static Future<UsersRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => UsersRecord.fromSnapshot(s));

  static UsersRecord fromSnapshot(DocumentSnapshot snapshot) => UsersRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static UsersRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      UsersRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'UsersRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is UsersRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createUsersRecordData({
  String? email,
  String? displayName,
  String? uid,
  String? phoneNumber,
  String? photoUrl,
  DateTime? createdTime,
  Status? status,
  SystemRole? systemRole,
  UserRole? userRole,
  String? qualifications,
  DocumentReference? insuranceInfo,
  String? address,
  String? about,
  int? yearsInBusiness,
  String? trade,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'email': email,
      'display_name': displayName,
      'uid': uid,
      'phone_number': phoneNumber,
      'photo_url': photoUrl,
      'created_time': createdTime,
      'status': status,
      'system_role': systemRole,
      'user_role': userRole,
      'qualifications': qualifications,
      'insurance_info': insuranceInfo,
      'address': address,
      'about': about,
      'years_in_business': yearsInBusiness,
      'trade': trade,
    }.withoutNulls,
  );

  return firestoreData;
}

class UsersRecordDocumentEquality implements Equality<UsersRecord> {
  const UsersRecordDocumentEquality();

  @override
  bool equals(UsersRecord? e1, UsersRecord? e2) {
    return e1?.email == e2?.email &&
        e1?.displayName == e2?.displayName &&
        e1?.uid == e2?.uid &&
        e1?.phoneNumber == e2?.phoneNumber &&
        e1?.photoUrl == e2?.photoUrl &&
        e1?.createdTime == e2?.createdTime &&
        e1?.status == e2?.status &&
        e1?.systemRole == e2?.systemRole &&
        e1?.userRole == e2?.userRole &&
        e1?.qualifications == e2?.qualifications &&
        e1?.insuranceInfo == e2?.insuranceInfo &&
        e1?.address == e2?.address &&
        e1?.about == e2?.about &&
        e1?.yearsInBusiness == e2?.yearsInBusiness &&
        e1?.trade == e2?.trade;
  }

  @override
  int hash(UsersRecord? e) => const ListEquality().hash([
        e?.email,
        e?.displayName,
        e?.uid,
        e?.phoneNumber,
        e?.photoUrl,
        e?.createdTime,
        e?.status,
        e?.systemRole,
        e?.userRole,
        e?.qualifications,
        e?.insuranceInfo,
        e?.address,
        e?.about,
        e?.yearsInBusiness,
        e?.trade
      ]);

  @override
  bool isValidKey(Object? o) => o is UsersRecord;
}
