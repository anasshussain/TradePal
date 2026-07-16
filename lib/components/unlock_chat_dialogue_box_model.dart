import '/auth/supabase_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/custom_code/actions/index.dart' as actions;
import 'unlock_chat_dialogue_box_widget.dart' show UnlockChatDialogueBoxWidget;
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class UnlockChatDialogueBoxModel
    extends FlutterFlowModel<UnlockChatDialogueBoxWidget> {
  ///  State fields for stateful widgets in this component.

  // Stores action output result for [Backend Call - API (create payment fee)] action in Button widget.
  ApiCallResponse? paymentIntentResponse;
  // Stores action output result for [Custom Action - makePayment] action in Button widget.
  bool? paymentRes;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
