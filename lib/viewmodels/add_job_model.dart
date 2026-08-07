import '/repositories/api_requests/api_calls.dart';
import '/widgets/components/appbar_component/appbar_component_widget.dart';
import '/widgets/components/job_details_loader/job_details_loader_widget.dart';
import '/utils/util.dart';
import '/core/utils/form_field_controller.dart';
import '/customer_screens/add_job/add_job_widget.dart' show AddJobWidget;
import 'package:flutter/material.dart';

class AddJobModel extends AppModel<AddJobWidget> {
  ///  State fields for stateful widgets in this page.

  final formKey = GlobalKey<FormState>();
  // Model for appbar_component component.
  late AppbarComponentModel appbarComponentModel;
  // State field(s) for jobTitle widget.
  FocusNode? jobTitleFocusNode;
  TextEditingController? jobTitleTextController;
  String? Function(BuildContext, String?)? jobTitleTextControllerValidator;
  String? _jobTitleTextControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Job title is required';
    }

    return null;
  }

  // State field(s) for category widget.
  String? categoryValue;
  FormFieldController<String>? categoryValueController;
  // State field(s) for budget widget.
  FocusNode? budgetFocusNode;
  TextEditingController? budgetTextController;
  String? Function(BuildContext, String?)? budgetTextControllerValidator;
  // State field(s) for description widget.
  FocusNode? descriptionFocusNode;
  TextEditingController? descriptionTextController;
  String? Function(BuildContext, String?)? descriptionTextControllerValidator;
  String? _descriptionTextControllerValidator(
      BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Description is required';
    }

    return null;
  }

  // State field(s) for quotesDropDown widget.
  String? quotesDropDownValue;
  FormFieldController<String>? quotesDropDownValueController;
  // State field(s) for PlacePicker widget.
  AppPlace placePickerValue = const AppPlace();
  bool isDataUploading_attachedImageLocal = false;
  List<UploadedFile> uploadedLocalFiles_attachedImageLocal = [];

  // Stores action output result for [Validate Form] action in Button widget.
  bool? formValidation;
  bool isDataUploading_uploadedImagesUrl = false;
  List<UploadedFile> uploadedLocalFiles_uploadedImagesUrl = [];
  List<String> uploadedFileUrls_uploadedImagesUrl = [];

  // Stores action output result for [Backend Call - API (addJob)] action in Button widget.
  ApiCallResponse? addPostResult;
  // Stores action output result for [Backend Call - API (update job rpc)] action in Button widget.
  ApiCallResponse? updateJob;
  // Model for job_details_loader component.
  late JobDetailsLoaderModel jobDetailsLoaderModel;

  @override
  void initState(BuildContext context) {
    appbarComponentModel = createModel(context, () => AppbarComponentModel());
    jobTitleTextControllerValidator = _jobTitleTextControllerValidator;
    descriptionTextControllerValidator = _descriptionTextControllerValidator;
    jobDetailsLoaderModel = createModel(context, () => JobDetailsLoaderModel());
  }

  @override
  void dispose() {
    appbarComponentModel.dispose();
    jobTitleFocusNode?.dispose();
    jobTitleTextController?.dispose();

    budgetFocusNode?.dispose();
    budgetTextController?.dispose();

    descriptionFocusNode?.dispose();
    descriptionTextController?.dispose();

    jobDetailsLoaderModel.dispose();
  }
}
