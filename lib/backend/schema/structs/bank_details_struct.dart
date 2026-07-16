// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';
import '/backend/schema/enums/enums.dart';

import 'index.dart';
import '/core/util.dart';

class BankDetailsStruct extends AppFirebaseStruct {
  BankDetailsStruct({
    String? id,
    String? object,
    String? account,
    String? accountHolderName,
    String? accountHolderType,
    String? accountType,
    List<String>? availablePayoutMethods,
    String? bankName,
    String? country,
    String? currency,
    bool? defaultForCurrency,
    String? fingerprint,
    FutureRequirementsStruct? futureRequirements,
    String? last4,
    RequirementsStruct? requirements,
    String? routingNumber,
    String? status,
    MetadataStruct? metadata,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _id = id,
        _object = object,
        _account = account,
        _accountHolderName = accountHolderName,
        _accountHolderType = accountHolderType,
        _accountType = accountType,
        _availablePayoutMethods = availablePayoutMethods,
        _bankName = bankName,
        _country = country,
        _currency = currency,
        _defaultForCurrency = defaultForCurrency,
        _fingerprint = fingerprint,
        _futureRequirements = futureRequirements,
        _last4 = last4,
        _requirements = requirements,
        _routingNumber = routingNumber,
        _status = status,
        _metadata = metadata,
        super(firestoreUtilData);

  // "id" field.
  String? _id;
  String get id => _id ?? '';
  set id(String? val) => _id = val;

  bool hasId() => _id != null;

  // "object" field.
  String? _object;
  String get object => _object ?? '';
  set object(String? val) => _object = val;

  bool hasObject() => _object != null;

  // "account" field.
  String? _account;
  String get account => _account ?? '';
  set account(String? val) => _account = val;

  bool hasAccount() => _account != null;

  // "account_holder_name" field.
  String? _accountHolderName;
  String get accountHolderName => _accountHolderName ?? '';
  set accountHolderName(String? val) => _accountHolderName = val;

  bool hasAccountHolderName() => _accountHolderName != null;

  // "account_holder_type" field.
  String? _accountHolderType;
  String get accountHolderType => _accountHolderType ?? '';
  set accountHolderType(String? val) => _accountHolderType = val;

  bool hasAccountHolderType() => _accountHolderType != null;

  // "account_type" field.
  String? _accountType;
  String get accountType => _accountType ?? '';
  set accountType(String? val) => _accountType = val;

  bool hasAccountType() => _accountType != null;

  // "available_payout_methods" field.
  List<String>? _availablePayoutMethods;
  List<String> get availablePayoutMethods =>
      _availablePayoutMethods ?? const [];
  set availablePayoutMethods(List<String>? val) =>
      _availablePayoutMethods = val;

  void updateAvailablePayoutMethods(Function(List<String>) updateFn) {
    updateFn(_availablePayoutMethods ??= []);
  }

  bool hasAvailablePayoutMethods() => _availablePayoutMethods != null;

  // "bank_name" field.
  String? _bankName;
  String get bankName => _bankName ?? '';
  set bankName(String? val) => _bankName = val;

  bool hasBankName() => _bankName != null;

  // "country" field.
  String? _country;
  String get country => _country ?? '';
  set country(String? val) => _country = val;

  bool hasCountry() => _country != null;

  // "currency" field.
  String? _currency;
  String get currency => _currency ?? '';
  set currency(String? val) => _currency = val;

  bool hasCurrency() => _currency != null;

  // "default_for_currency" field.
  bool? _defaultForCurrency;
  bool get defaultForCurrency => _defaultForCurrency ?? false;
  set defaultForCurrency(bool? val) => _defaultForCurrency = val;

  bool hasDefaultForCurrency() => _defaultForCurrency != null;

  // "fingerprint" field.
  String? _fingerprint;
  String get fingerprint => _fingerprint ?? '';
  set fingerprint(String? val) => _fingerprint = val;

  bool hasFingerprint() => _fingerprint != null;

  // "future_requirements" field.
  FutureRequirementsStruct? _futureRequirements;
  FutureRequirementsStruct get futureRequirements =>
      _futureRequirements ?? FutureRequirementsStruct();
  set futureRequirements(FutureRequirementsStruct? val) =>
      _futureRequirements = val;

  void updateFutureRequirements(Function(FutureRequirementsStruct) updateFn) {
    updateFn(_futureRequirements ??= FutureRequirementsStruct());
  }

  bool hasFutureRequirements() => _futureRequirements != null;

  // "last4" field.
  String? _last4;
  String get last4 => _last4 ?? '';
  set last4(String? val) => _last4 = val;

  bool hasLast4() => _last4 != null;

  // "requirements" field.
  RequirementsStruct? _requirements;
  RequirementsStruct get requirements => _requirements ?? RequirementsStruct();
  set requirements(RequirementsStruct? val) => _requirements = val;

  void updateRequirements(Function(RequirementsStruct) updateFn) {
    updateFn(_requirements ??= RequirementsStruct());
  }

  bool hasRequirements() => _requirements != null;

  // "routing_number" field.
  String? _routingNumber;
  String get routingNumber => _routingNumber ?? '';
  set routingNumber(String? val) => _routingNumber = val;

  bool hasRoutingNumber() => _routingNumber != null;

  // "status" field.
  String? _status;
  String get status => _status ?? '';
  set status(String? val) => _status = val;

  bool hasStatus() => _status != null;

  // "metadata" field.
  MetadataStruct? _metadata;
  MetadataStruct get metadata => _metadata ?? MetadataStruct();
  set metadata(MetadataStruct? val) => _metadata = val;

  void updateMetadata(Function(MetadataStruct) updateFn) {
    updateFn(_metadata ??= MetadataStruct());
  }

  bool hasMetadata() => _metadata != null;

  static BankDetailsStruct fromMap(Map<String, dynamic> data) =>
      BankDetailsStruct(
        id: data['id'] as String?,
        object: data['object'] as String?,
        account: data['account'] as String?,
        accountHolderName: data['account_holder_name'] as String?,
        accountHolderType: data['account_holder_type'] as String?,
        accountType: data['account_type'] as String?,
        availablePayoutMethods: getDataList(data['available_payout_methods']),
        bankName: data['bank_name'] as String?,
        country: data['country'] as String?,
        currency: data['currency'] as String?,
        defaultForCurrency: data['default_for_currency'] as bool?,
        fingerprint: data['fingerprint'] as String?,
        futureRequirements:
            data['future_requirements'] is FutureRequirementsStruct
                ? data['future_requirements']
                : FutureRequirementsStruct.maybeFromMap(
                    data['future_requirements']),
        last4: data['last4'] as String?,
        requirements: data['requirements'] is RequirementsStruct
            ? data['requirements']
            : RequirementsStruct.maybeFromMap(data['requirements']),
        routingNumber: data['routing_number'] as String?,
        status: data['status'] as String?,
        metadata: data['metadata'] is MetadataStruct
            ? data['metadata']
            : MetadataStruct.maybeFromMap(data['metadata']),
      );

  static BankDetailsStruct? maybeFromMap(dynamic data) => data is Map
      ? BankDetailsStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'id': _id,
        'object': _object,
        'account': _account,
        'account_holder_name': _accountHolderName,
        'account_holder_type': _accountHolderType,
        'account_type': _accountType,
        'available_payout_methods': _availablePayoutMethods,
        'bank_name': _bankName,
        'country': _country,
        'currency': _currency,
        'default_for_currency': _defaultForCurrency,
        'fingerprint': _fingerprint,
        'future_requirements': _futureRequirements?.toMap(),
        'last4': _last4,
        'requirements': _requirements?.toMap(),
        'routing_number': _routingNumber,
        'status': _status,
        'metadata': _metadata?.toMap(),
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'id': serializeParam(
          _id,
          ParamType.String,
        ),
        'object': serializeParam(
          _object,
          ParamType.String,
        ),
        'account': serializeParam(
          _account,
          ParamType.String,
        ),
        'account_holder_name': serializeParam(
          _accountHolderName,
          ParamType.String,
        ),
        'account_holder_type': serializeParam(
          _accountHolderType,
          ParamType.String,
        ),
        'account_type': serializeParam(
          _accountType,
          ParamType.String,
        ),
        'available_payout_methods': serializeParam(
          _availablePayoutMethods,
          ParamType.String,
          isList: true,
        ),
        'bank_name': serializeParam(
          _bankName,
          ParamType.String,
        ),
        'country': serializeParam(
          _country,
          ParamType.String,
        ),
        'currency': serializeParam(
          _currency,
          ParamType.String,
        ),
        'default_for_currency': serializeParam(
          _defaultForCurrency,
          ParamType.bool,
        ),
        'fingerprint': serializeParam(
          _fingerprint,
          ParamType.String,
        ),
        'future_requirements': serializeParam(
          _futureRequirements,
          ParamType.DataStruct,
        ),
        'last4': serializeParam(
          _last4,
          ParamType.String,
        ),
        'requirements': serializeParam(
          _requirements,
          ParamType.DataStruct,
        ),
        'routing_number': serializeParam(
          _routingNumber,
          ParamType.String,
        ),
        'status': serializeParam(
          _status,
          ParamType.String,
        ),
        'metadata': serializeParam(
          _metadata,
          ParamType.DataStruct,
        ),
      }.withoutNulls;

  static BankDetailsStruct fromSerializableMap(Map<String, dynamic> data) =>
      BankDetailsStruct(
        id: deserializeParam(
          data['id'],
          ParamType.String,
          false,
        ),
        object: deserializeParam(
          data['object'],
          ParamType.String,
          false,
        ),
        account: deserializeParam(
          data['account'],
          ParamType.String,
          false,
        ),
        accountHolderName: deserializeParam(
          data['account_holder_name'],
          ParamType.String,
          false,
        ),
        accountHolderType: deserializeParam(
          data['account_holder_type'],
          ParamType.String,
          false,
        ),
        accountType: deserializeParam(
          data['account_type'],
          ParamType.String,
          false,
        ),
        availablePayoutMethods: deserializeParam<String>(
          data['available_payout_methods'],
          ParamType.String,
          true,
        ),
        bankName: deserializeParam(
          data['bank_name'],
          ParamType.String,
          false,
        ),
        country: deserializeParam(
          data['country'],
          ParamType.String,
          false,
        ),
        currency: deserializeParam(
          data['currency'],
          ParamType.String,
          false,
        ),
        defaultForCurrency: deserializeParam(
          data['default_for_currency'],
          ParamType.bool,
          false,
        ),
        fingerprint: deserializeParam(
          data['fingerprint'],
          ParamType.String,
          false,
        ),
        futureRequirements: deserializeStructParam(
          data['future_requirements'],
          ParamType.DataStruct,
          false,
          structBuilder: FutureRequirementsStruct.fromSerializableMap,
        ),
        last4: deserializeParam(
          data['last4'],
          ParamType.String,
          false,
        ),
        requirements: deserializeStructParam(
          data['requirements'],
          ParamType.DataStruct,
          false,
          structBuilder: RequirementsStruct.fromSerializableMap,
        ),
        routingNumber: deserializeParam(
          data['routing_number'],
          ParamType.String,
          false,
        ),
        status: deserializeParam(
          data['status'],
          ParamType.String,
          false,
        ),
        metadata: deserializeStructParam(
          data['metadata'],
          ParamType.DataStruct,
          false,
          structBuilder: MetadataStruct.fromSerializableMap,
        ),
      );

  @override
  String toString() => 'BankDetailsStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    const listEquality = ListEquality();
    return other is BankDetailsStruct &&
        id == other.id &&
        object == other.object &&
        account == other.account &&
        accountHolderName == other.accountHolderName &&
        accountHolderType == other.accountHolderType &&
        accountType == other.accountType &&
        listEquality.equals(
            availablePayoutMethods, other.availablePayoutMethods) &&
        bankName == other.bankName &&
        country == other.country &&
        currency == other.currency &&
        defaultForCurrency == other.defaultForCurrency &&
        fingerprint == other.fingerprint &&
        futureRequirements == other.futureRequirements &&
        last4 == other.last4 &&
        requirements == other.requirements &&
        routingNumber == other.routingNumber &&
        status == other.status &&
        metadata == other.metadata;
  }

