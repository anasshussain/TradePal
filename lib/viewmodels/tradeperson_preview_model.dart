import '/auth/supabase_auth/auth_util.dart';
import '/repositories/api_requests/api_calls.dart';
import '/repositories/backend.dart';
import '/utils/enums/enums.dart';
import '/models/structs/index.dart';
import '/widgets/components/labels/labels_widget.dart';
import '/core/theme/app_theme.dart';
import '/utils/util.dart';
import '/widgets/app_button.dart';
import 'dart:ui';
import '/utils/action_blocks/actions.dart' as action_blocks;
import '/utils/custom_functions.dart' as functions;
import '/core/routes/index.dart';
import '/widgets/components/tradeperson_preview/tradeperson_preview_widget.dart' show TradepersonPreviewWidget;
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class TradepersonPreviewModel
    extends AppModel<TradepersonPreviewWidget> {
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
