import '/auth/supabase_auth/auth_util.dart';
import '/repositories/api_requests/api_calls.dart';
import '/repositories/backend.dart';
import '/utils/enums/enums.dart';
import '/models/structs/index.dart';
import '/repositories/supabase/supabase.dart';
import '/widgets/components/appbar_component/appbar_component_widget.dart';
import '/widgets/components/job_details_loader/job_details_loader_widget.dart';
import '/widgets/app_drop_down.dart';
import '/widgets/app_expanded_image_view.dart';
import '/widgets/app_icon_button.dart';
import '/widgets/app_place_picker.dart';
import '/core/theme/app_theme.dart';
import '/utils/util.dart';
import '/widgets/app_button.dart';
import '/core/form_field_controller.dart';
import '/core/place.dart';
import '/core/upload_data.dart';
import 'dart:io';
import 'dart:ui';
import '/utils/action_blocks/actions.dart' as action_blocks;
import '/utils/custom_code/actions/index.dart' as actions;
import '/utils/custom_functions.dart' as functions;
import '/customer_screens/add_job/add_job_widget.dart' show AddJobWidget;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class AddJobModel extends AppModel<AddJobWidget> {
  ///  Local state fields for this page.

  List<UploadedFile> selectedImages = [];
  void addToSelectedImages(UploadedFile item) => selectedImages.add(item);
  void removeFromSelectedImages(UploadedFile item) =>
      selectedImages.remove(item);
  void removeAtIndexFromSelectedImages(int index) =>
      selectedImages.removeAt(index);
  void insertAtIndexInSelectedImages(int index, UploadedFile item) =>
      selectedImages.insert(index, item);
  void updateSelectedImagesAtIndex(
          int index, Function(UploadedFile) updateFn) =>
      selectedImages[index] = updateFn(selectedImages[index]);

  /// state that contains the data passed in through the params for editing
  JobDataStruct? jobData;
  void updateJobDataStruct(Function(JobDataStruct) updateFn) {
    updateFn(jobData ??= JobDataStruct());
  }

  bool loading = false;

  LocationStruct? location;
  void updateLocationStruct(Function(LocationStruct) updateFn) {
    updateFn(location ??= LocationStruct());
  }

  List<String> existingImages = [];
  void addToExistingImages(String item) => existingImages.add(item);
  void removeFromExistingImages(String item) => existingImages.remove(item);
  void removeAtIndexFromExistingImages(int index) =>
      existingImages.removeAt(index);
  void insertAtIndexInExistingImages(int index, String item) =>
      existingImages.insert(index, item);
  void updateExistingImagesAtIndex(int index, Function(String) updateFn) =>
      existingImages[index] = updateFn(existingImages[index]);

  List<String> totalImages = [];
  void addToTotalImages(String item) => totalImages.add(item);
  void removeFromTotalImages(String item) => totalImages.remove(item);
  void removeAtIndexFromTotalImages(int index) => totalImages.removeAt(index);
  void insertAtIndexInTotalImages(int index, String item) =>
      totalImages.insert(index, item);
  void updateTotalImagesAtIndex(int index, Function(String) updateFn) =>
      totalImages[index] = updateFn(totalImages[index]);

  List<dynamic> testState = [];
  void addToTestState(dynamic item) => testState.add(item);
  void removeFromTestState(dynamic item) => testState.remove(item);
  void removeAtIndexFromTestState(int index) => testState.removeAt(index);
  void insertAtIndexInTestState(int index, dynamic item) =>
      testState.insert(index, item);
  void updateTestStateAtIndex(int index, Function(dynamic) updateFn) =>
      testState[index] = updateFn(testState[index]);

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
  AppPlace placePickerValue = AppPlace();
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
