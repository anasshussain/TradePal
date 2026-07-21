import '/repositories/supabase/database/database.dart';

class JobTradesTable extends SupabaseTable<JobTradesRow> {
  @override
  String get tableName => 'job_trades';

  @override
  JobTradesRow createRow(Map<String, dynamic> data) => JobTradesRow(data);
}

class JobTradesRow extends SupabaseDataRow {
  JobTradesRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => JobTradesTable();

  String get jobId => getField<String>('job_id')!;
  set jobId(String value) => setField<String>('job_id', value);

  String get tradeId => getField<String>('trade_id')!;
  set tradeId(String value) => setField<String>('trade_id', value);
}
