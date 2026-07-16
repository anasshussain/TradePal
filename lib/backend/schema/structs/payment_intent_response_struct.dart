// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';
import '/backend/schema/enums/enums.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class PaymentIntentResponseStruct extends FFFirebaseStruct {
  PaymentIntentResponseStruct({
    bool? success,
    String? clientSecret,
    String? paymentIntentId,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _success = success,
        _clientSecret = clientSecret,
        _paymentIntentId = paymentIntentId,
        super(firestoreUtilData);

  // "success" field.
  bool? _success;
  bool get success => _success ?? false;
  set success(bool? val) => _success = val;

  bool hasSuccess() => _success != null;

  // "client_secret" field.
  String? _clientSecret;
  String get clientSecret => _clientSecret ?? '';
  set clientSecret(String? val) => _clientSecret = val;

  bool hasClientSecret() => _clientSecret != null;

  // "payment_intent_id" field.
  String? _paymentIntentId;
  String get paymentIntentId => _paymentIntentId ?? '';
  set paymentIntentId(String? val) => _paymentIntentId = val;

  bool hasPaymentIntentId() => _paymentIntentId != null;

  static PaymentIntentResponseStruct fromMap(Map<String, dynamic> data) =>
      PaymentIntentResponseStruct(
        success: data['success'] as bool?,
        clientSecret: data['client_secret'] as String?,
        paymentIntentId: data['payment_intent_id'] as String?,
      );

  static PaymentIntentResponseStruct? maybeFromMap(dynamic data) => data is Map
      ? PaymentIntentResponseStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'success': _success,
        'client_secret': _clientSecret,
        'payment_intent_id': _paymentIntentId,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'success': serializeParam(
          _success,
          ParamType.bool,
        ),
        'client_secret': serializeParam(
          _clientSecret,
          ParamType.String,
        ),
        'payment_intent_id': serializeParam(
          _paymentIntentId,
          ParamType.String,
        ),
      }.withoutNulls;

  static PaymentIntentResponseStruct fromSerializableMap(
          Map<String, dynamic> data) =>
      PaymentIntentResponseStruct(
        success: deserializeParam(
          data['success'],
          ParamType.bool,
          false,
        ),
        clientSecret: deserializeParam(
          data['client_secret'],
          ParamType.String,
          false,
        ),
        paymentIntentId: deserializeParam(
          data['payment_intent_id'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'PaymentIntentResponseStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is PaymentIntentResponseStruct &&
        success == other.success &&
        clientSecret == other.clientSecret &&
        paymentIntentId == other.paymentIntentId;
  }

  @override
  int get hashCode =>
      const ListEquality().hash([success, clientSecret, paymentIntentId]);
}

PaymentIntentResponseStruct createPaymentIntentResponseStruct({
  bool? success,
  String? clientSecret,
  String? paymentIntentId,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    PaymentIntentResponseStruct(
      success: success,
      clientSecret: clientSecret,
      paymentIntentId: paymentIntentId,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

PaymentIntentResponseStruct? updatePaymentIntentResponseStruct(
  PaymentIntentResponseStruct? paymentIntentResponse, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    paymentIntentResponse
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addPaymentIntentResponseStructData(
  Map<String, dynamic> firestoreData,
  PaymentIntentResponseStruct? paymentIntentResponse,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (paymentIntentResponse == null) {
    return;
  }
  if (paymentIntentResponse.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields = !forFieldValue &&
      paymentIntentResponse.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final paymentIntentResponseData = getPaymentIntentResponseFirestoreData(
      paymentIntentResponse, forFieldValue);
  final nestedData =
      paymentIntentResponseData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields =
      paymentIntentResponse.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getPaymentIntentResponseFirestoreData(
  PaymentIntentResponseStruct? paymentIntentResponse, [
  bool forFieldValue = false,
]) {
  if (paymentIntentResponse == null) {
    return {};
  }
  final firestoreData = mapToFirestore(paymentIntentResponse.toMap());

  // Add any Firestore field values
  mapToFirestore(paymentIntentResponse.firestoreUtilData.fieldValues)
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getPaymentIntentResponseListFirestoreData(
  List<PaymentIntentResponseStruct>? paymentIntentResponses,
) =>
    paymentIntentResponses
        ?.map((e) => getPaymentIntentResponseFirestoreData(e, true))
        .toList() ??
    [];
