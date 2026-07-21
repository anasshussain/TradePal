import '/auth/supabase_auth/auth_util.dart';
import '/repositories/api_requests/api_calls.dart';
import '/repositories/backend.dart';
import '/utils/enums/enums.dart';
import '/models/structs/index.dart';
import '/repositories/supabase/supabase.dart';
import '/widgets/components/appbar_component/appbar_component_widget.dart';
import '/widgets/components/bottom_sheet_attachment_component/bottom_sheet_attachment_component_widget.dart';
import '/widgets/components/countinue_booking/countinue_booking_widget.dart';
import '/widgets/components/empty_list_component/empty_list_component_widget.dart';
import '/widgets/components/loading_text/loading_text_widget.dart';
import '/widgets/components/unlock_chat_dialogue_box_widget.dart';
import '/widgets/components/user_preview_component/user_preview_component_widget.dart';
import '/core/animations.dart';
import '/widgets/app_expanded_image_view.dart';
import '/widgets/app_icon_button.dart';
import '/core/theme/app_theme.dart';
import '/utils/util.dart';
import '/widgets/app_button.dart';
import '/core/upload_data.dart';
import 'dart:math';
import 'dart:ui';
import '/utils/action_blocks/actions.dart' as action_blocks;
import '/utils/custom_code/actions/index.dart' as actions;
import '/utils/custom_functions.dart' as functions;
import '/core/routes/index.dart';
import '/chat_page/chat_page_widget.dart' show ChatPageWidget;
import 'dart:async';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class ChatPageModel extends AppModel<ChatPageWidget> {
  ///  Local state fields for this page.

  bool loading = true;

  JobDataStruct? jobData;
  void updateJobDataStruct(Function(JobDataStruct) updateFn) {
    updateFn(jobData ??= JobDataStruct());
  }

  bool isAssigned = false;

  PayloadUpdateJobStruct? dad;
  void updateDadStruct(Function(PayloadUpdateJobStruct) updateFn) {
    updateFn(dad ??= PayloadUpdateJobStruct());
  }

  bool isProposalPaid = true;

  ///  State fields for stateful widgets in this page.

  Completer<ApiCallResponse>? apiRequestCompleter;
  // Stores action output result for [Backend Call - API (get job details)] action in chat_page widget.
  ApiCallResponse? getJobDetail;
  // Stores action output result for [Backend Call - API (get proposal payment)] action in chat_page widget.
  ApiCallResponse? paymentStatusRes;
  // Model for appbar_component component.
  late AppbarComponentModel appbarComponentModel;
  // Stores action output result for [Backend Call - API (update job  status)] action in Button widget.
  ApiCallResponse? jobCompletedRes;
  // Stores action output result for [Backend Call - API (send push notification)] action in Button widget.
  ApiCallResponse? completedJobNotificationRes;
  // Stores action output result for [Backend Call - API (update job  status)] action in Button widget.
  ApiCallResponse? jobAssignedRes;
  // Stores action output result for [Backend Call - API (send push notification)] action in Button widget.
  ApiCallResponse? assignedNotificationRes;
  // Model for LoadingText component.
  late LoadingTextModel loadingTextModel;
  bool isDataUploading_locallyUploadedImage = false;
  UploadedFile uploadedLocalFile_locallyUploadedImage =
      UploadedFile(bytes: Uint8List.fromList([]), originalFilename: '');

  // State field(s) for MessageTextField widget.
  FocusNode? messageTextFieldFocusNode;
  TextEditingController? messageTextFieldTextController;
  String? Function(BuildContext, String?)?
      messageTextFieldTextControllerValidator;
  bool isDataUploading_uploadedFileImagePath = false;
  UploadedFile uploadedLocalFile_uploadedFileImagePath =
      UploadedFile(bytes: Uint8List.fromList([]), originalFilename: '');
  String uploadedFileUrl_uploadedFileImagePath = '';

  // Stores action output result for [Backend Call - API (send message)] action in IconButton widget.
  ApiCallResponse? sendMessage;
  // Stores action output result for [Backend Call - API (send push notification)] action in IconButton widget.
  ApiCallResponse? messageNotificationRes;

  @override
  void initState(BuildContext context) {
    appbarComponentModel = createModel(context, () => AppbarComponentModel());
    loadingTextModel = createModel(context, () => LoadingTextModel());
  }

  @override
  void dispose() {
    appbarComponentModel.dispose();
    loadingTextModel.dispose();
    messageTextFieldFocusNode?.dispose();
    messageTextFieldTextController?.dispose();
  }

  /// Additional helper methods.
  Future waitForApiRequestCompleted({
    double minWait = 0,
    double maxWait = double.infinity,
  }) async {
    final stopwatch = Stopwatch()..start();
    while (true) {
      await Future.delayed(Duration(milliseconds: 50));
      final timeElapsed = stopwatch.elapsedMilliseconds;
      final requestComplete = apiRequestCompleter?.isCompleted ?? false;
      if (timeElapsed > maxWait || (requestComplete && timeElapsed > minWait)) {
        break;
      }
    }
  }
}
