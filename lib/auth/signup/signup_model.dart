import '/auth/supabase_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/components/applogo_component/applogo_component_widget.dart';
import '/theme/app_theme.dart';
import '/core/util.dart';
import '/widgets/app_button.dart';
import 'dart:ui';
import '/actions/actions.dart' as action_blocks;
import '/custom_code/actions/index.dart' as actions;
import '/index.dart';
import 'signup_widget.dart' show SignupWidget;
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class SignupModel extends AppModel<SignupWidget> {
  ///  State fields for stateful widgets in this page.

  final formKey = GlobalKey<FormState>();
  // Model for applogo_component component.
  late ApplogoComponentModel applogoComponentModel;
  // State field(s) for fulName widget.
  FocusNode? fulNameFocusNode;
  TextEditingController? fulNameTextController;
  String? Function(BuildContext, String?)? fulNameTextControllerValidator;
  String? _fulNameTextControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Name is required';
    }

    return null;
  }

  // State field(s) for Email widget.
  FocusNode? emailFocusNode;
  TextEditingController? emailTextController;
  String? Function(BuildContext, String?)? emailTextControllerValidator;
  String? _emailTextControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Email is required';
    }

    return null;
  }

  // State field(s) for phone widget.
  FocusNode? phoneFocusNode;
  TextEditingController? phoneTextController;
  String? Function(BuildContext, String?)? phoneTextControllerValidator;
  String? _phoneTextControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Phone is required';
    }

    return null;
  }

  // State field(s) for password widget.
  FocusNode? passwordFocusNode;
  TextEditingController? passwordTextController;
  late bool passwordVisibility;
  String? Function(BuildContext, String?)? passwordTextControllerValidator;
  String? _passwordTextControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Password is required';
    }

    return null;
  }

  // State field(s) for c_password widget.
  FocusNode? cPasswordFocusNode;
  TextEditingController? cPasswordTextController;
  late bool cPasswordVisibility;
  String? Function(BuildContext, String?)? cPasswordTextControllerValidator;
  String? _cPasswordTextControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Confirm Password is required';
    }

    return null;
  }

  // State field(s) for Checkbox widget.
  bool? checkboxValue;
  // Stores action output result for [Validate Form] action in Button widget.
  bool? formResult;
  // Stores action output result for [Backend Call - API (send otp)] action in Button widget.
  ApiCallResponse? verificationCodeResult;
  // Stores action output result for [Backend Call - API (add new user)] action in Button widget.
  ApiCallResponse? insertUserRowResult;

  @override
  void initState(BuildContext context) {
    applogoComponentModel = createModel(context, () => ApplogoComponentModel());
    fulNameTextControllerValidator = _fulNameTextControllerValidator;
    emailTextControllerValidator = _emailTextControllerValidator;
    phoneTextControllerValidator = _phoneTextControllerValidator;
    passwordVisibility = false;
    passwordTextControllerValidator = _passwordTextControllerValidator;
    cPasswordVisibility = false;
    cPasswordTextControllerValidator = _cPasswordTextControllerValidator;
  }

  @override
  void dispose() {
    applogoComponentModel.dispose();
    fulNameFocusNode?.dispose();
    fulNameTextController?.dispose();

    emailFocusNode?.dispose();
    emailTextController?.dispose();

    phoneFocusNode?.dispose();
    phoneTextController?.dispose();

    passwordFocusNode?.dispose();
    passwordTextController?.dispose();

    cPasswordFocusNode?.dispose();
    cPasswordTextController?.dispose();
  }
}
