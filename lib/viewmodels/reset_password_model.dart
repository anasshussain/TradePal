import '/widgets/components/appbar_component/appbar_component_widget.dart';
import '/widgets/app_icon_button.dart';
import '/core/theme/app_theme.dart';
import '/utils/util.dart';
import '/widgets/app_button.dart';
import 'dart:ui';
import '/utils/action_blocks/actions.dart' as action_blocks;
import '/utils/custom_code/actions/index.dart' as actions;
import '/utils/custom_functions.dart' as functions;
import '/core/routes/index.dart';
import '/auth/reset_password/reset_password_widget.dart' show ResetPasswordWidget;
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ResetPasswordModel extends AppModel<ResetPasswordWidget> {
  ///  Local state fields for this page.

  String? password;

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
