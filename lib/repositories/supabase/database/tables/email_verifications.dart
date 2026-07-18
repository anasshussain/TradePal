import '/repositories/supabase/database/database.dart';

class EmailVerificationsTable extends SupabaseTable<EmailVerificationsRow> {
  @override
  String get tableName => 'email_verifications';

  @override
  EmailVerificationsRow createRow(Map<String, dynamic> data) =>
      EmailVerificationsRow(data);
}

class EmailVerificationsRow extends SupabaseDataRow {
  EmailVerificationsRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => EmailVerificationsTable();

  String? get id => getField<String>('id');
  set id(String? value) => setField<String>('id', value);

  String get email => getField<String>('email')!;
  set email(String value) => setField<String>('email', value);

  String get code => getField<String>('code')!;
  set code(String value) => setField<String>('code', value);

  DateTime get expiresAt => getField<DateTime>('expires_at')!;
  set expiresAt(DateTime value) => setField<DateTime>('expires_at', value);

  bool? get isUsed => getField<bool>('is_used');
  set isUsed(bool? value) => setField<bool>('is_used', value);

  DateTime? get createdAt => getField<DateTime>('created_at');
  set createdAt(DateTime? value) => setField<DateTime>('created_at', value);
}
