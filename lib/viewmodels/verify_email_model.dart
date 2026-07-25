import '/repositories/api_requests/api_calls.dart';
import '/utils/util.dart';
import '/core/routes/index.dart';
import '/auth/verify_email/verify_email_widget.dart' show VerifyEmailWidget;
import 'package:flutter/material.dart';

class VerifyEmailModel extends AppModel<VerifyEmailWidget> {
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
