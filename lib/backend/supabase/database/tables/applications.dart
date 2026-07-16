import '../database.dart';

class ApplicationsTable extends SupabaseTable<ApplicationsRow> {
  @override
  String get tableName => 'applications';

  @override
  ApplicationsRow createRow(Map<String, dynamic> data) => ApplicationsRow(data);
}

class ApplicationsRow extends SupabaseDataRow {
  ApplicationsRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => ApplicationsTable();

  String? get id => getField<String>('id');
  set id(String? value) => setField<String>('id', value);

  String? get jobId => getField<String>('job_id');
  set jobId(String? value) => setField<String>('job_id', value);

  String? get tradespersonId => getField<String>('tradesperson_id');
  set tradespersonId(String? value) =>
      setField<String>('tradesperson_id', value);

  String? get message => getField<String>('message');
  set message(String? value) => setField<String>('message', value);

  double? get quoteAmount => getField<double>('quote_amount');
  set quoteAmount(double? value) => setField<double>('quote_amount', value);

  DateTime? get createdAt => getField<DateTime>('created_at');
  set createdAt(DateTime? value) => setField<DateTime>('created_at', value);

  String? get duration => getField<String>('duration');
  set duration(String? value) => setField<String>('duration', value);

  String? get status => getField<String>('status');
  set status(String? value) => setField<String>('status', value);
}
