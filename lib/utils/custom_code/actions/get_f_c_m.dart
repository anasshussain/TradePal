import '/repositories/backend.dart';
import '/models/structs/index.dart';
import '/utils/enums/enums.dart';
import '/repositories/supabase/supabase.dart';
import '/utils/action_blocks/actions.dart' as action_blocks;
import '/core/theme/app_theme.dart';
import '/utils/util.dart';
import '/utils/custom_code/actions/index.dart'; // Imports other custom actions
import '/utils/custom_functions.dart'; // Imports custom functions
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
      AppState().currentDeviceToken = fcmToken;
    }

    print('FCM Token: $fcmToken');
    return fcmToken;
  } catch (e) {
    AppState().exception = e.toString();
    print('Error fetching FCM token: $e');
    return null;
  }
}
// Set your action name, define your arguments and return parameter,
// and then add the boilerplate code using the green button on the right!
