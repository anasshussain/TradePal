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
