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

// Set your action name, define your arguments and return parameter,
// and then add the boilerplate code using the green button on the right!
bool isValidPassword(String password) {
  /// MODIFY CODE ONLY BELOW THIS LINE

  return hasMinLength(password) &&
      hasUppercase(password) &&
      hasLowercase(password) &&
      hasNumberOrSymbol(password);

  /// MODIFY CODE ONLY ABOVE THIS LINE
}
