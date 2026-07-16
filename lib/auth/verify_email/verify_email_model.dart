import '/auth/supabase_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/backend/schema/structs/index.dart';
import '/theme/app_theme.dart';
import '/core/util.dart';
import '/widgets/app_button.dart';
import 'dart:ui';
import '/custom_code/actions/index.dart' as actions;
import '/index.dart';
import 'package:flutter/services.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'verify_email_widget.dart' show VerifyEmailWidget;
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class VerifyEmailModel extends AppModel<VerifyEmailWidget> {
  ///  Local state fields for this page.

  bool? showResendCode;

  ///  State fields for stateful widgets in this page.

  // State field(s) for PinCode widget.
  TextEditingController? pinCodeController;
  FocusNode? pinCodeFocusNode;
  String? Function(BuildContext, String?)? pinCodeControllerValidator;
  // Stores action output result for [Backend Call - API (verify otp)] action in Button widget.
  ApiCallResponse? verifyCodeApiResult;
  // Stores action output result for [Backend Call - API (get user)] action in Button widget.
  ApiCallResponse? apiResultUserProfile;
  // Stores action output result for [Backend Call - API (send otp)] action in Button widget.
  ApiCallResponse? sendOtpResult;

  @override
  void initState(BuildContext context) {
    pinCodeController = TextEditingController();
  }

  @override
  void dispose() {
    pinCodeFocusNode?.dispose();
    pinCodeController?.dispose();
  }
}
