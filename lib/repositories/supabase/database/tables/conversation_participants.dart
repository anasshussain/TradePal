import '/repositories/supabase/database/database.dart';

class ConversationParticipantsTable
    extends SupabaseTable<ConversationParticipantsRow> {
  @override
  String get tableName => 'conversation_participants';

  @override
  ConversationParticipantsRow createRow(Map<String, dynamic> data) =>
      ConversationParticipantsRow(data);
}

class ConversationParticipantsRow extends SupabaseDataRow {
  ConversationParticipantsRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => ConversationParticipantsTable();

  String? get id => getField<String>('id');
  set id(String? value) => setField<String>('id', value);

  String get conversationId => getField<String>('conversation_id')!;
  set conversationId(String value) =>
      setField<String>('conversation_id', value);

  String get userId => getField<String>('user_id')!;
  set userId(String value) => setField<String>('user_id', value);

  String? get role => getField<String>('role');
  set role(String? value) => setField<String>('role', value);

  DateTime? get createdAt => getField<DateTime>('created_at');
  set createdAt(DateTime? value) => setField<DateTime>('created_at', value);

  int? get unreadCount => getField<int>('unread_count');
  set unreadCount(int? value) => setField<int>('unread_count', value);

  DateTime? get lastReadAt => getField<DateTime>('last_read_at');
  set lastReadAt(DateTime? value) => setField<DateTime>('last_read_at', value);
}
