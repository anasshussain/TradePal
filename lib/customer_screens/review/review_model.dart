import '/auth/supabase_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/backend/schema/enums/enums.dart';
import '/backend/supabase/supabase.dart';
import '/components/appbar_component/appbar_component_widget.dart';
import '/components/user_preview_component/user_preview_component_widget.dart';
import '/flutter_flow/flutter_flow_expanded_image_view.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/upload_data.dart';
import 'dart:ui';
import '/actions/actions.dart' as action_blocks;
import 'review_widget.dart' show ReviewWidget;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class ReviewModel extends FlutterFlowModel<ReviewWidget> {
  ///  Local state fields for this page.

  List<FFUploadedFile> photoUrls = [];
  void addToPhotoUrls(FFUploadedFile item) => photoUrls.add(item);
  void removeFromPhotoUrls(FFUploadedFile item) => photoUrls.remove(item);
  void removeAtIndexFromPhotoUrls(int index) => photoUrls.removeAt(index);
  void insertAtIndexInPhotoUrls(int index, FFUploadedFile item) =>
      photoUrls.insert(index, item);
  void updatePhotoUrlsAtIndex(int index, Function(FFUploadedFile) updateFn) =>
      photoUrls[index] = updateFn(photoUrls[index]);

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
  FFUploadedFile uploadedLocalFile_uploadeddImage =
      FFUploadedFile(bytes: Uint8List.fromList([]), originalFilename: '');

  bool isDataUploading_uploadedImageUrls = false;
  List<FFUploadedFile> uploadedLocalFiles_uploadedImageUrls = [];
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
