// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';
import '/backend/schema/enums/enums.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class UserStruct extends FFFirebaseStruct {
  UserStruct({
    String? id,
    String? name,
    String? email,
    String? accountStatus,
    bool? emailVerified,
    String? avatarUrl,
    bool? insuranceVerified,
    String? createdAt,
    String? insuranceExpiry,
    String? about,
    String? yearsExperience,
    String? qualifications,
    String? userKey,
    int? onboardingStep,
    int? userRole,
    String? phone,
    String? street,
    String? zipcode,
    String? streetaddress,
    String? insuranceCompany,
    String? registrationNumber,
    String? serviceArea,
    String? profession,
    String? insuranceAmount,
    List<String>? skills,
    String? deviceToken,
    int? totalReviews,
    int? averageRating,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _id = id,
        _name = name,
        _email = email,
        _accountStatus = accountStatus,
        _emailVerified = emailVerified,
        _avatarUrl = avatarUrl,
        _insuranceVerified = insuranceVerified,
        _createdAt = createdAt,
        _insuranceExpiry = insuranceExpiry,
        _about = about,
        _yearsExperience = yearsExperience,
        _qualifications = qualifications,
        _userKey = userKey,
        _onboardingStep = onboardingStep,
        _userRole = userRole,
        _phone = phone,
        _street = street,
        _zipcode = zipcode,
        _streetaddress = streetaddress,
        _insuranceCompany = insuranceCompany,
        _registrationNumber = registrationNumber,
        _serviceArea = serviceArea,
        _profession = profession,
        _insuranceAmount = insuranceAmount,
        _skills = skills,
        _deviceToken = deviceToken,
        _totalReviews = totalReviews,
        _averageRating = averageRating,
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

  // "email" field.
  String? _email;
  String get email => _email ?? '';
  set email(String? val) => _email = val;

  bool hasEmail() => _email != null;

  // "account_status" field.
  String? _accountStatus;
  String get accountStatus => _accountStatus ?? '';
  set accountStatus(String? val) => _accountStatus = val;

  bool hasAccountStatus() => _accountStatus != null;

  // "email_verified" field.
  bool? _emailVerified;
  bool get emailVerified => _emailVerified ?? false;
  set emailVerified(bool? val) => _emailVerified = val;

  bool hasEmailVerified() => _emailVerified != null;

  // "avatar_url" field.
  String? _avatarUrl;
  String get avatarUrl => _avatarUrl ?? '';
  set avatarUrl(String? val) => _avatarUrl = val;

  bool hasAvatarUrl() => _avatarUrl != null;

  // "insurance_verified" field.
  bool? _insuranceVerified;
  bool get insuranceVerified => _insuranceVerified ?? false;
  set insuranceVerified(bool? val) => _insuranceVerified = val;

  bool hasInsuranceVerified() => _insuranceVerified != null;

  // "created_at" field.
  String? _createdAt;
  String get createdAt => _createdAt ?? '';
  set createdAt(String? val) => _createdAt = val;

  bool hasCreatedAt() => _createdAt != null;

  // "insurance_expiry" field.
  String? _insuranceExpiry;
  String get insuranceExpiry => _insuranceExpiry ?? '';
  set insuranceExpiry(String? val) => _insuranceExpiry = val;

  bool hasInsuranceExpiry() => _insuranceExpiry != null;

  // "about" field.
  String? _about;
  String get about => _about ?? '';
  set about(String? val) => _about = val;

  bool hasAbout() => _about != null;

  // "years_experience" field.
  String? _yearsExperience;
  String get yearsExperience => _yearsExperience ?? '';
  set yearsExperience(String? val) => _yearsExperience = val;

  bool hasYearsExperience() => _yearsExperience != null;

  // "qualifications" field.
  String? _qualifications;
  String get qualifications => _qualifications ?? '';
  set qualifications(String? val) => _qualifications = val;

  bool hasQualifications() => _qualifications != null;

  // "user_key" field.
  String? _userKey;
  String get userKey => _userKey ?? '';
  set userKey(String? val) => _userKey = val;

  bool hasUserKey() => _userKey != null;

  // "onboarding_step" field.
  int? _onboardingStep;
  int get onboardingStep => _onboardingStep ?? 0;
  set onboardingStep(int? val) => _onboardingStep = val;

  void incrementOnboardingStep(int amount) =>
      onboardingStep = onboardingStep + amount;

  bool hasOnboardingStep() => _onboardingStep != null;

  // "user_role" field.
  int? _userRole;
  int get userRole => _userRole ?? 0;
  set userRole(int? val) => _userRole = val;

  void incrementUserRole(int amount) => userRole = userRole + amount;

  bool hasUserRole() => _userRole != null;

  // "phone" field.
  String? _phone;
  String get phone => _phone ?? '';
  set phone(String? val) => _phone = val;

  bool hasPhone() => _phone != null;

  // "street" field.
  String? _street;
  String get street => _street ?? '';
  set street(String? val) => _street = val;

  bool hasStreet() => _street != null;

  // "zipcode" field.
  String? _zipcode;
  String get zipcode => _zipcode ?? '';
  set zipcode(String? val) => _zipcode = val;

  bool hasZipcode() => _zipcode != null;

  // "streetaddress" field.
  String? _streetaddress;
  String get streetaddress => _streetaddress ?? '';
  set streetaddress(String? val) => _streetaddress = val;

  bool hasStreetaddress() => _streetaddress != null;

  // "insurance_company" field.
  String? _insuranceCompany;
  String get insuranceCompany => _insuranceCompany ?? '';
  set insuranceCompany(String? val) => _insuranceCompany = val;

  bool hasInsuranceCompany() => _insuranceCompany != null;

  // "registration_number" field.
  String? _registrationNumber;
  String get registrationNumber => _registrationNumber ?? '';
  set registrationNumber(String? val) => _registrationNumber = val;

  bool hasRegistrationNumber() => _registrationNumber != null;

  // "service_area" field.
  String? _serviceArea;
  String get serviceArea => _serviceArea ?? '';
  set serviceArea(String? val) => _serviceArea = val;

  bool hasServiceArea() => _serviceArea != null;

  // "profession" field.
  String? _profession;
  String get profession => _profession ?? '';
  set profession(String? val) => _profession = val;

  bool hasProfession() => _profession != null;

  // "insurance_amount" field.
  String? _insuranceAmount;
  String get insuranceAmount => _insuranceAmount ?? '';
  set insuranceAmount(String? val) => _insuranceAmount = val;

  bool hasInsuranceAmount() => _insuranceAmount != null;

  // "skills" field.
  List<String>? _skills;
  List<String> get skills => _skills ?? const [];
  set skills(List<String>? val) => _skills = val;

  void updateSkills(Function(List<String>) updateFn) {
    updateFn(_skills ??= []);
  }

  bool hasSkills() => _skills != null;

  // "device_token" field.
  String? _deviceToken;
  String get deviceToken => _deviceToken ?? '';
  set deviceToken(String? val) => _deviceToken = val;

  bool hasDeviceToken() => _deviceToken != null;

  // "total_reviews" field.
  int? _totalReviews;
  int get totalReviews => _totalReviews ?? 0;
  set totalReviews(int? val) => _totalReviews = val;

  void incrementTotalReviews(int amount) =>
      totalReviews = totalReviews + amount;

  bool hasTotalReviews() => _totalReviews != null;

  // "average_rating" field.
  int? _averageRating;
  int get averageRating => _averageRating ?? 0;
  set averageRating(int? val) => _averageRating = val;

  void incrementAverageRating(int amount) =>
      averageRating = averageRating + amount;

  bool hasAverageRating() => _averageRating != null;

  static UserStruct fromMap(Map<String, dynamic> data) => UserStruct(
        id: data['id'] as String?,
        name: data['name'] as String?,
        email: data['email'] as String?,
        accountStatus: data['account_status'] as String?,
        emailVerified: data['email_verified'] as bool?,
        avatarUrl: data['avatar_url'] as String?,
        insuranceVerified: data['insurance_verified'] as bool?,
        createdAt: data['created_at'] as String?,
        insuranceExpiry: data['insurance_expiry'] as String?,
        about: data['about'] as String?,
        yearsExperience: data['years_experience'] as String?,
        qualifications: data['qualifications'] as String?,
        userKey: data['user_key'] as String?,
        onboardingStep: castToType<int>(data['onboarding_step']),
        userRole: castToType<int>(data['user_role']),
        phone: data['phone'] as String?,
        street: data['street'] as String?,
        zipcode: data['zipcode'] as String?,
        streetaddress: data['streetaddress'] as String?,
        insuranceCompany: data['insurance_company'] as String?,
        registrationNumber: data['registration_number'] as String?,
        serviceArea: data['service_area'] as String?,
        profession: data['profession'] as String?,
        insuranceAmount: data['insurance_amount'] as String?,
        skills: getDataList(data['skills']),
        deviceToken: data['device_token'] as String?,
        totalReviews: castToType<int>(data['total_reviews']),
        averageRating: castToType<int>(data['average_rating']),
      );

  static UserStruct? maybeFromMap(dynamic data) =>
      data is Map ? UserStruct.fromMap(data.cast<String, dynamic>()) : null;

  Map<String, dynamic> toMap() => {
        'id': _id,
        'name': _name,
        'email': _email,
        'account_status': _accountStatus,
        'email_verified': _emailVerified,
        'avatar_url': _avatarUrl,
        'insurance_verified': _insuranceVerified,
        'created_at': _createdAt,
        'insurance_expiry': _insuranceExpiry,
        'about': _about,
        'years_experience': _yearsExperience,
        'qualifications': _qualifications,
        'user_key': _userKey,
        'onboarding_step': _onboardingStep,
        'user_role': _userRole,
        'phone': _phone,
        'street': _street,
        'zipcode': _zipcode,
        'streetaddress': _streetaddress,
        'insurance_company': _insuranceCompany,
        'registration_number': _registrationNumber,
        'service_area': _serviceArea,
        'profession': _profession,
        'insurance_amount': _insuranceAmount,
        'skills': _skills,
        'device_token': _deviceToken,
        'total_reviews': _totalReviews,
        'average_rating': _averageRating,
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
        'email': serializeParam(
          _email,
          ParamType.String,
        ),
        'account_status': serializeParam(
          _accountStatus,
          ParamType.String,
        ),
        'email_verified': serializeParam(
          _emailVerified,
          ParamType.bool,
        ),
        'avatar_url': serializeParam(
          _avatarUrl,
          ParamType.String,
        ),
        'insurance_verified': serializeParam(
          _insuranceVerified,
          ParamType.bool,
        ),
        'created_at': serializeParam(
          _createdAt,
          ParamType.String,
        ),
        'insurance_expiry': serializeParam(
          _insuranceExpiry,
          ParamType.String,
        ),
        'about': serializeParam(
          _about,
          ParamType.String,
        ),
        'years_experience': serializeParam(
          _yearsExperience,
          ParamType.String,
        ),
        'qualifications': serializeParam(
          _qualifications,
          ParamType.String,
        ),
        'user_key': serializeParam(
          _userKey,
          ParamType.String,
        ),
        'onboarding_step': serializeParam(
          _onboardingStep,
          ParamType.int,
        ),
        'user_role': serializeParam(
          _userRole,
          ParamType.int,
        ),
        'phone': serializeParam(
          _phone,
          ParamType.String,
        ),
        'street': serializeParam(
          _street,
          ParamType.String,
        ),
        'zipcode': serializeParam(
          _zipcode,
          ParamType.String,
        ),
        'streetaddress': serializeParam(
          _streetaddress,
          ParamType.String,
        ),
        'insurance_company': serializeParam(
          _insuranceCompany,
          ParamType.String,
        ),
        'registration_number': serializeParam(
          _registrationNumber,
          ParamType.String,
        ),
        'service_area': serializeParam(
          _serviceArea,
          ParamType.String,
        ),
        'profession': serializeParam(
          _profession,
          ParamType.String,
        ),
        'insurance_amount': serializeParam(
          _insuranceAmount,
          ParamType.String,
        ),
        'skills': serializeParam(
          _skills,
          ParamType.String,
          isList: true,
        ),
        'device_token': serializeParam(
          _deviceToken,
          ParamType.String,
        ),
        'total_reviews': serializeParam(
          _totalReviews,
          ParamType.int,
        ),
        'average_rating': serializeParam(
          _averageRating,
          ParamType.int,
        ),
      }.withoutNulls;

  static UserStruct fromSerializableMap(Map<String, dynamic> data) =>
      UserStruct(
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
        email: deserializeParam(
          data['email'],
          ParamType.String,
          false,
        ),
        accountStatus: deserializeParam(
          data['account_status'],
          ParamType.String,
          false,
        ),
        emailVerified: deserializeParam(
          data['email_verified'],
          ParamType.bool,
          false,
        ),
        avatarUrl: deserializeParam(
          data['avatar_url'],
          ParamType.String,
          false,
        ),
        insuranceVerified: deserializeParam(
          data['insurance_verified'],
          ParamType.bool,
          false,
        ),
        createdAt: deserializeParam(
          data['created_at'],
          ParamType.String,
          false,
        ),
        insuranceExpiry: deserializeParam(
          data['insurance_expiry'],
          ParamType.String,
          false,
        ),
        about: deserializeParam(
          data['about'],
          ParamType.String,
          false,
        ),
        yearsExperience: deserializeParam(
          data['years_experience'],
          ParamType.String,
          false,
        ),
        qualifications: deserializeParam(
          data['qualifications'],
          ParamType.String,
          false,
        ),
        userKey: deserializeParam(
          data['user_key'],
          ParamType.String,
          false,
        ),
        onboardingStep: deserializeParam(
          data['onboarding_step'],
          ParamType.int,
          false,
        ),
        userRole: deserializeParam(
          data['user_role'],
          ParamType.int,
          false,
        ),
        phone: deserializeParam(
          data['phone'],
          ParamType.String,
          false,
        ),
        street: deserializeParam(
          data['street'],
          ParamType.String,
          false,
        ),
        zipcode: deserializeParam(
          data['zipcode'],
          ParamType.String,
          false,
        ),
        streetaddress: deserializeParam(
          data['streetaddress'],
          ParamType.String,
          false,
        ),
        insuranceCompany: deserializeParam(
          data['insurance_company'],
          ParamType.String,
          false,
        ),
        registrationNumber: deserializeParam(
          data['registration_number'],
          ParamType.String,
          false,
        ),
        serviceArea: deserializeParam(
          data['service_area'],
          ParamType.String,
          false,
        ),
        profession: deserializeParam(
          data['profession'],
          ParamType.String,
          false,
        ),
        insuranceAmount: deserializeParam(
          data['insurance_amount'],
          ParamType.String,
          false,
        ),
        skills: deserializeParam<String>(
          data['skills'],
          ParamType.String,
          true,
        ),
        deviceToken: deserializeParam(
          data['device_token'],
          ParamType.String,
          false,
        ),
        totalReviews: deserializeParam(
          data['total_reviews'],
          ParamType.int,
          false,
        ),
        averageRating: deserializeParam(
          data['average_rating'],
          ParamType.int,
          false,
        ),
      );

  @override
  String toString() => 'UserStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    const listEquality = ListEquality();
    return other is UserStruct &&
        id == other.id &&
        name == other.name &&
        email == other.email &&
        accountStatus == other.accountStatus &&
        emailVerified == other.emailVerified &&
        avatarUrl == other.avatarUrl &&
        insuranceVerified == other.insuranceVerified &&
        createdAt == other.createdAt &&
        insuranceExpiry == other.insuranceExpiry &&
        about == other.about &&
        yearsExperience == other.yearsExperience &&
        qualifications == other.qualifications &&
        userKey == other.userKey &&
        onboardingStep == other.onboardingStep &&
        userRole == other.userRole &&
        phone == other.phone &&
        street == other.street &&
        zipcode == other.zipcode &&
        streetaddress == other.streetaddress &&
        insuranceCompany == other.insuranceCompany &&
        registrationNumber == other.registrationNumber &&
        serviceArea == other.serviceArea &&
        profession == other.profession &&
        insuranceAmount == other.insuranceAmount &&
        listEquality.equals(skills, other.skills) &&
        deviceToken == other.deviceToken &&
        totalReviews == other.totalReviews &&
        averageRating == other.averageRating;
  }

  @override
  int get hashCode => const ListEquality().hash([
        id,
        name,
        email,
        accountStatus,
        emailVerified,
        avatarUrl,
        insuranceVerified,
        createdAt,
        insuranceExpiry,
        about,
        yearsExperience,
        qualifications,
        userKey,
        onboardingStep,
        userRole,
        phone,
        street,
        zipcode,
        streetaddress,
        insuranceCompany,
        registrationNumber,
        serviceArea,
        profession,
        insuranceAmount,
        skills,
        deviceToken,
        totalReviews,
        averageRating
      ]);
}

