import '../database.dart';

class JobsTable extends SupabaseTable<JobsRow> {
  @override
  String get tableName => 'jobs';

  @override
  JobsRow createRow(Map<String, dynamic> data) => JobsRow(data);
}

class JobsRow extends SupabaseDataRow {
  JobsRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => JobsTable();

  String? get id => getField<String>('id');
  set id(String? value) => setField<String>('id', value);

  String? get customerId => getField<String>('customer_id');
  set customerId(String? value) => setField<String>('customer_id', value);

  String? get locationId => getField<String>('location_id');
  set locationId(String? value) => setField<String>('location_id', value);

  String get title => getField<String>('title')!;
  set title(String value) => setField<String>('title', value);

  String? get description => getField<String>('description');
  set description(String? value) => setField<String>('description', value);

  double? get budgetMin => getField<double>('budget_min');
  set budgetMin(double? value) => setField<double>('budget_min', value);

  double? get budgetMax => getField<double>('budget_max');
  set budgetMax(double? value) => setField<double>('budget_max', value);

  String? get assignedTradespersonId =>
      getField<String>('assigned_tradesperson_id');
  set assignedTradespersonId(String? value) =>
      setField<String>('assigned_tradesperson_id', value);

  DateTime? get createdAt => getField<DateTime>('created_at');
  set createdAt(DateTime? value) => setField<DateTime>('created_at', value);

  DateTime? get updatedAt => getField<DateTime>('updated_at');
  set updatedAt(DateTime? value) => setField<DateTime>('updated_at', value);

  int? get totalQuotes => getField<int>('total_quotes');
  set totalQuotes(int? value) => setField<int>('total_quotes', value);

  String? get category => getField<String>('category');
  set category(String? value) => setField<String>('category', value);

  List<String> get images => getListField<String>('images');
  set images(List<String>? value) => setListField<String>('images', value);

  String? get status => getField<String>('status');
  set status(String? value) => setField<String>('status', value);
}
