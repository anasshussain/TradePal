import '/auth/supabase_auth/auth_util.dart';
import '/repositories/api_requests/api_calls.dart';
import '/models/structs/index.dart';
import '/repositories/supabase/supabase.dart';
import '/widgets/components/add_skills/add_skills_widget.dart';
import '/widgets/components/alerts/alerts_widget.dart';
import '/widgets/components/appbar_component/appbar_component_widget.dart';
import '/widgets/app_choice_chips.dart';
import '/core/theme/app_theme.dart';
import '/utils/util.dart';
import '/widgets/app_button.dart';
import '/core/form_field_controller.dart';
import '/core/upload_data.dart';
import 'dart:ui';
import '/utils/custom_code/actions/index.dart' as actions;
import '/core/routes/index.dart';
import '/trader_screens/edit_trader_profile/edit_trader_profile_widget.dart' show EditTraderProfileWidget;
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class EditTraderProfileModel extends AppModel<EditTraderProfileWidget> {
  ///  Local state fields for this page.

  List<String> selectedSkills = [];
  void addToSelectedSkills(String item) => selectedSkills.add(item);
  void removeFromSelectedSkills(String item) => selectedSkills.remove(item);
  void removeAtIndexFromSelectedSkills(int index) =>
      selectedSkills.removeAt(index);
  void insertAtIndexInSelectedSkills(int index, String item) =>
      selectedSkills.insert(index, item);
  void updateSelectedSkillsAtIndex(int index, Function(String) updateFn) =>
      selectedSkills[index] = updateFn(selectedSkills[index]);

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
  bool isDataUploading_uploadImg = false;
  UploadedFile uploadedLocalFile_uploadImg =
      UploadedFile(bytes: Uint8List.fromList([]), originalFilename: '');
  String uploadedFileUrl_uploadImg = '';

  // State field(s) for name widget.
  FocusNode? nameFocusNode;
  TextEditingController? nameTextController;
  String? Function(BuildContext, String?)? nameTextControllerValidator;
  // State field(s) for regNo widget.
  FocusNode? regNoFocusNode;
  TextEditingController? regNoTextController;
  String? Function(BuildContext, String?)? regNoTextControllerValidator;
  // State field(s) for email widget.
  FocusNode? emailFocusNode;
  TextEditingController? emailTextController;
  String? Function(BuildContext, String?)? emailTextControllerValidator;
  // State field(s) for phone widget.
  FocusNode? phoneFocusNode;
  TextEditingController? phoneTextController;
  String? Function(BuildContext, String?)? phoneTextControllerValidator;
  // State field(s) for profession widget.
  FocusNode? professionFocusNode;
  TextEditingController? professionTextController;
  String? Function(BuildContext, String?)? professionTextControllerValidator;
  // State field(s) for service_area widget.
  FocusNode? serviceAreaFocusNode;
  TextEditingController? serviceAreaTextController;
  String? Function(BuildContext, String?)? serviceAreaTextControllerValidator;
  // Stores action output result for [Alert Dialog - Custom Dialog] action in Container widget.
  String? skill;
  // State field(s) for ChoiceChips widget.
  FormFieldController<List<String>>? choiceChipsValueController;
  String? get choiceChipsValue =>
      choiceChipsValueController?.value?.firstOrNull;
  set choiceChipsValue(String? val) =>
      choiceChipsValueController?.value = val != null ? [val] : [];
  // State field(s) for insurance_company widget.
  FocusNode? insuranceCompanyFocusNode;
  TextEditingController? insuranceCompanyTextController;
  String? Function(BuildContext, String?)?
      insuranceCompanyTextControllerValidator;
  // State field(s) for insurance_amount widget.
  FocusNode? insuranceAmountFocusNode;
  TextEditingController? insuranceAmountTextController;
  String? Function(BuildContext, String?)?
      insuranceAmountTextControllerValidator;
  DateTime? datePicked;
  // Model for alerts component.
  late AlertsModel alertsModel;
  // Stores action output result for [Backend Call - API (update user )] action in Button widget.
  ApiCallResponse? updateUserResult;

  @override
  void initState(BuildContext context) {
    appbarComponentModel = createModel(context, () => AppbarComponentModel());
    alertsModel = createModel(context, () => AlertsModel());
  }

  @override
  void dispose() {
    appbarComponentModel.dispose();
    nameFocusNode?.dispose();
    nameTextController?.dispose();

    regNoFocusNode?.dispose();
    regNoTextController?.dispose();

    emailFocusNode?.dispose();
    emailTextController?.dispose();

    phoneFocusNode?.dispose();
    phoneTextController?.dispose();

    professionFocusNode?.dispose();
    professionTextController?.dispose();

    serviceAreaFocusNode?.dispose();
    serviceAreaTextController?.dispose();

    insuranceCompanyFocusNode?.dispose();
    insuranceCompanyTextController?.dispose();

    insuranceAmountFocusNode?.dispose();
    insuranceAmountTextController?.dispose();

    alertsModel.dispose();
  }
}
