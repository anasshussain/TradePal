import '/repositories/api_requests/api_calls.dart';
import '/utils/util.dart';
import '/bank_cards/bank_cards_widget.dart' show BankCardsWidget;
import 'package:flutter/material.dart';

class BankCardsModel extends AppModel<BankCardsWidget> {
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
