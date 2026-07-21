import '/auth/supabase_auth/auth_util.dart';
import '/repositories/api_requests/api_calls.dart';
import '/repositories/backend.dart';
import '/models/structs/index.dart';
import '/widgets/components/bank_card_component/bank_card_component_widget.dart';
import '/widgets/app_icon_button.dart';
import '/core/theme/app_theme.dart';
import '/utils/util.dart';
import '/widgets/app_button.dart';
import 'dart:ui';
import '/utils/custom_code/actions/index.dart' as actions;
import '/bank_cards/bank_cards_widget.dart' show BankCardsWidget;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class BankCardsModel extends AppModel<BankCardsWidget> {
  ///  Local state fields for this page.

  StripeDataStruct? stripeDetails;
  void updateStripeDetailsStruct(Function(StripeDataStruct) updateFn) {
    updateFn(stripeDetails ??= StripeDataStruct());
  }

  List<BankDetailsStruct> bankCards = [];
  void addToBankCards(BankDetailsStruct item) => bankCards.add(item);
  void removeFromBankCards(BankDetailsStruct item) => bankCards.remove(item);
  void removeAtIndexFromBankCards(int index) => bankCards.removeAt(index);
  void insertAtIndexInBankCards(int index, BankDetailsStruct item) =>
      bankCards.insert(index, item);
  void updateBankCardsAtIndex(
          int index, Function(BankDetailsStruct) updateFn) =>
      bankCards[index] = updateFn(bankCards[index]);

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Backend Call - API (get stripe row)] action in bank_cards widget.
  ApiCallResponse? userStripeRow;
  // Stores action output result for [Backend Call - API (get bank acc details)] action in bank_cards widget.
  ApiCallResponse? bankDetailRes;
  // Stores action output result for [Backend Call - API (onboarding stripe connect account)] action in IconButton widget.
  ApiCallResponse? connectStripe;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
