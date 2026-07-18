import '/repositories/supabase/database/database.dart';

class JobActivityTable extends SupabaseTable<JobActivityRow> {
  @override
  String get tableName => 'job_activity';

  @override
  JobActivityRow createRow(Map<String, dynamic> data) => JobActivityRow(data);
}

class JobActivityRow extends SupabaseDataRow {
  JobActivityRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => JobActivityTable();

  String? get id => getField<String>('id');
  set id(String? value) => setField<String>('id', value);

  String? get jobId => getField<String>('job_id');
  set jobId(String? value) => setField<String>('job_id', value);

  String? get actorId => getField<String>('actor_id');
  set actorId(String? value) => setField<String>('actor_id', value);

  String? get type => getField<String>('type');
  set type(String? value) => setField<String>('type', value);

  dynamic? get metadata => getField<dynamic>('metadata');
  set metadata(dynamic? value) => setField<dynamic>('metadata', value);

  DateTime? get createdAt => getField<DateTime>('created_at');
  set createdAt(DateTime? value) => setField<DateTime>('created_at', value);
}
