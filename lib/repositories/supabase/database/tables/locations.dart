import '/repositories/supabase/database/database.dart';

class LocationsTable extends SupabaseTable<LocationsRow> {
  @override
  String get tableName => 'locations';

  @override
  LocationsRow createRow(Map<String, dynamic> data) => LocationsRow(data);
}

class LocationsRow extends SupabaseDataRow {
  LocationsRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => LocationsTable();

  String? get id => getField<String>('id');
  set id(String? value) => setField<String>('id', value);

  String? get city => getField<String>('city');
  set city(String? value) => setField<String>('city', value);

  String? get state => getField<String>('state');
  set state(String? value) => setField<String>('state', value);

  String? get zipCode => getField<String>('zipCode');
  set zipCode(String? value) => setField<String>('zipCode', value);

  String? get country => getField<String>('country');
  set country(String? value) => setField<String>('country', value);

  double? get lat => getField<double>('lat');
  set lat(double? value) => setField<double>('lat', value);

  double? get lng => getField<double>('lng');
  set lng(double? value) => setField<double>('lng', value);

  String? get userId => getField<String>('user_id');
  set userId(String? value) => setField<String>('user_id', value);

  String? get locationType => getField<String>('location_type');
  set locationType(String? value) => setField<String>('location_type', value);

  String? get name => getField<String>('name');
  set name(String? value) => setField<String>('name', value);

  String? get address => getField<String>('address');
  set address(String? value) => setField<String>('address', value);
}
