import '/auth/supabase_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/backend/backend.dart';
import '/backend/schema/enums/enums.dart';
import '/backend/schema/structs/index.dart';
import '/components/labels/labels_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/actions/actions.dart' as action_blocks;
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'tradeperson_preview_widget.dart' show TradepersonPreviewWidget;
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class TradepersonPreviewModel
    extends FlutterFlowModel<TradepersonPreviewWidget> {
  ///  Local state fields for this component.

  UserStruct? user;
  void updateUserStruct(Function(UserStruct) updateFn) {
    updateFn(user ??= UserStruct());
  }

  ///  State fields for stateful widgets in this component.

  // Stores action output result for [Backend Call - API (get user)] action in tradeperson_preview widget.
  ApiCallResponse? getUser;
  // Model for labels component.
  late LabelsModel labelsModel;
  // Stores action output result for [Backend Call - API (get conversation between users)] action in Button widget.
  ApiCallResponse? startChat;
  // Stores action output result for [Backend Call - API (send push notification)] action in Button widget.
  ApiCallResponse? messageNotificationRes;

  @override
  void initState(BuildContext context) {
    labelsModel = createModel(context, () => LabelsModel());
  }

  @override
  void dispose() {
    labelsModel.dispose();
  }
}
