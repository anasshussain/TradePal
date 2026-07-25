import '/repositories/api_requests/api_calls.dart';
import '/widgets/components/appbar_component/appbar_component_widget.dart';
import '/widgets/components/loading_text/loading_text_widget.dart';
import '/utils/util.dart';
import '/core/routes/index.dart';
import '/chat_page/chat_page_widget.dart' show ChatPageWidget;
import 'dart:async';
import 'package:flutter/material.dart';

class ChatPageModel extends AppModel<ChatPageWidget> {
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
      await Future.delayed(const Duration(milliseconds: 50));
      final timeElapsed = stopwatch.elapsedMilliseconds;
      final requestComplete = apiRequestCompleter?.isCompleted ?? false;
      if (timeElapsed > maxWait || (requestComplete && timeElapsed > minWait)) {
        break;
      }
    }
  }
}
