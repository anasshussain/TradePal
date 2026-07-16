// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/backend/schema/enums/enums.dart';
import '/backend/supabase/supabase.dart';
import '/actions/actions.dart' as action_blocks;
import '/theme/app_theme.dart';
import '/core/util.dart';
import 'index.dart'; // Imports other custom actions
import '/core/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:supabase_flutter/supabase_flutter.dart';

/// Unsubscribes from a previously established real-time connection to a specified table in Supabase.
///
/// [table]: The name of the table from which to disconnect in the Supabase database.
Future<void> unsubscribe(String table) async {
  debugPrint("Unsubscribing table is ${table}");
  // Accessing the Supabase client and the specific channel for the table.
  await SupaFlow.client
      .channel('public:$table')
      // Unsubscribing from the channel.
      .unsubscribe();
}
