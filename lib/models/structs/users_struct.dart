// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/models/util/firestore_util.dart';
import '/models/util/schema_util.dart';
import '/utils/enums/enums.dart';

import '/models/structs/index.dart';
import '/utils/util.dart';

class UsersStruct extends AppFirebaseStruct {
  UsersStruct({
    String? deviceToken,
    int? averageRating,
    int? totalReviews,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _deviceToken = deviceToken,
        _averageRating = averageRating,
        _totalReviews = totalReviews,
        super(firestoreUtilData);

  // "device_token" field.
  String? _deviceToken;
  String get deviceToken => _deviceToken ?? '';
  set deviceToken(String? val) => _deviceToken = val;

  bool hasDeviceToken() => _deviceToken != null;

  // "average_rating" field.
  int? _averageRating;
  int get averageRating => _averageRating ?? 0;
  set averageRating(int? val) => _averageRating = val;

  void incrementAverageRating(int amount) =>
      averageRating = averageRating + amount;

  bool hasAverageRating() => _averageRating != null;

  // "total_reviews" field.
  int? _totalReviews;
  int get totalReviews => _totalReviews ?? 0;
  set totalReviews(int? val) => _totalReviews = val;

  void incrementTotalReviews(int amount) =>
      totalReviews = totalReviews + amount;

  bool hasTotalReviews() => _totalReviews != null;

  static UsersStruct fromMap(Map<String, dynamic> data) => UsersStruct(
        deviceToken: data['device_token'] as String?,
        averageRating: castToType<int>(data['average_rating']),
        totalReviews: castToType<int>(data['total_reviews']),
      );

  static UsersStruct? maybeFromMap(dynamic data) =>
      data is Map ? UsersStruct.fromMap(data.cast<String, dynamic>()) : null;

  Map<String, dynamic> toMap() => {
        'device_token': _deviceToken,
        'average_rating': _averageRating,
        'total_reviews': _totalReviews,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'device_token': serializeParam(
          _deviceToken,
          ParamType.String,
        ),
        'average_rating': serializeParam(
          _averageRating,
          ParamType.int,
        ),
        'total_reviews': serializeParam(
          _totalReviews,
          ParamType.int,
        ),
      }.withoutNulls;

  static UsersStruct fromSerializableMap(Map<String, dynamic> data) =>
      UsersStruct(
        deviceToken: deserializeParam(
          data['device_token'],
          ParamType.String,
          false,
        ),
        averageRating: deserializeParam(
          data['average_rating'],
          ParamType.int,
          false,
        ),
        totalReviews: deserializeParam(
          data['total_reviews'],
          ParamType.int,
          false,
        ),
      );

  @override
  String toString() => 'UsersStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is UsersStruct &&
        deviceToken == other.deviceToken &&
        averageRating == other.averageRating &&
        totalReviews == other.totalReviews;
  }

  @override
  int get hashCode =>
      const ListEquality().hash([deviceToken, averageRating, totalReviews]);
}

UsersStruct createUsersStruct({
  String? deviceToken,
  int? averageRating,
  int? totalReviews,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    UsersStruct(
      deviceToken: deviceToken,
      averageRating: averageRating,
      totalReviews: totalReviews,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

UsersStruct? updateUsersStruct(
  UsersStruct? users, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    users
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addUsersStructData(
  Map<String, dynamic> firestoreData,
  UsersStruct? users,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (users == null) {
    return;
  }
  if (users.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && users.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final usersData = getUsersFirestoreData(users, forFieldValue);
  final nestedData = usersData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = users.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getUsersFirestoreData(
  UsersStruct? users, [
  bool forFieldValue = false,
]) {
  if (users == null) {
    return {};
  }
  final firestoreData = mapToFirestore(users.toMap());

  // Add any Firestore field values
  mapToFirestore(users.firestoreUtilData.fieldValues)
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getUsersListFirestoreData(
  List<UsersStruct>? userss,
) =>
    userss?.map((e) => getUsersFirestoreData(e, true)).toList() ?? [];
