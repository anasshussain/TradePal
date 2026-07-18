import '/repositories/supabase/database/database.dart';

class TradesTable extends SupabaseTable<TradesRow> {
  @override
  String get tableName => 'trades';

  @override
  TradesRow createRow(Map<String, dynamic> data) => TradesRow(data);
}

class TradesRow extends SupabaseDataRow {
  TradesRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => TradesTable();

  String? get id => getField<String>('id');
  set id(String? value) => setField<String>('id', value);

  String get name => getField<String>('name')!;
  set name(String value) => setField<String>('name', value);

  String get slug => getField<String>('slug')!;
  set slug(String value) => setField<String>('slug', value);
}
