import 'package:flutter/foundation.dart';
import '/repositories/backend.dart';
import '/models/structs/index.dart';
import 'package:flutter/material.dart';

class TraderProfileProvider extends ChangeNotifier {
  static bool isLoading = true;

  List<String> images = [
    'https://images.pexels.com/photos/36815599/pexels-photo-36815599.jpeg',
    'https://images.pexels.com/photos/36815599/pexels-photo-36815599.jpeg',
    'https://images.pexels.com/photos/36815599/pexels-photo-36815599.jpeg',
    'https://images.pexels.com/photos/36815599/pexels-photo-36815599.jpeg',
    'https://images.pexels.com/photos/36815599/pexels-photo-36815599.jpeg'
  ];
  void addToImages(String item) => images.add(item);
  void removeFromImages(String item) => images.remove(item);
  void removeAtIndexFromImages(int index) => images.removeAt(index);
  void insertAtIndexInImages(int index, String item) =>
      images.insert(index, item);
  void updateImagesAtIndex(int index, Function(String) updateFn) =>
      images[index] = updateFn(images[index]);

  List<StripeDataStruct> stripeDetails = [];
  void addToStripeDetails(StripeDataStruct item) => stripeDetails.add(item);
  void removeFromStripeDetails(StripeDataStruct item) =>
      stripeDetails.remove(item);
  void removeAtIndexFromStripeDetails(int index) =>
      stripeDetails.removeAt(index);
  void insertAtIndexInStripeDetails(int index, StripeDataStruct item) =>
      stripeDetails.insert(index, item);
  void updateStripeDetailsAtIndex(
          int index, Function(StripeDataStruct) updateFn) =>
      stripeDetails[index] = updateFn(stripeDetails[index]);

  List<BankDetailsStruct> bankDetails = [];
  void addToBankDetails(BankDetailsStruct item) => bankDetails.add(item);
  void removeFromBankDetails(BankDetailsStruct item) =>
      bankDetails.remove(item);
  void removeAtIndexFromBankDetails(int index) => bankDetails.removeAt(index);
  void insertAtIndexInBankDetails(int index, BankDetailsStruct item) =>
      bankDetails.insert(index, item);
  void updateBankDetailsAtIndex(
          int index, Function(BankDetailsStruct) updateFn) =>
      bankDetails[index] = updateFn(bankDetails[index]);

  bool _disposed = false;

  @override
  void dispose() {
    _disposed = true;
    super.dispose();
  }

  void notify() {
    if (!_disposed) notifyListeners();
  }

  void update(VoidCallback fn) {
    fn();
    if (!_disposed) notifyListeners();
  }
  void finishLoading() {
    if (isLoading) {
      isLoading = false;
      notify();
    }
  }
}
