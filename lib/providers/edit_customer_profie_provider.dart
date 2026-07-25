import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// State management for the edit_customer_profie screen (migrated from setState).
class EditCustomerProfieProvider extends ChangeNotifier {
  ///  Local state fields for this page.


  List<String> addSkills = [
    'Hello World 1',
    'Hello World 2',
    'Hello World 3',
    'Hello World 4',
    'Hello World 5',
    'Hello World 6'
  ];
  void addToAddSkills(String item) => addSkills.add(item);
  void removeFromAddSkills(String item) => addSkills.remove(item);
  void removeAtIndexFromAddSkills(int index) => addSkills.removeAt(index);
  void insertAtIndexInAddSkills(int index, String item) =>
      addSkills.insert(index, item);
  void updateAddSkillsAtIndex(int index, Function(String) updateFn) =>
      addSkills[index] = updateFn(addSkills[index]);

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
