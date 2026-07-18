// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/models/util/firestore_util.dart';
import '/models/util/schema_util.dart';
import '/utils/enums/enums.dart';

import '/models/structs/index.dart';
import '/utils/util.dart';

class JobsListItemStruct extends AppFirebaseStruct {
  JobsListItemStruct({
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
    List<ProposalsForThisJobStruct>? applications,
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
        _applications = applications,
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

  // "applications" field.
  List<ProposalsForThisJobStruct>? _applications;
  List<ProposalsForThisJobStruct> get applications => _applications ?? const [];
  set applications(List<ProposalsForThisJobStruct>? val) => _applications = val;

  void updateApplications(Function(List<ProposalsForThisJobStruct>) updateFn) {
    updateFn(_applications ??= []);
  }

  bool hasApplications() => _applications != null;

  static JobsListItemStruct fromMap(Map<String, dynamic> data) =>
      JobsListItemStruct(
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
        applications: getStructList(
          data['applications'],
          ProposalsForThisJobStruct.fromMap,
        ),
      );

  static JobsListItemStruct? maybeFromMap(dynamic data) => data is Map
      ? JobsListItemStruct.fromMap(data.cast<String, dynamic>())
      : null;

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
        'applications': _applications?.map((e) => e.toMap()).toList(),
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
        'applications': serializeParam(
          _applications,
          ParamType.DataStruct,
          isList: true,
        ),
      }.withoutNulls;

  static JobsListItemStruct fromSerializableMap(Map<String, dynamic> data) =>
      JobsListItemStruct(
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
        applications: deserializeStructParam<ProposalsForThisJobStruct>(
          data['applications'],
          ParamType.DataStruct,
          true,
          structBuilder: ProposalsForThisJobStruct.fromSerializableMap,
        ),
      );

  @override
  String toString() => 'JobsListItemStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    const listEquality = ListEquality();
    return other is JobsListItemStruct &&
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
        listEquality.equals(applications, other.applications);
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
        applications
      ]);
}

JobsListItemStruct createJobsListItemStruct({
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
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    JobsListItemStruct(
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
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

JobsListItemStruct? updateJobsListItemStruct(
  JobsListItemStruct? jobsListItem, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    jobsListItem
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addJobsListItemStructData(
  Map<String, dynamic> firestoreData,
  JobsListItemStruct? jobsListItem,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (jobsListItem == null) {
    return;
  }
  if (jobsListItem.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && jobsListItem.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final jobsListItemData =
      getJobsListItemFirestoreData(jobsListItem, forFieldValue);
  final nestedData =
      jobsListItemData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = jobsListItem.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getJobsListItemFirestoreData(
  JobsListItemStruct? jobsListItem, [
  bool forFieldValue = false,
]) {
  if (jobsListItem == null) {
    return {};
  }
  final firestoreData = mapToFirestore(jobsListItem.toMap());

  // Add any Firestore field values
  mapToFirestore(jobsListItem.firestoreUtilData.fieldValues)
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getJobsListItemListFirestoreData(
  List<JobsListItemStruct>? jobsListItems,
) =>
    jobsListItems?.map((e) => getJobsListItemFirestoreData(e, true)).toList() ??
    [];
