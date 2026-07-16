import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/upload_data.dart';
import 'dart:ui';
import 'upload_file_component_widget.dart' show UploadFileComponentWidget;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class UploadFileComponentModel
    extends FlutterFlowModel<UploadFileComponentWidget> {
  ///  Local state fields for this component.

  bool hasData = false;

  ///  State fields for stateful widgets in this component.

  bool isDataUploading_localUploadedPhoto = false;
  FFUploadedFile uploadedLocalFile_localUploadedPhoto =
      FFUploadedFile(bytes: Uint8List.fromList([]), originalFilename: '');

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
