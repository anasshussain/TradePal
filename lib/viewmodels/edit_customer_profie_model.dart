import '/repositories/api_requests/api_calls.dart';
import '/widgets/components/appbar_component/appbar_component_widget.dart';
import '/utils/util.dart';
import '/core/routes/index.dart';
import '/customer_screens/edit_customer_profie/edit_customer_profie_widget.dart'
    show EditCustomerProfieWidget;
import 'package:flutter/material.dart';

class EditCustomerProfieModel extends AppModel<EditCustomerProfieWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for appbar_component component.
  late AppbarComponentModel appbarComponentModel;
  bool isDataUploading_uploaded = false;
  UploadedFile uploadedLocalFile_uploaded =
      UploadedFile(bytes: Uint8List.fromList([]), originalFilename: '');
  String uploadedFileUrl_uploaded = '';

  // State field(s) for TextField widget. (name)
  FocusNode? textFieldFocusNode1;
  TextEditingController? textController1;
  String? Function(BuildContext, String?)? textController1Validator;
  String? _textController1Validator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Name is required';
    }
    return null;
  }

  // State field(s) for TextField widget. (email)
  FocusNode? textFieldFocusNode2;
  TextEditingController? textController2;
  String? Function(BuildContext, String?)? textController2Validator;
  // State field(s) for TextField widget. (phone)
  FocusNode? textFieldFocusNode3;
  TextEditingController? textController3;
  String? Function(BuildContext, String?)? textController3Validator;
  String? _textController3Validator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Phone is required';
    }
    if (!RegExp(kTextValidatorPhoneRegex).hasMatch(val)) {
      return 'Has to be a valid phone number.';
    }
    return null;
  }

  // State field(s) for street widget.
  FocusNode? streetFocusNode;
  TextEditingController? streetTextController;
  String? Function(BuildContext, String?)? streetTextControllerValidator;
  String? _streetTextControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Street is required';
    }
    return null;
  }

  // State field(s) for streetadress widget.
  FocusNode? streetadressFocusNode;
  TextEditingController? streetadressTextController;
  String? Function(BuildContext, String?)? streetadressTextControllerValidator;
  String? _streetadressTextControllerValidator(
      BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Street address is required';
    }
    return null;
  }

  // State field(s) for postalcode widget.
  FocusNode? postalcodeFocusNode;
  TextEditingController? postalcodeTextController;
  String? Function(BuildContext, String?)? postalcodeTextControllerValidator;
  String? _postalcodeTextControllerValidator(
      BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Postal code is required';
    }
    return null;
  }

  // Stores action output result for [Backend Call - API (update user )] action in Button widget.
  ApiCallResponse? updateUserResult;

  @override
  void initState(BuildContext context) {
    appbarComponentModel = createModel(context, () => AppbarComponentModel());
    textController1Validator = _textController1Validator;
    textController3Validator = _textController3Validator;
    streetTextControllerValidator = _streetTextControllerValidator;
    streetadressTextControllerValidator = _streetadressTextControllerValidator;
    postalcodeTextControllerValidator = _postalcodeTextControllerValidator;
  }

  @override
  void dispose() {
    appbarComponentModel.dispose();
    textFieldFocusNode1?.dispose();
    textController1?.dispose();

    textFieldFocusNode2?.dispose();
    textController2?.dispose();

    textFieldFocusNode3?.dispose();
    textController3?.dispose();

    streetFocusNode?.dispose();
    streetTextController?.dispose();

    streetadressFocusNode?.dispose();
    streetadressTextController?.dispose();

    postalcodeFocusNode?.dispose();
    postalcodeTextController?.dispose();
  }
}
