import 'dart:convert';
import 'package:flutter/services.dart';
import '/core/util.dart';

class DevEnvironmentValues {
  static const String currentEnvironment = 'Production';
  static const String environmentValuesPath =
      'assets/environment_values/environment.json';

  static final DevEnvironmentValues _instance =
      DevEnvironmentValues._internal();

  factory DevEnvironmentValues() {
    return _instance;
  }

  DevEnvironmentValues._internal();

  Future<void> initialize() async {
    try {
      final String response =
          await rootBundle.loadString(environmentValuesPath);
      final data = await json.decode(response);
      _authToken = data['authToken'];
    } catch (e) {
      print('Error loading environment values: $e');
    }
  }

  String _authToken = '';
  String get authToken => _authToken;
}
