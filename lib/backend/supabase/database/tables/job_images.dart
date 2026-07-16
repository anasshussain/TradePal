import '../database.dart';

class JobImagesTable extends SupabaseTable<JobImagesRow> {
  @override
  String get tableName => 'job_images';

  @override
  JobImagesRow createRow(Map<String, dynamic> data) => JobImagesRow(data);
}

class JobImagesRow extends SupabaseDataRow {
  JobImagesRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => JobImagesTable();

  String? get id => getField<String>('id');
  set id(String? value) => setField<String>('id', value);

  String? get jobId => getField<String>('job_id');
  set jobId(String? value) => setField<String>('job_id', value);

  String get imageUrl => getField<String>('image_url')!;
  set imageUrl(String value) => setField<String>('image_url', value);
}