UserStruct createUserStruct({
  String? id,
  String? name,
  String? email,
  String? accountStatus,
  bool? emailVerified,
  String? avatarUrl,
  bool? insuranceVerified,
  String? createdAt,
  String? insuranceExpiry,
  String? about,
  String? yearsExperience,
  String? qualifications,
  String? userKey,
  int? onboardingStep,
  int? userRole,
  String? phone,
  String? street,
  String? zipcode,
  String? streetaddress,
  String? insuranceCompany,
  String? registrationNumber,
  String? serviceArea,
  String? profession,
  String? insuranceAmount,
  String? deviceToken,
  int? totalReviews,
  int? averageRating,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    UserStruct(
      id: id,
      name: name,
      email: email,
      accountStatus: accountStatus,
      emailVerified: emailVerified,
      avatarUrl: avatarUrl,
      insuranceVerified: insuranceVerified,
      createdAt: createdAt,
      insuranceExpiry: insuranceExpiry,
      about: about,
      yearsExperience: yearsExperience,
      qualifications: qualifications,
      userKey: userKey,
      onboardingStep: onboardingStep,
      userRole: userRole,
      phone: phone,
      street: street,
      zipcode: zipcode,
      streetaddress: streetaddress,
      insuranceCompany: insuranceCompany,
      registrationNumber: registrationNumber,
      serviceArea: serviceArea,
      profession: profession,
      insuranceAmount: insuranceAmount,
      deviceToken: deviceToken,
      totalReviews: totalReviews,
      averageRating: averageRating,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

UserStruct? updateUserStruct(
  UserStruct? user, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    user
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addUserStructData(
  Map<String, dynamic> firestoreData,
  UserStruct? user,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (user == null) {
    return;
  }
  if (user.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields = !forFieldValue && user.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final userData = getUserFirestoreData(user, forFieldValue);
  final nestedData = userData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = user.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getUserFirestoreData(
  UserStruct? user, [
  bool forFieldValue = false,
]) {
  if (user == null) {
    return {};
  }
  final firestoreData = mapToFirestore(user.toMap());

  // Add any Firestore field values
  mapToFirestore(user.firestoreUtilData.fieldValues)
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getUserListFirestoreData(
  List<UserStruct>? users,
) =>
    users?.map((e) => getUserFirestoreData(e, true)).toList() ?? [];
