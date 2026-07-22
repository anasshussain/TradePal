import '/repositories/api_requests/api_calls.dart';
import '/widgets/components/appbar_component/appbar_component_widget.dart';
import '/utils/util.dart';
import '/customer_screens/review/review_widget.dart' show ReviewWidget;
import 'package:flutter/material.dart';

class ReviewModel extends AppModel<ReviewWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for appbar_component component.
  late AppbarComponentModel appbarComponentModel;
  // State field(s) for overallExperience widget.
  double? overallExperienceValue;
  // State field(s) for communication widget.
  double? communicationValue;
  // State field(s) for qualityOfWork widget.
  double? qualityOfWorkValue;
  // State field(s) for punctuality widget.
  double? punctualityValue;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode;
  TextEditingController? textController;
  String? Function(BuildContext, String?)? textControllerValidator;
  bool isDataUploading_uploadeddImage = false;
  UploadedFile uploadedLocalFile_uploadeddImage =
      UploadedFile(bytes: Uint8List.fromList([]), originalFilename: '');

  bool isDataUploading_uploadedImageUrls = false;
  List<UploadedFile> uploadedLocalFiles_uploadedImageUrls = [];
  List<String> uploadedFileUrls_uploadedImageUrls = [];

  // Stores action output result for [Backend Call - API (add review)] action in Button widget.
  ApiCallResponse? addReviewResult;
  // Stores action output result for [Backend Call - API (update trade person rating)] action in Button widget.
  ApiCallResponse? updateTpRatingRpc;

  @override
  void initState(BuildContext context) {
    appbarComponentModel = createModel(context, () => AppbarComponentModel());
  }

  @override
  void dispose() {
    appbarComponentModel.dispose();
    textFieldFocusNode?.dispose();
    textController?.dispose();
  }
}
