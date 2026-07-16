// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/backend/schema/enums/enums.dart';
import '/backend/supabase/supabase.dart';
import '/actions/actions.dart' as action_blocks;
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:go_router/go_router.dart';

Future checkUserSession(BuildContext context) async {
  final supabase = Supabase.instance.client;

  // 🧠 Check if app opened via reset password link
  supabase.auth.onAuthStateChange.listen((data) {
    final event = data.event;

    if (event == AuthChangeEvent.passwordRecovery) {
      // 🚀 Go to reset password screen
      context.go('/resetPassword');
      return;
    }
  });
  final session = supabase.auth.currentSession;

  // ❌ Not logged in
  if (session == null) {
    context.go('/login');
    return;
  }

  final userId = session.user.id;

  // 🔍 Fetch user data
  final response = await supabase
      .from('users')
      .select('email_verified, onboarding_step, user_role')
      .eq('id', userId)
      .maybeSingle();

  // ❗ If user not found → create
  if (response == null) {
    await supabase.from('users').insert({
      'id': userId,
      'email': session.user.email,
      'email_verified': false,
      'onboarding_step': 0,
      'user_role': 0,
    });

    context.go('/verifyEmail');
    return;
  }

  final bool isVerified = response['email_verified'] == true;
  final int onboardingStep = response['onboarding_step'] ?? 0;
  final int userRole = response['user_role'] ?? 0;

  // 🚫 Email not verified
  if (!isVerified) {
    context.go('/verifyEmail');
    return;
  }

  // 🧩 Onboarding flow
  if (onboardingStep == 0) {
    context.go('/choosePath');
    return;
  }

  if (onboardingStep == 1 && userRole == 0) {
    context.go('/choosePath');
    return;
  }

  // 🎯 Role selection

  //if (onboardingStep == 1) {
  // 🏁 Final destination
  if (userRole == 1) {
    context.go('/customerDashboard');
  } else if (userRole == 2) {
    context.go('/browseJobs');
  } else {
    // fallback (safety)
    context.go('/login');
  }
  // }
}
