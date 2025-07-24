import 'package:etkinlik_takip/product/firebase/crashlytics/firebase_crashlytics.dart';
import 'package:etkinlik_takip/product/functions/auth_operation.dart';

abstract class IFirebaseBaseService {
  Future<String?> get getToken async => await AuthOperation.instance.getToken();
  Future<bool> get tokenIsExpire async => await AuthOperation.instance.tokenIsExpire();
  final _firebaseCrashlytics = CrashlyticsService.instance;
  void setError({required dynamic exception, StackTrace? stackTrace, List<String>? list, String? apiUrl, String? message}) {
    _firebaseCrashlytics.setError(exception: exception, stackTrace: stackTrace, list: list, apiUrl: apiUrl, message: message);
  }
}
