// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/backend/schema/enums/enums.dart';
import '/backend/supabase/supabase.dart';
import '/actions/actions.dart' as action_blocks;
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

// Set your action name, define your arguments and return parameter,
// and then add the boilerplate code using the `</>` button on the right!

import 'package:firebase_messaging/firebase_messaging.dart';
import 'dart:io'; // For Platform checks

Future<String?> getFCM(BuildContext context) async {
  final FirebaseMessaging fcm = await FirebaseMessaging.instance;

  try {
    String? fcmToken;

    if (Platform.isIOS) {
      await fcm.requestPermission(
        alert: true,
        badge: true,
        sound: true,
      );

      // Wait for APNs token to be assigned
      String? apnsToken;
      int attempts = 0;

      while (apnsToken == null && attempts < 20) {
        apnsToken = await fcm.getAPNSToken();
        await Future.delayed(const Duration(milliseconds: 500));
        attempts++;
      }

      if (apnsToken == null) {
        print("APNs token still null after waiting.");
        return null;
      }

      // Once APNs is available, now FCM token will be generated
      fcmToken = await fcm.getToken();
    } else {
      fcmToken = await fcm.getToken();
    }

    if (fcmToken != null) {
      FFAppState().currentDeviceToken = fcmToken;
    }

    print('FCM Token: $fcmToken');
    return fcmToken;
  } catch (e) {
    FFAppState().exception = e.toString();
    print('Error fetching FCM token: $e');
    return null;
  }
}
// Set your action name, define your arguments and return parameter,
// and then add the boilerplate code using the green button on the right!
