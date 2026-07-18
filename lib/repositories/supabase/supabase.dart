import 'package:supabase_flutter/supabase_flutter.dart' hide Provider;
import '/utils/util.dart';

export '/repositories/supabase/database/database.dart';
export '/repositories/supabase/storage/storage.dart';

String _kSupabaseUrl = 'https://ykwdjdyhbujnqeytkbmk.supabase.co';
String _kSupabaseAnonKey =
    'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Inlrd2RqZHloYnVqbnFleXRrYm1rIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NzE5MTQ2OTUsImV4cCI6MjA4NzQ5MDY5NX0.rZ31XNG9-SVgP8zeq_d7k6w99PdxvkGpVBlDH0j35TY';

class SupaFlow {
  SupaFlow._();

  static SupaFlow? _instance;
  static SupaFlow get instance => _instance ??= SupaFlow._();

  final _supabase = Supabase.instance.client;
  static SupabaseClient get client => instance._supabase;

  static Future initialize() => Supabase.initialize(
        url: _kSupabaseUrl,
        headers: {
          'X-Client-Info': 'my_trade_pal',
        },
        anonKey: _kSupabaseAnonKey,
        debug: false,
        authOptions:
            FlutterAuthClientOptions(authFlowType: AuthFlowType.implicit),
      );
}
