import '/repositories/api_requests/api_calls.dart';
import '/widgets/components/appbar_component/appbar_component_widget.dart';
import '/utils/util.dart';
import '/core/routes/index.dart';
import '/customer_screens/edit_customer_profie/edit_customer_profie_widget.dart' show EditCustomerProfieWidget;
import 'package:flutter/material.dart';

class EditCustomerProfieModel
    extends AppModel<EditCustomerProfieWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for appbar_component component.
  late AppbarComponentModel appbarComponentModel;
  bool isDataUploading_uploaded = false;
  UploadedFile uploadedLocalFile_uploaded =
      UploadedFile(bytes: Uint8List.fromList([]), originalFilename: '');
  String uploadedFileUrl_uploaded = '';

  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode1;
  TextEditingController? textController1;
  String? Function(BuildContext, String?)? textController1Validator;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode2;
  TextEditingController? textController2;
  String? Function(BuildContext, String?)? textController2Validator;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode3;
  TextEditingController? textController3;
  String? Function(BuildContext, String?)? textController3Validator;
  // State field(s) for street widget.
  FocusNode? streetFocusNode;
  TextEditingController? streetTextController;
  String? Function(BuildContext, String?)? streetTextControllerValidator;
  // State field(s) for streetadress widget.
  FocusNode? streetadressFocusNode;
  TextEditingController? streetadressTextController;
  String? Function(BuildContext, String?)? streetadressTextControllerValidator;
  // State field(s) for postalcode widget.
  FocusNode? postalcodeFocusNode;
  TextEditingController? postalcodeTextController;
  String? Function(BuildContext, String?)? postalcodeTextControllerValidator;
  // Stores action output result for [Backend Call - API (update user )] action in Button widget.
  ApiCallResponse? updateUserResult;

  @override
  void initState(BuildContext context) {
    appbarComponentModel = createModel(context, () => AppbarComponentModel());
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
