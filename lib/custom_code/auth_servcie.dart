import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import '../../app_state.dart';

class AuthService {
  final supabase = Supabase.instance.client;

  void initListener(BuildContext context) {
    supabase.auth.onAuthStateChange.listen((data) {
      final event = data.event;

      if (event == AuthChangeEvent.signedOut) {
        AppState.reset();
        context.go('/login');
      }

      if (event == AuthChangeEvent.passwordRecovery) {
        context.go('/resetPassword');
      }
    });
  }
}
