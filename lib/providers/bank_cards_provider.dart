import 'package:flutter/foundation.dart';
import '/repositories/backend.dart';
import '/models/structs/index.dart';
import 'package:flutter/material.dart';

/// State management for the bank_cards screen (migrated from setState).
class BankCardsProvider extends ChangeNotifier {
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


  /// Notify observers without mutating state (replaces empty setState).
  bool _disposed = false;

  @override
  void dispose() {
    _disposed = true;
    super.dispose();
  }

  /// Notify observers without mutating state (replaces empty setState).
  void notify() {
    if (!_disposed) notifyListeners();
  }

  /// Run [fn] then notify observers (replaces setState(() => ...)).
  void update(VoidCallback fn) {
    fn();
    if (!_disposed) notifyListeners();
  }
}
