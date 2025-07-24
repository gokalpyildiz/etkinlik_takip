import 'dart:io';
import 'package:etkinlik_takip/product/functions/route_function.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class FbMessaging {
  static String? fcmToken;
  static String? _pendingNotificationData;
  final RouteFunction _routeFunction = RouteFunction.instance;
  FbMessaging._init();
  static final FbMessaging _instance = FbMessaging._init();
  static FbMessaging get instance => _instance;
  final FirebaseMessaging _fcm = FirebaseMessaging.instance;
  static const CHANNEL_ID = 'default';
  static const CHANNEL_NAME = 'default';
  final FlutterLocalNotificationsPlugin _localNotifications = FlutterLocalNotificationsPlugin();

  Future<void> init() async {
    _fcm.requestPermission();
    const AndroidInitializationSettings androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');
    const iosSettings = DarwinInitializationSettings(requestAlertPermission: true, requestBadgePermission: true, requestSoundPermission: true);
    const InitializationSettings initSettings = InitializationSettings(android: androidSettings, iOS: iosSettings);
    await _localNotifications.initialize(initSettings, onDidReceiveNotificationResponse: _onNotificationTapped);
    if (!Platform.isIOS) {
      fcmToken = await _fcm.getToken();
    } else {
      fcmToken = await _fcm.getAPNSToken();
    }

    _fcm.onTokenRefresh.listen((newToken) async {
      fcmToken = newToken;
    });
    // Uygulama açıkken ve arka plandayken notification ile açılırsa
    FirebaseMessaging.onMessageOpenedApp.listen(_onMessageOpenedApp);
    // Uygulama açıkken notification gelirse
    FirebaseMessaging.onMessage.listen(_onMessage);
    // Uygulama kapalıyken notification ile açılırsa
    FirebaseMessaging.onBackgroundMessage(_onBackgroundMessage);
    // Uygulama ön plandayken notification görünmesini sağlar
    await _fcm.setForegroundNotificationPresentationOptions(alert: true, badge: true, sound: true);
    // Uygulama kapalıyken notification ile açılırsa
    _fcm.getInitialMessage().then(_getInitialMessage);
  }

  @pragma('vm:entry-point')
  static Future<void> _onBackgroundMessage(RemoteMessage message) async {
    debugPrint('onBackgroundMessage: ${message.data}');
    await Firebase.initializeApp();
  }

  void _onMessageOpenedApp(RemoteMessage? message) {
    debugPrint('onMessageOpenedApp: ${message?.data}');
    if (message != null) {
      _navigateDetail(message.data['detailId']);
    }
  }

  Future<void> _onMessage(RemoteMessage? message) async {
    debugPrint('onMessage: ${message?.data}');
    if (message != null) {
      await _showLocalNotification(message);
    }
  }

  void _getInitialMessage(RemoteMessage? message) {
    debugPrint('initialmessage: ${message?.data}');
    if (message != null) {
      _pendingNotificationData = message.data['detailId'] ?? '';
    }
  }

  Future<void> _showLocalNotification(RemoteMessage message) async {
    const AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
      CHANNEL_ID,
      CHANNEL_NAME,
      channelDescription: 'Etkinlik Takibi',
      importance: Importance.max,
      priority: Priority.high,
    );
    const NotificationDetails details = NotificationDetails(android: androidDetails);
    var notification = message.notification;
    await _localNotifications.show(notification.hashCode, notification?.title, notification?.body, details, payload: message.data['detailId']);
  }

  void _onNotificationTapped(NotificationResponse response) {
    if (response.payload != null && response.payload!.isNotEmpty) {
      _navigateDetail(response.payload);
    }
  }

  void _navigateDetail(String? value) {
    if (value == null) return;
    var response = _routeFunction.navigateToDetail(value);
    if (!response) {
      _pendingNotificationData = value;
    }
  }

  void processPendingNotification() {
    if (_pendingNotificationData != null && _pendingNotificationData!.isNotEmpty) {
      final detailId = _pendingNotificationData!;
      _pendingNotificationData = null; // Temizle
      _routeFunction.navigateToDetail(detailId);
    }
  }

  void clearPendingNotification() {
    _pendingNotificationData = null;
  }
}
