import '/repositories/api_requests/api_calls.dart';
import '/widgets/components/alerts/alerts_widget.dart';
import '/widgets/components/appbar_component/appbar_component_widget.dart';
import '/utils/util.dart';
import '/core/utils/form_field_controller.dart';
import '/core/routes/index.dart';
import '/trader_screens/edit_trader_profile/edit_trader_profile_widget.dart' show EditTraderProfileWidget;
import 'package:flutter/material.dart';

class EditTraderProfileModel extends AppModel<EditTraderProfileWidget> {
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
