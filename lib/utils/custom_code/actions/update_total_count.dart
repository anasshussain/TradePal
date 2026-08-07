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

Future updateTotalCount(dynamic value) async {
  final countToSubtract = _coerceToInt(value) ?? 0;

  AppState().totalMessagesCount =
      (AppState().totalMessagesCount - countToSubtract).clamp(0, 999999);
  debugPrint('Updated totalMessagesCount: ${AppState().totalMessagesCount}');
}

int? _coerceToInt(dynamic value) {
  if (value == null) return null;
  if (value is int) return value;
  if (value is num) return value.toInt();
  if (value is String) return int.tryParse(value);
  if (value is List && value.isNotEmpty) return _coerceToInt(value.first);
  if (value is Map) {
    for (final key in ['count', 'unread_count', 'mark_conversation_read']) {
      if (value.containsKey(key)) return _coerceToInt(value[key]);
    }
    if (value.length == 1) return _coerceToInt(value.values.first);
  }
  return null;
}
