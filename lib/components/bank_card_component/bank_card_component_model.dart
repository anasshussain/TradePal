import '/backend/api_requests/api_calls.dart';
import '/backend/schema/structs/index.dart';
import '/theme/app_theme.dart';
import '/core/util.dart';
import '/widgets/app_button.dart';
import 'dart:ui';
import '/custom_code/actions/index.dart' as actions;
import '/core/custom_functions.dart' as functions;
import 'bank_card_component_widget.dart' show BankCardComponentWidget;
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class BankCardComponentModel extends AppModel<BankCardComponentWidget> {
  ///  State fields for stateful widgets in this component.

  // Stores action output result for [Backend Call - API (delete bank account)] action in Container widget.
  ApiCallResponse? removeBankAccount;
  // State field(s) for Checkbox widget.
  bool? checkboxValue;
  // Stores action output result for [Backend Call - API (create default account)] action in Checkbox widget.
  ApiCallResponse? createDefaultAccount;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
