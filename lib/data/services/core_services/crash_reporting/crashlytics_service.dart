import 'package:etkinlik_takip/product/state/container/product_state_items.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';

class CrashlyticsService {
  CrashlyticsService._init();
  static final CrashlyticsService _instance = CrashlyticsService._init();
  static CrashlyticsService get instance => _instance;
  final firebaseCrashlytics = FirebaseCrashlytics.instance;

  Future<void> setCrashlyticsCollectionEnabled() async {
    if (kDebugMode) return;
    await firebaseCrashlytics.setCrashlyticsCollectionEnabled(true);
    FlutterError.onError = (errorDetails) {
      FirebaseCrashlytics.instance.recordFlutterError(errorDetails);
    };
    PlatformDispatcher.instance.onError = (error, stack) {
      FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
      return true;
    };
  }

  void setError({required dynamic exception, StackTrace? stackTrace, List<String>? informationList, String? apiUrl, String? message}) {
    if (kDebugMode) return;
    var currentUrl = ProductStateItems.appRouterHandler.currentUrl;
    message ??= exception.response?.data.toString();
    firebaseCrashlytics.recordError(
      exception,
      stackTrace,
      information: informationList?.map(DiagnosticsNode.message) ?? [],
      printDetails: true,
      reason:
          'Hatanın meydana geldiği anda bulunulan sayfa: $currentUrl \n Hatanın meydana geldiği api: $apiUrl \n Hatanın meydana geldiği mesaj: $message',
    );
  }
}
