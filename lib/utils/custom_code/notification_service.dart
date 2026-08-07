import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter/foundation.dart';
import 'package:url_launcher/url_launcher.dart';
import '/core/state/app_state.dart';

@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print("🔥 BACKGROUND MESSAGE RECEIVED");

  final data = message.data;

  print("Title: ${message.notification?.title}");
  print("Body: ${message.notification?.body}");
  print("Data: $data");

  // ⚠️ You CANNOT navigate here
  // ⚠️ You CANNOT use context

  // You CAN:
  // - store data
  // - trigger local notification
  // - prepare state
}

class NotificationService {
  NotificationService._();
  static final NotificationService instance = NotificationService._();

  final FirebaseMessaging _messaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _local =
      FlutterLocalNotificationsPlugin();

  bool _initialized = false;

  // =========================
  // INIT ENTRY POINT
  // =========================
  Future<void> init() async {
    if (_initialized) return;

    print("🔥 INIT STEP 1");

    try {
      await _requestPermission();
      print("✅ Permission done");
    } catch (e) {
      print("❌ Permission error: $e");
    }

    try {
      await _initLocalNotifications();
      print("✅ Local notifications init done");
    } catch (e) {
      print("❌ Local init error: $e");
    }

    try {
      await _createChannel();
      print("✅ Channel created");
    } catch (e) {
      print("❌ Channel error: $e");
    }

    try {
      await _setupHandlers();
      print("✅ Listener attached");
    } catch (e) {
      print("❌ Listener error: $e");
    }

    _initialized = true;
  }

  // =========================
  // PERMISSION
  // =========================
  Future<void> _requestPermission() async {
    await _messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  // =========================
  // LOCAL NOTIFICATIONS INIT
  // =========================
  Future<void> _initLocalNotifications() async {
    const android = AndroidInitializationSettings('@mipmap/ic_launcher');
    const ios = DarwinInitializationSettings();

    await _local.initialize(
      settings: const InitializationSettings(
        android: android,
        iOS: ios,
      ),
      onDidReceiveNotificationResponse: _onNotificationTap,
    );

    // await _local.initialize(
    //   const fln.InitializationSettings(
    //     android: android,
    //     iOS: ios,
    //   ),
    //   onDidReceiveNotificationResponse: _onNotificationTap,
    // );
  }

  // =========================
  // CHANNEL (ANDROID REQUIRED)
  // =========================
  Future<void> _createChannel() async {
    try {
      const channel = AndroidNotificationChannel(
        'default_channel',
        'Default Notifications',
        description: 'General app notifications',
        importance: Importance.high,
      );

      await _local
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()
          ?.createNotificationChannel(channel);
    } catch (e) {
      print("❌ CHANNEL FAILED: $e");
    }
  }

  void _onMessage(RemoteMessage message) {
    print("🔥 FOREGROUND MESSAGE TRIGGERED");
    final data = _normalize(message);

    _log(message, data);

    _showLocalNotification(data);
  }

  // =========================
  // FOREGROUND HANDLER
  // =========================
  Future<void> _setupHandlers() async {
    // 🔹 Foreground
    FirebaseMessaging.onMessage.listen(_onMessage);

    // 🔹 Background tap
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      print("🔥 TAP (BACKGROUND)");
      // _handleIncomingNavigation(message);
    });

    // 🔹 Terminated tap (THIS IS YOUR MISSING PIECE)
    final initialMessage = await _messaging.getInitialMessage();
    if (initialMessage != null) {
      print("🔥 TAP (TERMINATED)");
      // _handleIncomingNavigation(initialMessage);
    }
  }

  // void _handleIncomingNavigation(RemoteMessage message) {
  //   final rideId = message.data['ride_id']?.toString();
  //   final deepLink = message.data['link']?.toString();

  //   print("Incoming rideId: $rideId");

  //   if (rideId != null && rideId.isNotEmpty) {
  //    // AppState().requestRideId = rideId;
  //   }

  //   if (deepLink != null && deepLink.isNotEmpty) {
  //     _handleDeepLink(deepLink);
  //   }
  // }

  // =========================
  // LOCAL NOTIFICATION DISPLAY
  // =========================
  Future<void> _showLocalNotification(_NotificationData data) async {
    if (data.title.isEmpty && data.body.isEmpty) return;
    await _local.show(
      id: data.id,
      title: data.title,
      body: data.body,
      notificationDetails: const NotificationDetails(
        android: AndroidNotificationDetails(
            'default_channel', 'Default Notifications',
            icon: '@mipmap/ic_launcher',
            importance: Importance.max,
            priority: Priority.high),
      ),
      payload: data.deepLink,
    );
  }

  // =========================
  // NORMALIZATION (KEY PART)
  // =========================
  _NotificationData _normalize(RemoteMessage message) {
    return _NotificationData(
      id: message.hashCode,
      title: message.notification?.title ??
          message.data['title']?.toString() ??
          '',
      body:
          message.notification?.body ?? message.data['body']?.toString() ?? '',
      deepLink: message.data['link']?.toString(),
      raw: message.data,
    );
  }

  // =========================
  // TAP HANDLER
  // =========================
  void _onNotificationTap(NotificationResponse response) {
    final payload = response.payload;
    if (payload == null || payload.isEmpty) return;

    _handleDeepLink(payload);
  }

  void _handleDeepLink(String link) async {
    debugPrint("DeepLink: $link");

    final uri = Uri.parse(link);

    await launchUrl(
      uri,
      mode: LaunchMode.externalApplication,
    );
  }

  // =========================
  // LOGGING (OPTIONAL)
  // =========================
  void _log(RemoteMessage message, _NotificationData data) {
    if (!kDebugMode) return;

    debugPrint("========== FCM RECEIVED ==========");
    debugPrint("Title: ${data.title}");
    debugPrint("Body: ${data.body}");
    debugPrint("Data: ${data.raw}");
    debugPrint("==================================");
  }
}

// =========================
// INTERNAL MODEL
// =========================
class _NotificationData {
  final int id;
  final String title;
  final String body;
  final String? deepLink;
  final Map<String, dynamic> raw;

  _NotificationData({
    required this.id,
    required this.title,
    required this.body,
    required this.deepLink,
    required this.raw,
  });
}
