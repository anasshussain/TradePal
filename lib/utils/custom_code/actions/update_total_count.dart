import '/repositories/backend.dart';
import '/models/structs/index.dart';
import '/utils/enums/enums.dart';
import '/repositories/supabase/supabase.dart';
import '/utils/action_blocks/actions.dart' as action_blocks;
import '/core/theme/app_theme.dart';
import '/utils/util.dart';
import '/utils/custom_code/actions/index.dart'; // Imports other custom actions
import '/utils/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

Future updateTotalCount(int? value) async {
  final countToSubtract = value ?? 0;

  AppState().totalMessagesCount =
      (AppState().totalMessagesCount - countToSubtract).clamp(0, 999999);
      debugPrint('Updated totalMessagesCount: ${AppState().totalMessagesCount}');
}
