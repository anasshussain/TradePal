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
// Custom Action: updateUserPassword

import 'package:supabase_flutter/supabase_flutter.dart';

/// Returns null on success, or a user-facing error message on failure (e.g.
/// Supabase rejects a new password that matches the current one with
/// "New password should be different from the old password.").
Future<String?> resetPassword(String newPassword) async {
  final supabase = Supabase.instance.client;

  try {
    await supabase.auth.updateUser(
      UserAttributes(password: newPassword),
    );

    return null;
  } on AuthException catch (e) {
    return e.message;
  } catch (e) {
    return 'Something went wrong. Please try again.';
  }
}
