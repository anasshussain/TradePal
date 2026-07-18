import '/repositories/supabase/database/database.dart';

class PaymentsTable extends SupabaseTable<PaymentsRow> {
  @override
  String get tableName => 'payments';

  @override
  PaymentsRow createRow(Map<String, dynamic> data) => PaymentsRow(data);
}

class PaymentsRow extends SupabaseDataRow {
  PaymentsRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => PaymentsTable();

  String? get id => getField<String>('id');
  set id(String? value) => setField<String>('id', value);

  String? get jobId => getField<String>('job_id');
  set jobId(String? value) => setField<String>('job_id', value);

  String? get customerId => getField<String>('customer_id');
  set customerId(String? value) => setField<String>('customer_id', value);

  String? get tradespersonId => getField<String>('tradesperson_id');
  set tradespersonId(String? value) =>
      setField<String>('tradesperson_id', value);

  double? get amountTotal => getField<double>('amount_total');
  set amountTotal(double? value) => setField<double>('amount_total', value);

  double? get platformFee => getField<double>('platform_fee');
  set platformFee(double? value) => setField<double>('platform_fee', value);

  double? get tradespersonAmount => getField<double>('tradesperson_amount');
  set tradespersonAmount(double? value) =>
      setField<double>('tradesperson_amount', value);

  String? get paymentProvider => getField<String>('payment_provider');
  set paymentProvider(String? value) =>
      setField<String>('payment_provider', value);

  String? get stripePaymentIntent => getField<String>('stripe_payment_intent');
  set stripePaymentIntent(String? value) =>
      setField<String>('stripe_payment_intent', value);

  String? get status => getField<String>('status');
  set status(String? value) => setField<String>('status', value);

  DateTime? get createdAt => getField<DateTime>('created_at');
  set createdAt(DateTime? value) => setField<DateTime>('created_at', value);

  String? get stripeChargeId => getField<String>('stripe_charge_id');
  set stripeChargeId(String? value) =>
      setField<String>('stripe_charge_id', value);
}
