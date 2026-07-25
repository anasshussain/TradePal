import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// State management for the edit_trader_profile screen (migrated from setState).
class EditTraderProfileProvider extends ChangeNotifier {
  ///  Local state fields for this page.


  List<String> selectedSkills = [];
  void addToSelectedSkills(String item) => selectedSkills.add(item);
  void removeFromSelectedSkills(String item) => selectedSkills.remove(item);
  void removeAtIndexFromSelectedSkills(int index) =>
      selectedSkills.removeAt(index);
  void insertAtIndexInSelectedSkills(int index, String item) =>
      selectedSkills.insert(index, item);
  void updateSelectedSkillsAtIndex(int index, Function(String) updateFn) =>
      selectedSkills[index] = updateFn(selectedSkills[index]);

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
