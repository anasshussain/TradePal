import '/widgets/app_icon_button.dart';
import '/theme/app_theme.dart';
import '/core/util.dart';
import '/widgets/app_button.dart';
import '/core/upload_data.dart';
import 'dart:ui';
import 'upload_file_component_widget.dart' show UploadFileComponentWidget;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class UploadFileComponentModel
    extends AppModel<UploadFileComponentWidget> {
  ///  Local state fields for this component.

  bool hasData = false;

  ///  State fields for stateful widgets in this component.

  bool isDataUploading_localUploadedPhoto = false;
  UploadedFile uploadedLocalFile_localUploadedPhoto =
      UploadedFile(bytes: Uint8List.fromList([]), originalFilename: '');

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
