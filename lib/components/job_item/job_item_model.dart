import '/backend/schema/enums/enums.dart';
import '/backend/schema/structs/index.dart';
import '/components/text_button/text_button_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'job_item_widget.dart' show JobItemWidget;
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class JobItemModel extends FlutterFlowModel<JobItemWidget> {
  ///  State fields for stateful widgets in this component.

  // Model for textButton component.
  late TextButtonModel textButtonModel;

  @override
  void initState(BuildContext context) {
    textButtonModel = createModel(context, () => TextButtonModel());
  }

  @override
  void dispose() {
    textButtonModel.dispose();
  }
}
