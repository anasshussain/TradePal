import '/auth/supabase_auth/auth_util.dart';
import '/components/appbar_component/appbar_component_widget.dart';
import '/theme/app_theme.dart';
import '/core/util.dart';
import '/widgets/app_button.dart';
import 'dart:ui';
import '/custom_code/actions/index.dart' as actions;
import '/index.dart';
import 'forget_password_widget.dart' show ForgetPasswordWidget;
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ForgetPasswordModel extends AppModel<ForgetPasswordWidget> {
  ///  State fields for stateful widgets in this page.

  final formKey = GlobalKey<FormState>();
  // Model for appbar_component component.
  late AppbarComponentModel appbarComponentModel;
  // State field(s) for email widget.
  FocusNode? emailFocusNode;
  TextEditingController? emailTextController;
  String? Function(BuildContext, String?)? emailTextControllerValidator;
  // Stores action output result for [Custom Action - isValidEmail] action in Button widget.
  bool? emailRegx;

  @override
  void initState(BuildContext context) {
    appbarComponentModel = createModel(context, () => AppbarComponentModel());
  }

  @override
  void dispose() {
    appbarComponentModel.dispose();
    emailFocusNode?.dispose();
    emailTextController?.dispose();
  }
}
