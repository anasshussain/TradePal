import '/auth/supabase_auth/auth_util.dart';
import '/repositories/api_requests/api_calls.dart';
import '/models/structs/index.dart';
import '/core/theme/app_theme.dart';
import '/utils/util.dart';
import '/widgets/app_button.dart';
import 'dart:ui';
import '/utils/custom_code/actions/index.dart' as actions;
import '/core/routes/index.dart';
import 'dart:math' as math;
import '/auth/splash_screen/splash_screen_widget.dart' show SplashScreenWidget;
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
