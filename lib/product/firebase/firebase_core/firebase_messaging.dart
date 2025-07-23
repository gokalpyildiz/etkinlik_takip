import 'dart:io';

import 'package:etkinlik_takip/product/utility/project_manager.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class FbMessaging {
  static String? fcmToken;
  FbMessaging._init();
  static final FbMessaging _instance = FbMessaging._init();
  static FbMessaging get instance => _instance;
  final FirebaseMessaging _fcm = FirebaseMessaging.instance;

  Future<void> init() async {
    _fcm.requestPermission();
    //todo push notification modülü eklenince açılacak
    if (!Platform.isIOS) {
      fcmToken = await _fcm.getToken();
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
      SnackBar(content: Text((message?.data.toString() ?? 'null') + 'onMessageOpenedApp')),
    );
  }

  void _handleMessage2(RemoteMessage? message) {
    debugPrint('onMessage');
    ProjectManager.scaffoldMessengerKey.currentState?.showSnackBar(SnackBar(content: Text((message?.data.toString() ?? 'null') + 'onMessage')));
  }

  void _handleMessage3(RemoteMessage? message) {
    debugPrint('initialmessage');
    ProjectManager.scaffoldMessengerKey.currentState?.showSnackBar(SnackBar(content: Text((message?.data.toString() ?? 'null') + 'initialmessage')));
  }
}
