import 'package:firebase_analytics/firebase_analytics.dart';

class AnalyticsService {
  AnalyticsService._init();
  static final AnalyticsService _instance = AnalyticsService._init();
  static AnalyticsService get instance => _instance;
  static final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;
  static FirebaseAnalyticsObserver getAnalyticsObserver() => FirebaseAnalyticsObserver(analytics: _analytics);
  Future<void> trackEvent(String action, Map<String, Object?>? parameters) async {
    final cleanedParams = parameters == null
        ? null
        : Map.fromEntries(parameters.entries.where((e) => e.value != null).map((e) => MapEntry(e.key, e.value!)));

    await _analytics.logEvent(name: action, parameters: cleanedParams);
  }
}
