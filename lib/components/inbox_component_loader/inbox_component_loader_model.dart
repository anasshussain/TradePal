import '/components/text_loader/text_loader_widget.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:math';
import 'dart:ui';
import 'inbox_component_loader_widget.dart' show InboxComponentLoaderWidget;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class InboxComponentLoaderModel
    extends FlutterFlowModel<InboxComponentLoaderWidget> {
  ///  State fields for stateful widgets in this component.

  // Model for textLoader component.
  late TextLoaderModel textLoaderModel1;
  // Model for textLoader component.
  late TextLoaderModel textLoaderModel2;
  // Model for textLoader component.
  late TextLoaderModel textLoaderModel3;

  @override
  void initState(BuildContext context) {
    textLoaderModel1 = createModel(context, () => TextLoaderModel());
    textLoaderModel2 = createModel(context, () => TextLoaderModel());
    textLoaderModel3 = createModel(context, () => TextLoaderModel());
  }

  @override
  void dispose() {
    textLoaderModel1.dispose();
    textLoaderModel2.dispose();
    textLoaderModel3.dispose();
  }
}
