// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';
import '/backend/schema/enums/enums.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class JobDataStruct extends FFFirebaseStruct {
  JobDataStruct({
    String? id,
    String? customerId,
    String? title,
    String? description,
    double? budgetMin,
    double? budgetMax,
    Status? status,
    String? assignedTradespersonId,
    String? createdAt,
    String? updatedAt,
    String? category,
    int? totalQuotes,
    List<String>? images,
    String? locationId,
    TradespersonStruct? tradesperson,
    CustomerStruct? customer,
    List<ReviewStruct>? review,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _id = id,
        _customerId = customerId,
        _title = title,
        _description = description,
        _budgetMin = budgetMin,
        _budgetMax = budgetMax,
        _status = status,
        _assignedTradespersonId = assignedTradespersonId,
        _createdAt = createdAt,
        _updatedAt = updatedAt,
        _category = category,
        _totalQuotes = totalQuotes,
        _images = images,
        _locationId = locationId,
        _tradesperson = tradesperson,
        _customer = customer,
        _review = review,
        super(firestoreUtilData);

  // "id" field.
  String? _id;
  String get id => _id ?? '';
  set id(String? val) => _id = val;

  bool hasId() => _id != null;

  // "customer_id" field.
  String? _customerId;
  String get customerId => _customerId ?? '';
  set customerId(String? val) => _customerId = val;

  bool hasCustomerId() => _customerId != null;

  // "title" field.
  String? _title;
  String get title => _title ?? '';
  set title(String? val) => _title = val;

  bool hasTitle() => _title != null;

  // "description" field.
  String? _description;
  String get description => _description ?? '';
  set description(String? val) => _description = val;

  bool hasDescription() => _description != null;

  // "budget_min" field.
  double? _budgetMin;
  double get budgetMin => _budgetMin ?? 0.0;
  set budgetMin(double? val) => _budgetMin = val;

  void incrementBudgetMin(double amount) => budgetMin = budgetMin + amount;

  bool hasBudgetMin() => _budgetMin != null;

  // "budget_max" field.
  double? _budgetMax;
  double get budgetMax => _budgetMax ?? 0.0;
  set budgetMax(double? val) => _budgetMax = val;

  void incrementBudgetMax(double amount) => budgetMax = budgetMax + amount;

  bool hasBudgetMax() => _budgetMax != null;

  // "status" field.
  Status? _status;
  Status? get status => _status;
  set status(Status? val) => _status = val;

  bool hasStatus() => _status != null;

  // "assigned_tradesperson_id" field.
  String? _assignedTradespersonId;
  String get assignedTradespersonId => _assignedTradespersonId ?? '';
  set assignedTradespersonId(String? val) => _assignedTradespersonId = val;

  bool hasAssignedTradespersonId() => _assignedTradespersonId != null;

  // "created_at" field.
  String? _createdAt;
  String get createdAt => _createdAt ?? '';
  set createdAt(String? val) => _createdAt = val;

  bool hasCreatedAt() => _createdAt != null;

  // "updated_at" field.
  String? _updatedAt;
  String get updatedAt => _updatedAt ?? '';
  set updatedAt(String? val) => _updatedAt = val;

  bool hasUpdatedAt() => _updatedAt != null;

  // "category" field.
  String? _category;
  String get category => _category ?? '';
  set category(String? val) => _category = val;

  bool hasCategory() => _category != null;

  // "total_quotes" field.
  int? _totalQuotes;
  int get totalQuotes => _totalQuotes ?? 0;
  set totalQuotes(int? val) => _totalQuotes = val;

  void incrementTotalQuotes(int amount) => totalQuotes = totalQuotes + amount;

  bool hasTotalQuotes() => _totalQuotes != null;

  // "images" field.
  List<String>? _images;
  List<String> get images => _images ?? const [];
  set images(List<String>? val) => _images = val;

  void updateImages(Function(List<String>) updateFn) {
    updateFn(_images ??= []);
  }

  bool hasImages() => _images != null;

  // "location_id" field.
  String? _locationId;
  String get locationId => _locationId ?? '';
  set locationId(String? val) => _locationId = val;

  bool hasLocationId() => _locationId != null;

  // "tradesperson" field.
  TradespersonStruct? _tradesperson;
  TradespersonStruct get tradesperson => _tradesperson ?? TradespersonStruct();
  set tradesperson(TradespersonStruct? val) => _tradesperson = val;

  void updateTradesperson(Function(TradespersonStruct) updateFn) {
    updateFn(_tradesperson ??= TradespersonStruct());
  }

  bool hasTradesperson() => _tradesperson != null;

  // "customer" field.
  CustomerStruct? _customer;
  CustomerStruct get customer => _customer ?? CustomerStruct();
  set customer(CustomerStruct? val) => _customer = val;

  void updateCustomer(Function(CustomerStruct) updateFn) {
    updateFn(_customer ??= CustomerStruct());
  }

  bool hasCustomer() => _customer != null;

  // "review" field.
  List<ReviewStruct>? _review;
  List<ReviewStruct> get review => _review ?? const [];
  set review(List<ReviewStruct>? val) => _review = val;

  void updateReview(Function(List<ReviewStruct>) updateFn) {
    updateFn(_review ??= []);
  }

  bool hasReview() => _review != null;

  static JobDataStruct fromMap(Map<String, dynamic> data) => JobDataStruct(
        id: data['id'] as String?,
        customerId: data['customer_id'] as String?,
        title: data['title'] as String?,
        description: data['description'] as String?,
        budgetMin: castToType<double>(data['budget_min']),
        budgetMax: castToType<double>(data['budget_max']),
        status: data['status'] is Status
            ? data['status']
            : deserializeEnum<Status>(data['status']),
        assignedTradespersonId: data['assigned_tradesperson_id'] as String?,
        createdAt: data['created_at'] as String?,
        updatedAt: data['updated_at'] as String?,
        category: data['category'] as String?,
        totalQuotes: castToType<int>(data['total_quotes']),
        images: getDataList(data['images']),
        locationId: data['location_id'] as String?,
        tradesperson: data['tradesperson'] is TradespersonStruct
            ? data['tradesperson']
            : TradespersonStruct.maybeFromMap(data['tradesperson']),
        customer: data['customer'] is CustomerStruct
            ? data['customer']
            : CustomerStruct.maybeFromMap(data['customer']),
        review: getStructList(
          data['review'],
          ReviewStruct.fromMap,
        ),
      );

  static JobDataStruct? maybeFromMap(dynamic data) =>
      data is Map ? JobDataStruct.fromMap(data.cast<String, dynamic>()) : null;

  Map<String, dynamic> toMap() => {
        'id': _id,
        'customer_id': _customerId,
        'title': _title,
        'description': _description,
        'budget_min': _budgetMin,
        'budget_max': _budgetMax,
        'status': _status?.serialize(),
        'assigned_tradesperson_id': _assignedTradespersonId,
        'created_at': _createdAt,
        'updated_at': _updatedAt,
        'category': _category,
        'total_quotes': _totalQuotes,
        'images': _images,
        'location_id': _locationId,
        'tradesperson': _tradesperson?.toMap(),
        'customer': _customer?.toMap(),
        'review': _review?.map((e) => e.toMap()).toList(),
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'id': serializeParam(
          _id,
          ParamType.String,
        ),
        'customer_id': serializeParam(
          _customerId,
          ParamType.String,
        ),
        'title': serializeParam(
          _title,
          ParamType.String,
        ),
        'description': serializeParam(
          _description,
          ParamType.String,
        ),
        'budget_min': serializeParam(
          _budgetMin,
          ParamType.double,
        ),
        'budget_max': serializeParam(
          _budgetMax,
          ParamType.double,
        ),
        'status': serializeParam(
          _status,
          ParamType.Enum,
        ),
        'assigned_tradesperson_id': serializeParam(
          _assignedTradespersonId,
          ParamType.String,
        ),
        'created_at': serializeParam(
          _createdAt,
          ParamType.String,
        ),
        'updated_at': serializeParam(
          _updatedAt,
          ParamType.String,
        ),
        'category': serializeParam(
          _category,
          ParamType.String,
        ),
        'total_quotes': serializeParam(
          _totalQuotes,
          ParamType.int,
        ),
        'images': serializeParam(
          _images,
          ParamType.String,
          isList: true,
        ),
        'location_id': serializeParam(
          _locationId,
          ParamType.String,
        ),
        'tradesperson': serializeParam(
          _tradesperson,
          ParamType.DataStruct,
        ),
        'customer': serializeParam(
          _customer,
          ParamType.DataStruct,
        ),
        'review': serializeParam(
          _review,
          ParamType.DataStruct,
          isList: true,
        ),
      }.withoutNulls;

  static JobDataStruct fromSerializableMap(Map<String, dynamic> data) =>
      JobDataStruct(
        id: deserializeParam(
          data['id'],
          ParamType.String,
          false,
        ),
        customerId: deserializeParam(
          data['customer_id'],
          ParamType.String,
          false,
        ),
        title: deserializeParam(
          data['title'],
          ParamType.String,
          false,
        ),
        description: deserializeParam(
          data['description'],
          ParamType.String,
          false,
        ),
        budgetMin: deserializeParam(
          data['budget_min'],
          ParamType.double,
          false,
        ),
        budgetMax: deserializeParam(
          data['budget_max'],
          ParamType.double,
          false,
        ),
        status: deserializeParam<Status>(
          data['status'],
          ParamType.Enum,
          false,
        ),
        assignedTradespersonId: deserializeParam(
          data['assigned_tradesperson_id'],
          ParamType.String,
          false,
        ),
        createdAt: deserializeParam(
          data['created_at'],
          ParamType.String,
          false,
        ),
        updatedAt: deserializeParam(
          data['updated_at'],
          ParamType.String,
          false,
        ),
        category: deserializeParam(
          data['category'],
          ParamType.String,
          false,
        ),
        totalQuotes: deserializeParam(
          data['total_quotes'],
          ParamType.int,
          false,
        ),
        images: deserializeParam<String>(
          data['images'],
          ParamType.String,
          true,
        ),
        locationId: deserializeParam(
          data['location_id'],
          ParamType.String,
          false,
        ),
        tradesperson: deserializeStructParam(
          data['tradesperson'],
          ParamType.DataStruct,
          false,
          structBuilder: TradespersonStruct.fromSerializableMap,
        ),
        customer: deserializeStructParam(
          data['customer'],
          ParamType.DataStruct,
          false,
          structBuilder: CustomerStruct.fromSerializableMap,
        ),
        review: deserializeStructParam<ReviewStruct>(
          data['review'],
          ParamType.DataStruct,
          true,
          structBuilder: ReviewStruct.fromSerializableMap,
        ),
      );

  @override
  String toString() => 'JobDataStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    const listEquality = ListEquality();
    return other is JobDataStruct &&
        id == other.id &&
        customerId == other.customerId &&
        title == other.title &&
        description == other.description &&
        budgetMin == other.budgetMin &&
        budgetMax == other.budgetMax &&
        status == other.status &&
        assignedTradespersonId == other.assignedTradespersonId &&
        createdAt == other.createdAt &&
        updatedAt == other.updatedAt &&
        category == other.category &&
        totalQuotes == other.totalQuotes &&
        listEquality.equals(images, other.images) &&
        locationId == other.locationId &&
        tradesperson == other.tradesperson &&
        customer == other.customer &&
        listEquality.equals(review, other.review);
  }

  @override
  int get hashCode => const ListEquality().hash([
        id,
        customerId,
        title,
        description,
        budgetMin,
        budgetMax,
        status,
        assignedTradespersonId,
        createdAt,
        updatedAt,
        category,
        totalQuotes,
        images,
        locationId,
        tradesperson,
        customer,
        review
      ]);
}

