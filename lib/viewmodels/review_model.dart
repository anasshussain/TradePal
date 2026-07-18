import '/auth/supabase_auth/auth_util.dart';
import '/repositories/api_requests/api_calls.dart';
import '/utils/enums/enums.dart';
import '/repositories/supabase/supabase.dart';
import '/widgets/components/appbar_component/appbar_component_widget.dart';
import '/widgets/components/user_preview_component/user_preview_component_widget.dart';
import '/widgets/app_expanded_image_view.dart';
import '/widgets/app_icon_button.dart';
import '/core/theme/app_theme.dart';
import '/utils/util.dart';
import '/widgets/app_button.dart';
import '/core/upload_data.dart';
import 'dart:ui';
import '/utils/action_blocks/actions.dart' as action_blocks;
import '/customer_screens/review/review_widget.dart' show ReviewWidget;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class ReviewModel extends AppModel<ReviewWidget> {
  ///  Local state fields for this page.

  List<UploadedFile> photoUrls = [];
  void addToPhotoUrls(UploadedFile item) => photoUrls.add(item);
  void removeFromPhotoUrls(UploadedFile item) => photoUrls.remove(item);
  void removeAtIndexFromPhotoUrls(int index) => photoUrls.removeAt(index);
  void insertAtIndexInPhotoUrls(int index, UploadedFile item) =>
      photoUrls.insert(index, item);
  void updatePhotoUrlsAtIndex(int index, Function(UploadedFile) updateFn) =>
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
