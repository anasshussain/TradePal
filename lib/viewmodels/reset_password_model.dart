import '/widgets/components/appbar_component/appbar_component_widget.dart';
import '/utils/util.dart';
import '/core/routes/index.dart';
import '/auth/reset_password/reset_password_widget.dart' show ResetPasswordWidget;
import 'package:flutter/material.dart';

class ResetPasswordModel extends AppModel<ResetPasswordWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for appbar_component component.
  late AppbarComponentModel appbarComponentModel;
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
  bool? result;

  @override
  void initState(BuildContext context) {
    appbarComponentModel = createModel(context, () => AppbarComponentModel());
    passwordVisibility = false;
    cPasswordVisibility = false;
  }

  @override
  void dispose() {
    appbarComponentModel.dispose();
    passwordFocusNode?.dispose();
    passwordTextController?.dispose();

    cPasswordFocusNode?.dispose();
    cPasswordTextController?.dispose();
  }
}
