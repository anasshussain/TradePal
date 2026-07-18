// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/models/util/firestore_util.dart';
import '/models/util/schema_util.dart';
import '/utils/enums/enums.dart';

import '/models/structs/index.dart';
import '/utils/util.dart';

class PayloadUpdateJobStruct extends AppFirebaseStruct {
  PayloadUpdateJobStruct({
    String? pJobId,
    String? pUserId,
    String? pJobTitle,
    String? pDescription,
    String? pBudgetMin,
    double? pLat,
    double? pLng,
    String? pCity,
    String? pState,
    String? pZipcode,
    String? pCountry,
    String? pCategory,
    int? pTotalQuotes,
    List<String>? pImages,
    String? pAddress,
    String? pName,
    String? pLocationType,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _pJobId = pJobId,
        _pUserId = pUserId,
        _pJobTitle = pJobTitle,
        _pDescription = pDescription,
        _pBudgetMin = pBudgetMin,
        _pLat = pLat,
        _pLng = pLng,
        _pCity = pCity,
        _pState = pState,
        _pZipcode = pZipcode,
        _pCountry = pCountry,
        _pCategory = pCategory,
        _pTotalQuotes = pTotalQuotes,
        _pImages = pImages,
        _pAddress = pAddress,
        _pName = pName,
        _pLocationType = pLocationType,
        super(firestoreUtilData);

  // "p_job_id" field.
  String? _pJobId;
  String get pJobId => _pJobId ?? '';
  set pJobId(String? val) => _pJobId = val;

  bool hasPJobId() => _pJobId != null;

  // "p_user_id" field.
  String? _pUserId;
  String get pUserId => _pUserId ?? '';
  set pUserId(String? val) => _pUserId = val;

  bool hasPUserId() => _pUserId != null;

  // "p_job_title" field.
  String? _pJobTitle;
  String get pJobTitle => _pJobTitle ?? '';
  set pJobTitle(String? val) => _pJobTitle = val;

  bool hasPJobTitle() => _pJobTitle != null;

  // "p_description" field.
  String? _pDescription;
  String get pDescription => _pDescription ?? '';
  set pDescription(String? val) => _pDescription = val;

  bool hasPDescription() => _pDescription != null;

  // "p_budget_min" field.
  String? _pBudgetMin;
  String get pBudgetMin => _pBudgetMin ?? '';
  set pBudgetMin(String? val) => _pBudgetMin = val;

  bool hasPBudgetMin() => _pBudgetMin != null;

  // "p_lat" field.
  double? _pLat;
  double get pLat => _pLat ?? 0.0;
  set pLat(double? val) => _pLat = val;

  void incrementPLat(double amount) => pLat = pLat + amount;

  bool hasPLat() => _pLat != null;

  // "p_lng" field.
  double? _pLng;
  double get pLng => _pLng ?? 0.0;
  set pLng(double? val) => _pLng = val;

  void incrementPLng(double amount) => pLng = pLng + amount;

  bool hasPLng() => _pLng != null;

  // "p_city" field.
  String? _pCity;
  String get pCity => _pCity ?? '';
  set pCity(String? val) => _pCity = val;

  bool hasPCity() => _pCity != null;

  // "p_state" field.
  String? _pState;
  String get pState => _pState ?? '';
  set pState(String? val) => _pState = val;

  bool hasPState() => _pState != null;

  // "p_zipcode" field.
  String? _pZipcode;
  String get pZipcode => _pZipcode ?? '';
  set pZipcode(String? val) => _pZipcode = val;

  bool hasPZipcode() => _pZipcode != null;

  // "p_country" field.
  String? _pCountry;
  String get pCountry => _pCountry ?? '';
  set pCountry(String? val) => _pCountry = val;

  bool hasPCountry() => _pCountry != null;

  // "p_category" field.
  String? _pCategory;
  String get pCategory => _pCategory ?? '';
  set pCategory(String? val) => _pCategory = val;

  bool hasPCategory() => _pCategory != null;

  // "p_total_quotes" field.
  int? _pTotalQuotes;
  int get pTotalQuotes => _pTotalQuotes ?? 0;
  set pTotalQuotes(int? val) => _pTotalQuotes = val;

  void incrementPTotalQuotes(int amount) =>
      pTotalQuotes = pTotalQuotes + amount;

  bool hasPTotalQuotes() => _pTotalQuotes != null;

  // "p_images" field.
  List<String>? _pImages;
  List<String> get pImages => _pImages ?? const [];
  set pImages(List<String>? val) => _pImages = val;

  void updatePImages(Function(List<String>) updateFn) {
    updateFn(_pImages ??= []);
  }

  bool hasPImages() => _pImages != null;

  // "p_address" field.
  String? _pAddress;
  String get pAddress => _pAddress ?? '';
  set pAddress(String? val) => _pAddress = val;

  bool hasPAddress() => _pAddress != null;

  // "p_name" field.
  String? _pName;
  String get pName => _pName ?? '';
  set pName(String? val) => _pName = val;

  bool hasPName() => _pName != null;

  // "p_location_type" field.
  String? _pLocationType;
  String get pLocationType => _pLocationType ?? '';
  set pLocationType(String? val) => _pLocationType = val;

  bool hasPLocationType() => _pLocationType != null;

  static PayloadUpdateJobStruct fromMap(Map<String, dynamic> data) =>
      PayloadUpdateJobStruct(
        pJobId: data['p_job_id'] as String?,
        pUserId: data['p_user_id'] as String?,
        pJobTitle: data['p_job_title'] as String?,
        pDescription: data['p_description'] as String?,
        pBudgetMin: data['p_budget_min'] as String?,
        pLat: castToType<double>(data['p_lat']),
        pLng: castToType<double>(data['p_lng']),
        pCity: data['p_city'] as String?,
        pState: data['p_state'] as String?,
        pZipcode: data['p_zipcode'] as String?,
        pCountry: data['p_country'] as String?,
        pCategory: data['p_category'] as String?,
        pTotalQuotes: castToType<int>(data['p_total_quotes']),
        pImages: getDataList(data['p_images']),
        pAddress: data['p_address'] as String?,
        pName: data['p_name'] as String?,
        pLocationType: data['p_location_type'] as String?,
      );

  static PayloadUpdateJobStruct? maybeFromMap(dynamic data) => data is Map
      ? PayloadUpdateJobStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'p_job_id': _pJobId,
        'p_user_id': _pUserId,
        'p_job_title': _pJobTitle,
        'p_description': _pDescription,
        'p_budget_min': _pBudgetMin,
        'p_lat': _pLat,
        'p_lng': _pLng,
        'p_city': _pCity,
        'p_state': _pState,
        'p_zipcode': _pZipcode,
        'p_country': _pCountry,
        'p_category': _pCategory,
        'p_total_quotes': _pTotalQuotes,
        'p_images': _pImages,
        'p_address': _pAddress,
        'p_name': _pName,
        'p_location_type': _pLocationType,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'p_job_id': serializeParam(
          _pJobId,
          ParamType.String,
        ),
        'p_user_id': serializeParam(
          _pUserId,
          ParamType.String,
        ),
        'p_job_title': serializeParam(
          _pJobTitle,
          ParamType.String,
        ),
        'p_description': serializeParam(
          _pDescription,
          ParamType.String,
        ),
        'p_budget_min': serializeParam(
          _pBudgetMin,
          ParamType.String,
        ),
        'p_lat': serializeParam(
          _pLat,
          ParamType.double,
        ),
        'p_lng': serializeParam(
          _pLng,
          ParamType.double,
        ),
        'p_city': serializeParam(
          _pCity,
          ParamType.String,
        ),
        'p_state': serializeParam(
          _pState,
          ParamType.String,
        ),
        'p_zipcode': serializeParam(
          _pZipcode,
          ParamType.String,
        ),
        'p_country': serializeParam(
          _pCountry,
          ParamType.String,
        ),
        'p_category': serializeParam(
          _pCategory,
          ParamType.String,
        ),
        'p_total_quotes': serializeParam(
          _pTotalQuotes,
          ParamType.int,
        ),
        'p_images': serializeParam(
          _pImages,
          ParamType.String,
          isList: true,
        ),
        'p_address': serializeParam(
          _pAddress,
          ParamType.String,
        ),
        'p_name': serializeParam(
          _pName,
          ParamType.String,
        ),
        'p_location_type': serializeParam(
          _pLocationType,
          ParamType.String,
        ),
      }.withoutNulls;

  static PayloadUpdateJobStruct fromSerializableMap(
          Map<String, dynamic> data) =>
      PayloadUpdateJobStruct(
        pJobId: deserializeParam(
          data['p_job_id'],
          ParamType.String,
          false,
        ),
        pUserId: deserializeParam(
          data['p_user_id'],
          ParamType.String,
          false,
        ),
        pJobTitle: deserializeParam(
          data['p_job_title'],
          ParamType.String,
          false,
        ),
        pDescription: deserializeParam(
          data['p_description'],
          ParamType.String,
          false,
        ),
        pBudgetMin: deserializeParam(
          data['p_budget_min'],
          ParamType.String,
          false,
        ),
        pLat: deserializeParam(
          data['p_lat'],
          ParamType.double,
          false,
        ),
        pLng: deserializeParam(
          data['p_lng'],
          ParamType.double,
          false,
        ),
        pCity: deserializeParam(
          data['p_city'],
          ParamType.String,
          false,
        ),
        pState: deserializeParam(
          data['p_state'],
          ParamType.String,
          false,
        ),
        pZipcode: deserializeParam(
          data['p_zipcode'],
          ParamType.String,
          false,
        ),
        pCountry: deserializeParam(
          data['p_country'],
          ParamType.String,
          false,
        ),
        pCategory: deserializeParam(
          data['p_category'],
          ParamType.String,
          false,
        ),
        pTotalQuotes: deserializeParam(
          data['p_total_quotes'],
          ParamType.int,
          false,
        ),
        pImages: deserializeParam<String>(
          data['p_images'],
          ParamType.String,
          true,
        ),
        pAddress: deserializeParam(
          data['p_address'],
          ParamType.String,
          false,
        ),
        pName: deserializeParam(
          data['p_name'],
          ParamType.String,
          false,
        ),
        pLocationType: deserializeParam(
          data['p_location_type'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'PayloadUpdateJobStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    const listEquality = ListEquality();
    return other is PayloadUpdateJobStruct &&
        pJobId == other.pJobId &&
        pUserId == other.pUserId &&
        pJobTitle == other.pJobTitle &&
        pDescription == other.pDescription &&
        pBudgetMin == other.pBudgetMin &&
        pLat == other.pLat &&
        pLng == other.pLng &&
        pCity == other.pCity &&
        pState == other.pState &&
        pZipcode == other.pZipcode &&
        pCountry == other.pCountry &&
        pCategory == other.pCategory &&
        pTotalQuotes == other.pTotalQuotes &&
        listEquality.equals(pImages, other.pImages) &&
        pAddress == other.pAddress &&
        pName == other.pName &&
        pLocationType == other.pLocationType;
  }

  @override
  int get hashCode => const ListEquality().hash([
        pJobId,
        pUserId,
        pJobTitle,
        pDescription,
        pBudgetMin,
        pLat,
        pLng,
        pCity,
        pState,
        pZipcode,
        pCountry,
        pCategory,
        pTotalQuotes,
        pImages,
        pAddress,
        pName,
        pLocationType
      ]);
}

PayloadUpdateJobStruct createPayloadUpdateJobStruct({
  String? pJobId,
  String? pUserId,
  String? pJobTitle,
  String? pDescription,
  String? pBudgetMin,
  double? pLat,
  double? pLng,
  String? pCity,
  String? pState,
  String? pZipcode,
  String? pCountry,
  String? pCategory,
  int? pTotalQuotes,
  String? pAddress,
  String? pName,
  String? pLocationType,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    PayloadUpdateJobStruct(
      pJobId: pJobId,
      pUserId: pUserId,
      pJobTitle: pJobTitle,
      pDescription: pDescription,
      pBudgetMin: pBudgetMin,
      pLat: pLat,
      pLng: pLng,
      pCity: pCity,
      pState: pState,
      pZipcode: pZipcode,
      pCountry: pCountry,
      pCategory: pCategory,
      pTotalQuotes: pTotalQuotes,
      pAddress: pAddress,
      pName: pName,
      pLocationType: pLocationType,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

PayloadUpdateJobStruct? updatePayloadUpdateJobStruct(
  PayloadUpdateJobStruct? payloadUpdateJob, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    payloadUpdateJob
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addPayloadUpdateJobStructData(
  Map<String, dynamic> firestoreData,
  PayloadUpdateJobStruct? payloadUpdateJob,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (payloadUpdateJob == null) {
    return;
  }
  if (payloadUpdateJob.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && payloadUpdateJob.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final payloadUpdateJobData =
      getPayloadUpdateJobFirestoreData(payloadUpdateJob, forFieldValue);
  final nestedData =
      payloadUpdateJobData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = payloadUpdateJob.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getPayloadUpdateJobFirestoreData(
  PayloadUpdateJobStruct? payloadUpdateJob, [
  bool forFieldValue = false,
]) {
  if (payloadUpdateJob == null) {
    return {};
  }
  final firestoreData = mapToFirestore(payloadUpdateJob.toMap());

  // Add any Firestore field values
  mapToFirestore(payloadUpdateJob.firestoreUtilData.fieldValues)
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getPayloadUpdateJobListFirestoreData(
  List<PayloadUpdateJobStruct>? payloadUpdateJobs,
) =>
    payloadUpdateJobs
        ?.map((e) => getPayloadUpdateJobFirestoreData(e, true))
        .toList() ??
    [];
