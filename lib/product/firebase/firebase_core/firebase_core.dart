import 'package:etkinlik_takip/data/services/core_services/crash_reporting/crashlytics_service.dart';
import 'package:etkinlik_takip/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';

class FbCore {
  FbCore._init();
  static final FbCore _instance = FbCore._init();
  static FbCore get instance => _instance;
  Future<void> init() async {
    await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
    await CrashlyticsService.instance.setCrashlyticsCollectionEnabled();
  }
}
