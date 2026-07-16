// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';
import '/backend/schema/enums/enums.dart';

import 'index.dart';
import '/core/util.dart';

class JobsStruct extends AppFirebaseStruct {
  JobsStruct({
    String? id,
    String? title,
    List<String>? images,
    String? status,
    String? category,
    String? budgetMax,
    int? budgetMin,
    String? createdAt,
    String? updatedAt,
    String? customerId,
    String? description,
    String? locationId,
    int? totalQuotes,
    String? assignedTradespersonId,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _id = id,
        _title = title,
        _images = images,
        _status = status,
        _category = category,
        _budgetMax = budgetMax,
        _budgetMin = budgetMin,
        _createdAt = createdAt,
        _updatedAt = updatedAt,
        _customerId = customerId,
        _description = description,
        _locationId = locationId,
        _totalQuotes = totalQuotes,
        _assignedTradespersonId = assignedTradespersonId,
        super(firestoreUtilData);

  // "id" field.
  String? _id;
  String get id => _id ?? '';
  set id(String? val) => _id = val;

  bool hasId() => _id != null;

  // "title" field.
  String? _title;
  String get title => _title ?? '';
  set title(String? val) => _title = val;

  bool hasTitle() => _title != null;

  // "images" field.
  List<String>? _images;
  List<String> get images => _images ?? const [];
  set images(List<String>? val) => _images = val;

  void updateImages(Function(List<String>) updateFn) {
    updateFn(_images ??= []);
  }

  bool hasImages() => _images != null;

  // "status" field.
  String? _status;
  String get status => _status ?? '';
  set status(String? val) => _status = val;

  bool hasStatus() => _status != null;

  // "category" field.
  String? _category;
  String get category => _category ?? '';
  set category(String? val) => _category = val;

  bool hasCategory() => _category != null;

  // "budget_max" field.
  String? _budgetMax;
  String get budgetMax => _budgetMax ?? '';
  set budgetMax(String? val) => _budgetMax = val;

  bool hasBudgetMax() => _budgetMax != null;

  // "budget_min" field.
  int? _budgetMin;
  int get budgetMin => _budgetMin ?? 0;
  set budgetMin(int? val) => _budgetMin = val;

  void incrementBudgetMin(int amount) => budgetMin = budgetMin + amount;

  bool hasBudgetMin() => _budgetMin != null;

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

  // "customer_id" field.
  String? _customerId;
  String get customerId => _customerId ?? '';
  set customerId(String? val) => _customerId = val;

  bool hasCustomerId() => _customerId != null;

  // "description" field.
  String? _description;
  String get description => _description ?? '';
  set description(String? val) => _description = val;

  bool hasDescription() => _description != null;

  // "location_id" field.
  String? _locationId;
  String get locationId => _locationId ?? '';
  set locationId(String? val) => _locationId = val;

  bool hasLocationId() => _locationId != null;

  // "total_quotes" field.
  int? _totalQuotes;
  int get totalQuotes => _totalQuotes ?? 0;
  set totalQuotes(int? val) => _totalQuotes = val;

  void incrementTotalQuotes(int amount) => totalQuotes = totalQuotes + amount;

  bool hasTotalQuotes() => _totalQuotes != null;

  // "assigned_tradesperson_id" field.
  String? _assignedTradespersonId;
  String get assignedTradespersonId => _assignedTradespersonId ?? '';
  set assignedTradespersonId(String? val) => _assignedTradespersonId = val;

  bool hasAssignedTradespersonId() => _assignedTradespersonId != null;

  static JobsStruct fromMap(Map<String, dynamic> data) => JobsStruct(
        id: data['id'] as String?,
        title: data['title'] as String?,
        images: getDataList(data['images']),
        status: data['status'] as String?,
        category: data['category'] as String?,
        budgetMax: data['budget_max'] as String?,
        budgetMin: castToType<int>(data['budget_min']),
        createdAt: data['created_at'] as String?,
        updatedAt: data['updated_at'] as String?,
        customerId: data['customer_id'] as String?,
        description: data['description'] as String?,
        locationId: data['location_id'] as String?,
        totalQuotes: castToType<int>(data['total_quotes']),
        assignedTradespersonId: data['assigned_tradesperson_id'] as String?,
      );

  static JobsStruct? maybeFromMap(dynamic data) =>
      data is Map ? JobsStruct.fromMap(data.cast<String, dynamic>()) : null;

  Map<String, dynamic> toMap() => {
        'id': _id,
        'title': _title,
        'images': _images,
        'status': _status,
        'category': _category,
        'budget_max': _budgetMax,
        'budget_min': _budgetMin,
        'created_at': _createdAt,
        'updated_at': _updatedAt,
        'customer_id': _customerId,
        'description': _description,
        'location_id': _locationId,
        'total_quotes': _totalQuotes,
        'assigned_tradesperson_id': _assignedTradespersonId,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'id': serializeParam(
          _id,
          ParamType.String,
        ),
        'title': serializeParam(
          _title,
          ParamType.String,
        ),
        'images': serializeParam(
          _images,
          ParamType.String,
          isList: true,
        ),
        'status': serializeParam(
          _status,
          ParamType.String,
        ),
        'category': serializeParam(
          _category,
          ParamType.String,
        ),
        'budget_max': serializeParam(
          _budgetMax,
          ParamType.String,
        ),
        'budget_min': serializeParam(
          _budgetMin,
          ParamType.int,
        ),
        'created_at': serializeParam(
          _createdAt,
          ParamType.String,
        ),
        'updated_at': serializeParam(
          _updatedAt,
          ParamType.String,
        ),
        'customer_id': serializeParam(
          _customerId,
          ParamType.String,
        ),
        'description': serializeParam(
          _description,
          ParamType.String,
        ),
        'location_id': serializeParam(
          _locationId,
          ParamType.String,
        ),
        'total_quotes': serializeParam(
          _totalQuotes,
          ParamType.int,
        ),
        'assigned_tradesperson_id': serializeParam(
          _assignedTradespersonId,
          ParamType.String,
        ),
      }.withoutNulls;

  static JobsStruct fromSerializableMap(Map<String, dynamic> data) =>
      JobsStruct(
        id: deserializeParam(
          data['id'],
          ParamType.String,
          false,
        ),
        title: deserializeParam(
          data['title'],
          ParamType.String,
          false,
        ),
        images: deserializeParam<String>(
          data['images'],
          ParamType.String,
          true,
        ),
        status: deserializeParam(
          data['status'],
          ParamType.String,
          false,
        ),
        category: deserializeParam(
          data['category'],
          ParamType.String,
          false,
        ),
        budgetMax: deserializeParam(
          data['budget_max'],
          ParamType.String,
          false,
        ),
        budgetMin: deserializeParam(
          data['budget_min'],
          ParamType.int,
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
        customerId: deserializeParam(
          data['customer_id'],
          ParamType.String,
          false,
        ),
        description: deserializeParam(
          data['description'],
          ParamType.String,
          false,
        ),
        locationId: deserializeParam(
          data['location_id'],
          ParamType.String,
          false,
        ),
        totalQuotes: deserializeParam(
          data['total_quotes'],
          ParamType.int,
          false,
        ),
        assignedTradespersonId: deserializeParam(
          data['assigned_tradesperson_id'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'JobsStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    const listEquality = ListEquality();
    return other is JobsStruct &&
        id == other.id &&
        title == other.title &&
        listEquality.equals(images, other.images) &&
        status == other.status &&
        category == other.category &&
        budgetMax == other.budgetMax &&
        budgetMin == other.budgetMin &&
        createdAt == other.createdAt &&
        updatedAt == other.updatedAt &&
        customerId == other.customerId &&
        description == other.description &&
        locationId == other.locationId &&
        totalQuotes == other.totalQuotes &&
        assignedTradespersonId == other.assignedTradespersonId;
  }

  @override
  int get hashCode => const ListEquality().hash([
        id,
        title,
        images,
        status,
        category,
        budgetMax,
        budgetMin,
        createdAt,
        updatedAt,
        customerId,
        description,
        locationId,
        totalQuotes,
        assignedTradespersonId
      ]);
}

JobsStruct createJobsStruct({
  String? id,
  String? title,
  String? status,
  String? category,
  String? budgetMax,
  int? budgetMin,
  String? createdAt,
  String? updatedAt,
  String? customerId,
  String? description,
  String? locationId,
  int? totalQuotes,
  String? assignedTradespersonId,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    JobsStruct(
      id: id,
      title: title,
      status: status,
      category: category,
      budgetMax: budgetMax,
      budgetMin: budgetMin,
      createdAt: createdAt,
      updatedAt: updatedAt,
      customerId: customerId,
      description: description,
      locationId: locationId,
      totalQuotes: totalQuotes,
      assignedTradespersonId: assignedTradespersonId,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

JobsStruct? updateJobsStruct(
  JobsStruct? jobs, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    jobs
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addJobsStructData(
  Map<String, dynamic> firestoreData,
  JobsStruct? jobs,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (jobs == null) {
    return;
  }
  if (jobs.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields = !forFieldValue && jobs.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final jobsData = getJobsFirestoreData(jobs, forFieldValue);
  final nestedData = jobsData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = jobs.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getJobsFirestoreData(
  JobsStruct? jobs, [
  bool forFieldValue = false,
]) {
  if (jobs == null) {
    return {};
  }
  final firestoreData = mapToFirestore(jobs.toMap());

  // Add any Firestore field values
  mapToFirestore(jobs.firestoreUtilData.fieldValues)
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getJobsListFirestoreData(
  List<JobsStruct>? jobss,
) =>
    jobss?.map((e) => getJobsFirestoreData(e, true)).toList() ?? [];
