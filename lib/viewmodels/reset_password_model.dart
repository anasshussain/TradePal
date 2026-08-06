import '/utils/util.dart';
import '/core/routes/index.dart';
import '/auth/reset_password/reset_password_widget.dart' show ResetPasswordWidget;
import 'package:flutter/material.dart';

class ResetPasswordModel extends AppModel<ResetPasswordWidget> {
  ///  State fields for stateful widgets in this page.

  // State field(s) for Password widget.
  FocusNode? passwordFocusNode;
  TextEditingController? passwordTextController;
  late bool passwordVisibility;
  String? Function(BuildContext, String?)? passwordTextControllerValidator;
  // State field(s) for c_Password widget.
  FocusNode? cPasswordFocusNode;
  TextEditingController? cPasswordTextController;
  late bool cPasswordVisibility;
  String? Function(BuildContext, String?)? cPasswordTextControllerValidator;
  // Stores action output result for [Custom Action - isValidPassword] action in Button widget.
  bool? validationResult;
  // Stores action output result for [Custom Action - resetPassword] action in Button widget.
  // Null on success; a user-facing error message on failure.
  String? resetPasswordError;

  @override
  void initState(BuildContext context) {
    passwordVisibility = false;
    cPasswordVisibility = false;
  }

  @override
  void dispose() {
    passwordFocusNode?.dispose();
    passwordTextController?.dispose();

    cPasswordFocusNode?.dispose();
    cPasswordTextController?.dispose();
  }
}
