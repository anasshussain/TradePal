import '/repositories/supabase/database/database.dart';

class InsurancePoliciesTable extends SupabaseTable<InsurancePoliciesRow> {
  @override
  String get tableName => 'insurance_policies';

  @override
  InsurancePoliciesRow createRow(Map<String, dynamic> data) =>
      InsurancePoliciesRow(data);
}

class InsurancePoliciesRow extends SupabaseDataRow {
  InsurancePoliciesRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => InsurancePoliciesTable();

  String? get id => getField<String>('id');
  set id(String? value) => setField<String>('id', value);

  String? get userId => getField<String>('user_id');
  set userId(String? value) => setField<String>('user_id', value);

  String? get providerName => getField<String>('provider_name');
  set providerName(String? value) => setField<String>('provider_name', value);

  String? get policyNumber => getField<String>('policy_number');
  set policyNumber(String? value) => setField<String>('policy_number', value);

  String? get coverageType => getField<String>('coverage_type');
  set coverageType(String? value) => setField<String>('coverage_type', value);

  double? get coverageAmount => getField<double>('coverage_amount');
  set coverageAmount(double? value) =>
      setField<double>('coverage_amount', value);

  DateTime? get startDate => getField<DateTime>('start_date');
  set startDate(DateTime? value) => setField<DateTime>('start_date', value);

  DateTime? get expiryDate => getField<DateTime>('expiry_date');
  set expiryDate(DateTime? value) => setField<DateTime>('expiry_date', value);

  String? get documentUrl => getField<String>('document_url');
  set documentUrl(String? value) => setField<String>('document_url', value);

  String? get verificationStatus => getField<String>('verification_status');
  set verificationStatus(String? value) =>
      setField<String>('verification_status', value);

  DateTime? get createdAt => getField<DateTime>('created_at');
  set createdAt(DateTime? value) => setField<DateTime>('created_at', value);
}
