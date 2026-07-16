import '../database.dart';

class StripeAccountsTable extends SupabaseTable<StripeAccountsRow> {
  @override
  String get tableName => 'stripe_accounts';

  @override
  StripeAccountsRow createRow(Map<String, dynamic> data) =>
      StripeAccountsRow(data);
}

class StripeAccountsRow extends SupabaseDataRow {
  StripeAccountsRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => StripeAccountsTable();

  String? get id => getField<String>('id');
  set id(String? value) => setField<String>('id', value);

  String get userId => getField<String>('user_id')!;
  set userId(String value) => setField<String>('user_id', value);

  String get stripeAccountId => getField<String>('stripe_account_id')!;
  set stripeAccountId(String value) =>
      setField<String>('stripe_account_id', value);

  bool? get chargesEnabled => getField<bool>('charges_enabled');
  set chargesEnabled(bool? value) => setField<bool>('charges_enabled', value);

  bool? get payoutsEnabled => getField<bool>('payouts_enabled');
  set payoutsEnabled(bool? value) => setField<bool>('payouts_enabled', value);
}