  @override
  int get hashCode => const ListEquality().hash([
        id,
        object,
        account,
        accountHolderName,
        accountHolderType,
        accountType,
        availablePayoutMethods,
        bankName,
        country,
        currency,
        defaultForCurrency,
        fingerprint,
        futureRequirements,
        last4,
        requirements,
        routingNumber,
        status,
        metadata
      ]);
}

BankDetailsStruct createBankDetailsStruct({
  String? id,
  String? object,
  String? account,
  String? accountHolderName,
  String? accountHolderType,
  String? accountType,
  String? bankName,
  String? country,
  String? currency,
  bool? defaultForCurrency,
  String? fingerprint,
  FutureRequirementsStruct? futureRequirements,
  String? last4,
  RequirementsStruct? requirements,
  String? routingNumber,
  String? status,
  MetadataStruct? metadata,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    BankDetailsStruct(
      id: id,
      object: object,
      account: account,
      accountHolderName: accountHolderName,
      accountHolderType: accountHolderType,
      accountType: accountType,
      bankName: bankName,
      country: country,
      currency: currency,
      defaultForCurrency: defaultForCurrency,
      fingerprint: fingerprint,
      futureRequirements: futureRequirements ??
          (clearUnsetFields ? FutureRequirementsStruct() : null),
      last4: last4,
      requirements:
          requirements ?? (clearUnsetFields ? RequirementsStruct() : null),
      routingNumber: routingNumber,
      status: status,
      metadata: metadata ?? (clearUnsetFields ? MetadataStruct() : null),
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

BankDetailsStruct? updateBankDetailsStruct(
  BankDetailsStruct? bankDetails, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    bankDetails
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addBankDetailsStructData(
  Map<String, dynamic> firestoreData,
  BankDetailsStruct? bankDetails,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (bankDetails == null) {
    return;
  }
  if (bankDetails.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && bankDetails.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final bankDetailsData =
      getBankDetailsFirestoreData(bankDetails, forFieldValue);
  final nestedData =
      bankDetailsData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = bankDetails.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getBankDetailsFirestoreData(
  BankDetailsStruct? bankDetails, [
  bool forFieldValue = false,
]) {
  if (bankDetails == null) {
    return {};
  }
  final firestoreData = mapToFirestore(bankDetails.toMap());

  // Handle nested data for "future_requirements" field.
  addFutureRequirementsStructData(
    firestoreData,
    bankDetails.hasFutureRequirements() ? bankDetails.futureRequirements : null,
    'future_requirements',
    forFieldValue,
  );

  // Handle nested data for "requirements" field.
  addRequirementsStructData(
    firestoreData,
    bankDetails.hasRequirements() ? bankDetails.requirements : null,
    'requirements',
    forFieldValue,
  );

  // Handle nested data for "metadata" field.
  addMetadataStructData(
    firestoreData,
    bankDetails.hasMetadata() ? bankDetails.metadata : null,
    'metadata',
    forFieldValue,
  );

  // Add any Firestore field values
  mapToFirestore(bankDetails.firestoreUtilData.fieldValues)
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getBankDetailsListFirestoreData(
  List<BankDetailsStruct>? bankDetailss,
) =>
    bankDetailss?.map((e) => getBankDetailsFirestoreData(e, true)).toList() ??
    [];
