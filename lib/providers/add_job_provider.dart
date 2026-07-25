import 'package:flutter/foundation.dart';
import '/repositories/backend.dart';
import '/models/structs/index.dart';
import '/utils/util.dart';
import 'package:flutter/material.dart';

/// State management for the add_job screen (migrated from setState).
class AddJobProvider extends ChangeNotifier {
  static bool _hasLoadedOnce = false;

  List<UploadedFile> selectedImages = [];
  void addToSelectedImages(UploadedFile item) => selectedImages.add(item);
  void removeFromSelectedImages(UploadedFile item) =>
      selectedImages.remove(item);
  void removeAtIndexFromSelectedImages(int index) =>
      selectedImages.removeAt(index);
  void insertAtIndexInSelectedImages(int index, UploadedFile item) =>
      selectedImages.insert(index, item);
  void updateSelectedImagesAtIndex(
          int index, Function(UploadedFile) updateFn) =>
      selectedImages[index] = updateFn(selectedImages[index]);

  JobDataStruct? jobData;
  void updateJobDataStruct(Function(JobDataStruct) updateFn) {
    updateFn(jobData ??= JobDataStruct());
  }

  bool loading = false;

  LocationStruct? location;
  void updateLocationStruct(Function(LocationStruct) updateFn) {
    updateFn(location ??= LocationStruct());
  }

  List<String> existingImages = [];
  void addToExistingImages(String item) => existingImages.add(item);
  void removeFromExistingImages(String item) => existingImages.remove(item);
  void removeAtIndexFromExistingImages(int index) =>
      existingImages.removeAt(index);
  void insertAtIndexInExistingImages(int index, String item) =>
      existingImages.insert(index, item);
  void updateExistingImagesAtIndex(int index, Function(String) updateFn) =>
      existingImages[index] = updateFn(existingImages[index]);

  List<String> totalImages = [];
  void addToTotalImages(String item) => totalImages.add(item);
  void removeFromTotalImages(String item) => totalImages.remove(item);
  void removeAtIndexFromTotalImages(int index) => totalImages.removeAt(index);
  void insertAtIndexInTotalImages(int index, String item) =>
      totalImages.insert(index, item);
  void updateTotalImagesAtIndex(int index, Function(String) updateFn) =>
      totalImages[index] = updateFn(totalImages[index]);

  List<dynamic> testState = [];
  void addToTestState(dynamic item) => testState.add(item);
  void removeFromTestState(dynamic item) => testState.remove(item);
  void removeAtIndexFromTestState(int index) => testState.removeAt(index);
  void insertAtIndexInTestState(int index, dynamic item) =>
      testState.insert(index, item);
  void updateTestStateAtIndex(int index, Function(dynamic) updateFn) =>
      testState[index] = updateFn(testState[index]);


  bool get hasLoadedOnce => hasLoadedOnce;
  void markLoadedOnce() => _hasLoadedOnce = true;
  void setLoading(bool value) {
    loading = value;
    notify();
  }

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
}