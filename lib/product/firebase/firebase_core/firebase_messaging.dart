import 'package:firebase_messaging/firebase_messaging.dart';

class FbMessaging {
  FbMessaging._init();
  static final FbMessaging _instance = FbMessaging._init();
  static FbMessaging get instance => _instance;
  final FirebaseMessaging _fcm = FirebaseMessaging.instance;
  Future<void> init() async {
    _fcm.requestPermission();
  }
}
