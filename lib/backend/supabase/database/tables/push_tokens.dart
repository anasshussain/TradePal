import '../database.dart';

class PushTokensTable extends SupabaseTable<PushTokensRow> {
  @override
  String get tableName => 'push_tokens';

  @override
  PushTokensRow createRow(Map<String, dynamic> data) => PushTokensRow(data);
}

class PushTokensRow extends SupabaseDataRow {
  PushTokensRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => PushTokensTable();

  String? get id => getField<String>('id');
  set id(String? value) => setField<String>('id', value);

  String? get userId => getField<String>('user_id');
  set userId(String? value) => setField<String>('user_id', value);

  String get token => getField<String>('token')!;
  set token(String value) => setField<String>('token', value);

  String? get deviceType => getField<String>('device_type');
  set deviceType(String? value) => setField<String>('device_type', value);

  DateTime? get createdAt => getField<DateTime>('created_at');
  set createdAt(DateTime? value) => setField<DateTime>('created_at', value);
}