JobDataStruct createJobDataStruct({
  String? id,
  String? customerId,
  String? title,
  String? description,
  double? budgetMin,
  double? budgetMax,
  Status? status,
  String? assignedTradespersonId,
  String? createdAt,
  String? updatedAt,
  String? category,
  int? totalQuotes,
  String? locationId,
  TradespersonStruct? tradesperson,
  CustomerStruct? customer,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    JobDataStruct(
      id: id,
      customerId: customerId,
      title: title,
      description: description,
      budgetMin: budgetMin,
      budgetMax: budgetMax,
      status: status,
      assignedTradespersonId: assignedTradespersonId,
      createdAt: createdAt,
      updatedAt: updatedAt,
      category: category,
      totalQuotes: totalQuotes,
      locationId: locationId,
      tradesperson:
          tradesperson ?? (clearUnsetFields ? TradespersonStruct() : null),
      customer: customer ?? (clearUnsetFields ? CustomerStruct() : null),
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

JobDataStruct? updateJobDataStruct(
  JobDataStruct? jobData, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    jobData
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addJobDataStructData(
  Map<String, dynamic> firestoreData,
  JobDataStruct? jobData,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (jobData == null) {
    return;
  }
  if (jobData.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && jobData.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final jobDataData = getJobDataFirestoreData(jobData, forFieldValue);
  final nestedData = jobDataData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = jobData.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getJobDataFirestoreData(
  JobDataStruct? jobData, [
  bool forFieldValue = false,
]) {
  if (jobData == null) {
    return {};
  }
  final firestoreData = mapToFirestore(jobData.toMap());

  // Handle nested data for "tradesperson" field.
  addTradespersonStructData(
    firestoreData,
    jobData.hasTradesperson() ? jobData.tradesperson : null,
    'tradesperson',
    forFieldValue,
  );

  // Handle nested data for "customer" field.
  addCustomerStructData(
    firestoreData,
    jobData.hasCustomer() ? jobData.customer : null,
    'customer',
    forFieldValue,
  );

  // Add any Firestore field values
  mapToFirestore(jobData.firestoreUtilData.fieldValues)
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getJobDataListFirestoreData(
  List<JobDataStruct>? jobDatas,
) =>
    jobDatas?.map((e) => getJobDataFirestoreData(e, true)).toList() ?? [];
