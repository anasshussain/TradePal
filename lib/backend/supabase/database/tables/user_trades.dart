import '../database.dart';

class UserTradesTable extends SupabaseTable<UserTradesRow> {
  @override
  String get tableName => 'user_trades';

  @override
  UserTradesRow createRow(Map<String, dynamic> data) => UserTradesRow(data);
}

class UserTradesRow extends SupabaseDataRow {
  UserTradesRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => UserTradesTable();

  String get userId => getField<String>('user_id')!;
  set userId(String value) => setField<String>('user_id', value);

  String get tradeId => getField<String>('trade_id')!;
  set tradeId(String value) => setField<String>('trade_id', value);
}
