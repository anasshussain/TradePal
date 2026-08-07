import '/auth/supabase_auth/auth_util.dart';
import '/repositories/api_requests/api_calls.dart';
import '/models/structs/index.dart';
import '/core/theme/app_theme.dart';
import '/utils/util.dart';
import '/widgets/app_button.dart';
import 'dart:ui';
import '/utils/custom_code/actions/index.dart' as actions;
import '/utils/custom_functions.dart' as functions;
import '/core/routes/index.dart';
import '/widgets/components/inbox_item/inbox_item_widget.dart' show InboxItemWidget;
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
