import '/auth/supabase_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/backend/schema/structs/index.dart';
import '/theme/app_theme.dart';
import '/core/util.dart';
import '/widgets/app_button.dart';
import 'dart:ui';
import '/custom_code/actions/index.dart' as actions;
import '/index.dart';
import 'dart:math' as math;
import 'splash_screen_widget.dart' show SplashScreenWidget;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class SplashScreenModel extends AppModel<SplashScreenWidget> {
  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Backend Call - API (get user)] action in splash_screen widget.
  ApiCallResponse? apiResultUserProfile;
  // Stores action output result for [Backend Call - API (get total unread)] action in splash_screen widget.
  ApiCallResponse? totalCount;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
