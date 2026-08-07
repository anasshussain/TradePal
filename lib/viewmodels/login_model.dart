import '/auth/supabase_auth/auth_util.dart';
import '/repositories/api_requests/api_calls.dart';
import '/models/structs/index.dart';
import '/widgets/components/applogo_component/applogo_component_widget.dart';
import '/core/theme/app_theme.dart';
import '/utils/util.dart';
import '/widgets/app_button.dart';
import 'dart:ui';
import '/utils/action_blocks/actions.dart' as action_blocks;
import '/utils/custom_code/actions/index.dart' as actions;
import '/core/routes/index.dart';
import '/auth/login/login_widget.dart' show LoginWidget;
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class LoginModel extends AppModel<LoginWidget> {
  ///  State fields for stateful widgets in this page.

  final formKey = GlobalKey<FormState>();
  // Model for applogo_component component.
  late ApplogoComponentModel applogoComponentModel;
  // State field(s) for email widget.
  FocusNode? emailFocusNode;
  TextEditingController? emailTextController;
  String? Function(BuildContext, String?)? emailTextControllerValidator;
  String? _emailTextControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Email address is required';
    }

    if (!RegExp(kTextValidatorEmailRegex).hasMatch(val)) {
      return 'Has to be a valid email address.';
    }
    return null;
  }

  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode;
  TextEditingController? passwordTextController;
  late bool passwordVisibility;
  String? Function(BuildContext, String?)? passwordTextControllerValidator;
  // Stores action output result for [Backend Call - API (get user)] action in Button widget.
  ApiCallResponse? apiResultUserProfile;
  // Stores action output result for [Backend Call - API (get total unread)] action in Button widget.
  ApiCallResponse? totalCount;

  @override
  void initState(BuildContext context) {
    applogoComponentModel = createModel(context, () => ApplogoComponentModel());
    emailTextControllerValidator = _emailTextControllerValidator;
    passwordVisibility = false;
  }

  @override
  void dispose() {
    applogoComponentModel.dispose();
    emailFocusNode?.dispose();
    emailTextController?.dispose();

    textFieldFocusNode?.dispose();
    passwordTextController?.dispose();
  }
}
