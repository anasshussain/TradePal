import '../database.dart';

class ProposalPaymentsTable extends SupabaseTable<ProposalPaymentsRow> {
  @override
  String get tableName => 'proposal_payments';

  @override
  ProposalPaymentsRow createRow(Map<String, dynamic> data) =>
      ProposalPaymentsRow(data);
}

class ProposalPaymentsRow extends SupabaseDataRow {
  ProposalPaymentsRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => ProposalPaymentsTable();

  String? get id => getField<String>('id');
  set id(String? value) => setField<String>('id', value);

  String get jobId => getField<String>('job_id')!;
  set jobId(String value) => setField<String>('job_id', value);

  String get tradepersonId => getField<String>('tradeperson_id')!;
  set tradepersonId(String value) => setField<String>('tradeperson_id', value);

  double get amount => getField<double>('amount')!;
  set amount(double value) => setField<double>('amount', value);

  String? get stripePaymentIntentId =>
      getField<String>('stripe_payment_intent_id');
  set stripePaymentIntentId(String? value) =>
      setField<String>('stripe_payment_intent_id', value);

  String? get paymentStatus => getField<String>('payment_status');
  set paymentStatus(String? value) => setField<String>('payment_status', value);

  DateTime? get createdAt => getField<DateTime>('created_at');
  set createdAt(DateTime? value) => setField<DateTime>('created_at', value);
}
