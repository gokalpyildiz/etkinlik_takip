import 'dart:io';

import 'package:etkinlik_takip/product/utility/project_manager.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class FbMessaging {
  static String? fcmToken;
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
    const iosSettings = DarwinInitializationSettings();
    const InitializationSettings initSettings = InitializationSettings(android: androidSettings, iOS: iosSettings);
    await _localNotifications.initialize(initSettings);
    //todo push notification modülü eklenince açılacak
    if (!Platform.isIOS) {
      fcmToken = await _fcm.getToken();
    } else {
      fcmToken = await _fcm.getAPNSToken();
    }
    _fcm.onTokenRefresh.listen((newToken) async {
      fcmToken = newToken;
    });
    //uygulama açıkken ve arka plandayken notification ile açılırsa:bildirime tıklanınca çalışır
    FirebaseMessaging.onMessageOpenedApp.listen(_handleMessage1);
    //uygulama açıkken notification ile açılırsa:bildirime tıklanınca çalışır
    FirebaseMessaging.onMessage.listen(_handleMessage2);
    //uygulama kapalıyken notification ile açılırsa:bildirim geldiği zaman tıklanmadan çalışır
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    //uygulama ön plandayken notification görünmesini sağlar
    await _fcm.setForegroundNotificationPresentationOptions(alert: true, badge: true, sound: true);
    // Uygulama kapalıyken notification ile açılırsa:bildirime tıklanınca açılır
    _fcm.getInitialMessage().then(_handleMessage3);
  }

  @pragma('vm:entry-point')
  static Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
    ProjectManager.scaffoldMessengerKey.currentState?.showSnackBar(SnackBar(content: Text(message.data.toString() + 'onBackgroundMessage')));
    debugPrint('onBackgroundMessage');
    await Firebase.initializeApp();
  }

  void _handleMessage1(RemoteMessage? message) {
    debugPrint('onMessageOpenedApp');
    ProjectManager.scaffoldMessengerKey.currentState?.showSnackBar(
      SnackBar(content: Text('${message?.data.toString() ?? 'null'}onMessageOpenedApp')),
    );
  }

  Future<void> _handleMessage2(RemoteMessage? message) async {
    debugPrint('onMessage');
    ProjectManager.scaffoldMessengerKey.currentState?.showSnackBar(SnackBar(content: Text('${message?.data.toString() ?? 'null'}onMessage')));
    const AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
      CHANNEL_ID,
      CHANNEL_NAME,
      channelDescription: 'Etkinlik Takibi',
      importance: Importance.max,
      priority: Priority.high,
    );
    const NotificationDetails details = NotificationDetails(android: androidDetails);
    var notification = message?.notification;
    await _localNotifications.show(notification.hashCode, notification?.title, notification?.body, details);
  }

  void _handleMessage3(RemoteMessage? message) {
    debugPrint('initialmessage');
    ProjectManager.scaffoldMessengerKey.currentState?.showSnackBar(SnackBar(content: Text('${message?.data.toString() ?? 'null'}initialmessage')));
  }
}
