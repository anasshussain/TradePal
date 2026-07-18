import '/repositories/supabase/database/database.dart';

class UserRolesTable extends SupabaseTable<UserRolesRow> {
  @override
  String get tableName => 'user_roles';

  @override
  UserRolesRow createRow(Map<String, dynamic> data) => UserRolesRow(data);
}

class UserRolesRow extends SupabaseDataRow {
  UserRolesRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => UserRolesTable();

  String get userId => getField<String>('user_id')!;
  set userId(String value) => setField<String>('user_id', value);

  int get roleId => getField<int>('role_id')!;
  set roleId(int value) => setField<int>('role_id', value);
}
