import '/repositories/api_requests/api_calls.dart';
import '/widgets/components/appbar_component/appbar_component_widget.dart';
import '/widgets/components/job_details_loader/job_details_loader_widget.dart';
import '/widgets/components/job_location_component/job_location_component_widget.dart';
import '/utils/util.dart';
import '/core/utils/form_field_controller.dart';
import '/core/routes/index.dart';
import '/job_details/job_details_widget.dart' show JobDetailsWidget;
import 'package:flutter/material.dart';

class JobDetailsModel extends AppModel<JobDetailsWidget> {
  // Business / view state for this page has moved to [JobDetailsProvider]
  // (see lib/providers/job_details_provider.dart) and is managed with Provider
  // instead of setState.

  ///  State fields for stateful widgets in this page.

  final formKey = GlobalKey<FormState>();
  // Stores action output result for [Backend Call - API (get job details)] action in job_details widget.
  ApiCallResponse? getJobDetails;
  // Stores action output result for [Backend Call - API (get submitted proposals)] action in job_details widget.
  ApiCallResponse? getApplicationList;
  // Stores action output result for [Backend Call - API (get submitted proposals)] action in job_details widget.
  ApiCallResponse? getSubmittedJobData;
  // Stores action output result for [Backend Call - API (get proposal payment)] action in job_details widget.
  ApiCallResponse? paymentStatus;
  // Stores action output result for [Backend Call - API (get user)] action in job_details widget.
  ApiCallResponse? getUser;
  // Model for appbar_component component.
  late AppbarComponentModel appbarComponentModel;
  // Model for job_location_component component.
  late JobLocationComponentModel jobLocationComponentModel;
  // State field(s) for quoteTextField widget.
  FocusNode? quoteTextFieldFocusNode;
  TextEditingController? quoteTextFieldTextController;
  String? Function(BuildContext, String?)?
      quoteTextFieldTextControllerValidator;
  // State field(s) for ChoiceChips widget.
  FormFieldController<List<String>>? choiceChipsValueController;
  String? get choiceChipsValue =>
      choiceChipsValueController?.value?.firstOrNull;
  set choiceChipsValue(String? val) =>
      choiceChipsValueController?.value = val != null ? [val] : [];
  // State field(s) for description widget.
  FocusNode? descriptionFocusNode;
  TextEditingController? descriptionTextController;
  String? Function(BuildContext, String?)? descriptionTextControllerValidator;
  String? _descriptionTextControllerValidator(
      BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Please enter your proposal description';
    }

    return null;
  }

  // Stores action output result for [Validate Form] action in Button widget.
  bool? formResult;
  // Stores action output result for [Backend Call - API (submit proposal)] action in Button widget.
  ApiCallResponse? submitProposalAPi;
  // Stores action output result for [Backend Call - API (send push notification)] action in Button widget.
  ApiCallResponse? assignedNotificationOutput;
  // Stores action output result for [Backend Call - API (get conversation between users)] action in Button widget.
  ApiCallResponse? startChat;
  // Stores action output result for [Backend Call - API (send push notification)] action in Button widget.
  ApiCallResponse? messageNotificationRes;
  // Stores action output result for [Backend Call - API (create payment fee)] action in Button widget.
  ApiCallResponse? paymentIntentResponse;
  // Stores action output result for [Custom Action - makePayment] action in Button widget.
  bool? paymentRes;
  // Stores action output result for [Backend Call - API (get submitted proposals)] action in tradeperson_preview widget.
  ApiCallResponse? updateApiResult;
  // Stores action output result for [Backend Call - API (update proposal status)] action in tradeperson_preview widget.
  ApiCallResponse? proposalAcceptedRes;
  // Stores action output result for [Backend Call - API (send push notification)] action in tradeperson_preview widget.
  ApiCallResponse? acceptedNotificationRes;
  // Stores action output result for [Backend Call - API (update proposal status)] action in tradeperson_preview widget.
  ApiCallResponse? proposalRejectedRes;
  // Stores action output result for [Backend Call - API (send push notification)] action in tradeperson_preview widget.
  ApiCallResponse? rejectedNotificationOutput;
  // Model for job_details_loader component.
  late JobDetailsLoaderModel jobDetailsLoaderModel;

  @override
  void initState(BuildContext context) {
    appbarComponentModel = createModel(context, () => AppbarComponentModel());
    jobLocationComponentModel =
        createModel(context, () => JobLocationComponentModel());
    descriptionTextControllerValidator = _descriptionTextControllerValidator;
    jobDetailsLoaderModel = createModel(context, () => JobDetailsLoaderModel());
  }

  @override
  void dispose() {
    appbarComponentModel.dispose();
    jobLocationComponentModel.dispose();
    quoteTextFieldFocusNode?.dispose();
    quoteTextFieldTextController?.dispose();

    descriptionFocusNode?.dispose();
    descriptionTextController?.dispose();

    jobDetailsLoaderModel.dispose();
  }
}
