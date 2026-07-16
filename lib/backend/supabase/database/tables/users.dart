import '../database.dart';

class UsersTable extends SupabaseTable<UsersRow> {
  @override
  String get tableName => 'users';

  @override
  UsersRow createRow(Map<String, dynamic> data) => UsersRow(data);
}

class UsersRow extends SupabaseDataRow {
  UsersRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => UsersTable();

  String? get id => getField<String>('id');
  set id(String? value) => setField<String>('id', value);

  String? get name => getField<String>('name');
  set name(String? value) => setField<String>('name', value);

  String? get email => getField<String>('email');
  set email(String? value) => setField<String>('email', value);

  String? get accountStatus => getField<String>('account_status');
  set accountStatus(String? value) => setField<String>('account_status', value);

  bool? get emailVerified => getField<bool>('email_verified');
  set emailVerified(bool? value) => setField<bool>('email_verified', value);

  String? get avatarUrl => getField<String>('avatar_url');
  set avatarUrl(String? value) => setField<String>('avatar_url', value);

  DateTime? get createdAt => getField<DateTime>('created_at');
  set createdAt(DateTime? value) => setField<DateTime>('created_at', value);

  bool? get insuranceVerified => getField<bool>('insurance_verified');
  set insuranceVerified(bool? value) =>
      setField<bool>('insurance_verified', value);

  String? get insuranceExpiry => getField<String>('insurance_expiry');
  set insuranceExpiry(String? value) =>
      setField<String>('insurance_expiry', value);

  int? get yearsExperience => getField<int>('years_experience');
  set yearsExperience(int? value) => setField<int>('years_experience', value);

  String? get qualifications => getField<String>('qualifications');
  set qualifications(String? value) =>
      setField<String>('qualifications', value);

  String? get userKey => getField<String>('user_key');
  set userKey(String? value) => setField<String>('user_key', value);

  int? get onboardingStep => getField<int>('onboarding_step');
  set onboardingStep(int? value) => setField<int>('onboarding_step', value);

  int? get userRole => getField<int>('user_role');
  set userRole(int? value) => setField<int>('user_role', value);

  String? get phone => getField<String>('phone');
  set phone(String? value) => setField<String>('phone', value);

  String? get street => getField<String>('street');
  set street(String? value) => setField<String>('street', value);

  String? get zipcode => getField<String>('zipcode');
  set zipcode(String? value) => setField<String>('zipcode', value);

  String? get insuranceCompany => getField<String>('insurance_company');
  set insuranceCompany(String? value) =>
      setField<String>('insurance_company', value);

  String? get registrationNumber => getField<String>('registration_number');
  set registrationNumber(String? value) =>
      setField<String>('registration_number', value);

  String? get serviceArea => getField<String>('service_area');
  set serviceArea(String? value) => setField<String>('service_area', value);

  String? get profession => getField<String>('profession');
  set profession(String? value) => setField<String>('profession', value);

  String? get insuranceAmount => getField<String>('insurance_amount');
  set insuranceAmount(String? value) =>
      setField<String>('insurance_amount', value);

  String? get about => getField<String>('about');
  set about(String? value) => setField<String>('about', value);

  String? get streetaddress => getField<String>('streetaddress');
  set streetaddress(String? value) => setField<String>('streetaddress', value);

  List<String> get skills => getListField<String>('skills');
  set skills(List<String>? value) => setListField<String>('skills', value);

  String? get deviceToken => getField<String>('device_token');
  set deviceToken(String? value) => setField<String>('device_token', value);
}
