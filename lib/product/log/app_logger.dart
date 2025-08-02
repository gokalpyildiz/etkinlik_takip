import 'package:etkinlik_takip/data/services/core_services/analytics_service/analytics_service.dart';
import 'package:etkinlik_takip/data/services/core_services/crash_reporting/crashlytics_service.dart';
import 'package:etkinlik_takip/product/functions/auth_operation.dart';
import 'package:etkinlik_takip/product/state/container/product_state_items.dart';
import 'package:logger/logger.dart';

class AppLogger {
  AppLogger._init();
  static final AppLogger _instance = AppLogger._init();
  static AppLogger get instance => _instance;
  static final _crashlyticsService = CrashlyticsService.instance;
  static final _analyticsCrashlytics = AnalyticsService.instance;

  static final Logger _logger = Logger(
    printer: PrettyPrinter(
      methodCount: 2, // Number of method calls to be displayed
      errorMethodCount: 8, // Number of method calls if stacktrace is provided
      lineLength: 120, // Width of the output
      colors: true, // Colorful log messages
      printEmojis: true, // Print an emoji for each log message
      // Should each log print contain a timestamp
      dateTimeFormat: DateTimeFormat.onlyTimeAndSinceStart,
    ),
  );

  static Future<void> logUserAction(String action, {Map<String, Object>? metadata}) async {
    final user = await AuthOperation.instance.getTokenModel;
    Map<String, Object?>? enrichedData;
    enrichedData = {'timestamp': DateTime.now().toIso8601String(), 'userId': user?.userId, ...?metadata};

    _logger.i('USER_ACTION: $action $enrichedData');
    _analyticsCrashlytics.trackEvent(action, enrichedData);
  }

  static Future<void> logError({required dynamic exception, String? message, StackTrace? stackTrace, List<String>? informationList}) async {
    var userId = (await AuthOperation.instance.getTokenModel)?.userId;
    final errorData = {
      'message': message,
      'error': exception.toString(),
      'stackTrace': stackTrace.toString(),
      'timestamp': DateTime.now().toIso8601String(),
      'userId': userId,
      'route': ProductStateItems.appRouterHandler.currentUrl,
    };
    _logger.e(message, error: errorData, stackTrace: stackTrace);
    _crashlyticsService.setError(exception: exception, message: message, stackTrace: stackTrace, informationList: informationList);
  }
}
