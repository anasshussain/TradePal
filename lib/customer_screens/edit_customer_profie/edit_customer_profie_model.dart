import '/auth/supabase_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/backend/schema/structs/index.dart';
import '/backend/supabase/supabase.dart';
import '/components/appbar_component/appbar_component_widget.dart';
import '/theme/app_theme.dart';
import '/core/util.dart';
import '/widgets/app_button.dart';
import '/core/upload_data.dart';
import 'dart:ui';
import '/custom_code/actions/index.dart' as actions;
import '/index.dart';
import 'edit_customer_profie_widget.dart' show EditCustomerProfieWidget;
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class EditCustomerProfieModel
    extends AppModel<EditCustomerProfieWidget> {
  ///  Local state fields for this page.

  List<String> addSkills = [
    'Hello World 1',
    'Hello World 2',
    'Hello World 3',
    'Hello World 4',
    'Hello World 5',
    'Hello World 6'
  ];
  void addToAddSkills(String item) => addSkills.add(item);
  void removeFromAddSkills(String item) => addSkills.remove(item);
  void removeAtIndexFromAddSkills(int index) => addSkills.removeAt(index);
  void insertAtIndexInAddSkills(int index, String item) =>
      addSkills.insert(index, item);
  void updateAddSkillsAtIndex(int index, Function(String) updateFn) =>
      addSkills[index] = updateFn(addSkills[index]);

  List<String> images = [
    'https://images.pexels.com/photos/36815599/pexels-photo-36815599.jpeg',
    'https://images.pexels.com/photos/36815599/pexels-photo-36815599.jpeg',
    'https://images.pexels.com/photos/36815599/pexels-photo-36815599.jpeg',
    'https://images.pexels.com/photos/36815599/pexels-photo-36815599.jpeg',
    'https://images.pexels.com/photos/36815599/pexels-photo-36815599.jpeg'
  ];
  void addToImages(String item) => images.add(item);
  void removeFromImages(String item) => images.remove(item);
  void removeAtIndexFromImages(int index) => images.removeAt(index);
  void insertAtIndexInImages(int index, String item) =>
      images.insert(index, item);
  void updateImagesAtIndex(int index, Function(String) updateFn) =>
      images[index] = updateFn(images[index]);

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
