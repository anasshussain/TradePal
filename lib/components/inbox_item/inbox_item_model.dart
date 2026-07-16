import '/auth/supabase_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/backend/schema/structs/index.dart';
import '/theme/app_theme.dart';
import '/core/util.dart';
import '/widgets/app_button.dart';
import 'dart:ui';
import '/custom_code/actions/index.dart' as actions;
import '/core/custom_functions.dart' as functions;
import '/index.dart';
import 'inbox_item_widget.dart' show InboxItemWidget;
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class InboxItemModel extends AppModel<InboxItemWidget> {
  ///  State fields for stateful widgets in this component.

  // Stores action output result for [Backend Call - API (mark conversation read)] action in Container widget.
  ApiCallResponse? markConversationRes;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
