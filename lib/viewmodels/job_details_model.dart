import '/auth/supabase_auth/auth_util.dart';
import '/repositories/api_requests/api_calls.dart';
import '/repositories/backend.dart';
import '/utils/enums/enums.dart';
import '/models/structs/index.dart';
import '/widgets/components/appbar_component/appbar_component_widget.dart';
import '/widgets/components/job_details_loader/job_details_loader_widget.dart';
import '/widgets/components/job_location_component/job_location_component_widget.dart';
import '/widgets/components/tradeperson_preview/tradeperson_preview_widget.dart';
import '/widgets/app_choice_chips.dart';
import '/widgets/app_expanded_image_view.dart';
import '/core/theme/app_theme.dart';
import '/utils/util.dart';
import '/widgets/app_button.dart';
import '/core/form_field_controller.dart';
import 'dart:ui';
import '/utils/action_blocks/actions.dart' as action_blocks;
import '/utils/custom_code/actions/index.dart' as actions;
import '/utils/custom_functions.dart' as functions;
import '/core/routes/index.dart';
import '/job_details/job_details_widget.dart' show JobDetailsWidget;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class JobDetailsModel extends AppModel<JobDetailsWidget> {
  ///  Local state fields for this page.

  bool? loading = true;

  JobDataStruct? fetchedJob;
  void updateFetchedJobStruct(Function(JobDataStruct) updateFn) {
    updateFn(fetchedJob ??= JobDataStruct());
  }

  bool? isProposalSubmitted;

  List<ProposalListStruct> proposalsList = [];
  void addToProposalsList(ProposalListStruct item) => proposalsList.add(item);
  void removeFromProposalsList(ProposalListStruct item) =>
      proposalsList.remove(item);
  void removeAtIndexFromProposalsList(int index) =>
      proposalsList.removeAt(index);
  void insertAtIndexInProposalsList(int index, ProposalListStruct item) =>
      proposalsList.insert(index, item);
  void updateProposalsListAtIndex(
          int index, Function(ProposalListStruct) updateFn) =>
      proposalsList[index] = updateFn(proposalsList[index]);

  bool? isPaymentPaid;

  UserStruct? user;
  void updateUserStruct(Function(UserStruct) updateFn) {
    updateFn(user ??= UserStruct());
  }

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
