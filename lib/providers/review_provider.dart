import 'package:flutter/foundation.dart';
import '/utils/util.dart';
import 'package:flutter/material.dart';

/// State management for the review screen (migrated from setState).
class ReviewProvider extends ChangeNotifier {
  ///  Local state fields for this page.


  List<UploadedFile> photoUrls = [];
  void addToPhotoUrls(UploadedFile item) => photoUrls.add(item);
  void removeFromPhotoUrls(UploadedFile item) => photoUrls.remove(item);
  void removeAtIndexFromPhotoUrls(int index) => photoUrls.removeAt(index);
  void insertAtIndexInPhotoUrls(int index, UploadedFile item) =>
      photoUrls.insert(index, item);
  void updatePhotoUrlsAtIndex(int index, Function(UploadedFile) updateFn) =>
      photoUrls[index] = updateFn(photoUrls[index]);


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
