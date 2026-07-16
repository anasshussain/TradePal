// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';
import '/backend/schema/enums/enums.dart';

import 'index.dart';
import '/core/util.dart';

class StripeDataStruct extends AppFirebaseStruct {
  StripeDataStruct({
    String? id,
    String? userId,
    String? stripeAccountId,
    bool? chargesEnabled,
    bool? payoutsEnabled,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _id = id,
        _userId = userId,
        _stripeAccountId = stripeAccountId,
        _chargesEnabled = chargesEnabled,
        _payoutsEnabled = payoutsEnabled,
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

  // "stripe_account_id" field.
  String? _stripeAccountId;
  String get stripeAccountId => _stripeAccountId ?? '';
  set stripeAccountId(String? val) => _stripeAccountId = val;

  bool hasStripeAccountId() => _stripeAccountId != null;

  // "charges_enabled" field.
  bool? _chargesEnabled;
  bool get chargesEnabled => _chargesEnabled ?? false;
  set chargesEnabled(bool? val) => _chargesEnabled = val;

  bool hasChargesEnabled() => _chargesEnabled != null;

  // "payouts_enabled" field.
  bool? _payoutsEnabled;
  bool get payoutsEnabled => _payoutsEnabled ?? false;
  set payoutsEnabled(bool? val) => _payoutsEnabled = val;

  bool hasPayoutsEnabled() => _payoutsEnabled != null;

  static StripeDataStruct fromMap(Map<String, dynamic> data) =>
      StripeDataStruct(
        id: data['id'] as String?,
        userId: data['user_id'] as String?,
        stripeAccountId: data['stripe_account_id'] as String?,
        chargesEnabled: data['charges_enabled'] as bool?,
        payoutsEnabled: data['payouts_enabled'] as bool?,
      );

  static StripeDataStruct? maybeFromMap(dynamic data) => data is Map
      ? StripeDataStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'id': _id,
        'user_id': _userId,
        'stripe_account_id': _stripeAccountId,
        'charges_enabled': _chargesEnabled,
        'payouts_enabled': _payoutsEnabled,
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
        'stripe_account_id': serializeParam(
          _stripeAccountId,
          ParamType.String,
        ),
        'charges_enabled': serializeParam(
          _chargesEnabled,
          ParamType.bool,
        ),
        'payouts_enabled': serializeParam(
          _payoutsEnabled,
          ParamType.bool,
        ),
      }.withoutNulls;

  static StripeDataStruct fromSerializableMap(Map<String, dynamic> data) =>
      StripeDataStruct(
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
        stripeAccountId: deserializeParam(
          data['stripe_account_id'],
          ParamType.String,
          false,
        ),
        chargesEnabled: deserializeParam(
          data['charges_enabled'],
          ParamType.bool,
          false,
        ),
        payoutsEnabled: deserializeParam(
          data['payouts_enabled'],
          ParamType.bool,
          false,
        ),
      );

  @override
  String toString() => 'StripeDataStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is StripeDataStruct &&
        id == other.id &&
        userId == other.userId &&
        stripeAccountId == other.stripeAccountId &&
        chargesEnabled == other.chargesEnabled &&
        payoutsEnabled == other.payoutsEnabled;
  }

  @override
  int get hashCode => const ListEquality()
      .hash([id, userId, stripeAccountId, chargesEnabled, payoutsEnabled]);
}

StripeDataStruct createStripeDataStruct({
  String? id,
  String? userId,
  String? stripeAccountId,
  bool? chargesEnabled,
  bool? payoutsEnabled,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    StripeDataStruct(
      id: id,
      userId: userId,
      stripeAccountId: stripeAccountId,
      chargesEnabled: chargesEnabled,
      payoutsEnabled: payoutsEnabled,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

StripeDataStruct? updateStripeDataStruct(
  StripeDataStruct? stripeData, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    stripeData
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addStripeDataStructData(
  Map<String, dynamic> firestoreData,
  StripeDataStruct? stripeData,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (stripeData == null) {
    return;
  }
  if (stripeData.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && stripeData.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final stripeDataData = getStripeDataFirestoreData(stripeData, forFieldValue);
  final nestedData = stripeDataData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = stripeData.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getStripeDataFirestoreData(
  StripeDataStruct? stripeData, [
  bool forFieldValue = false,
]) {
  if (stripeData == null) {
    return {};
  }
  final firestoreData = mapToFirestore(stripeData.toMap());

  // Add any Firestore field values
  mapToFirestore(stripeData.firestoreUtilData.fieldValues)
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getStripeDataListFirestoreData(
  List<StripeDataStruct>? stripeDatas,
) =>
    stripeDatas?.map((e) => getStripeDataFirestoreData(e, true)).toList() ?? [];
