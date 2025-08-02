import 'dart:async';

import 'package:etkinlik_takip/data/services/core_services/crash_reporting/crashlytics_service.dart';
import 'package:etkinlik_takip/product/firebase/firebase_core/firebase_core.dart';
import 'package:etkinlik_takip/product/firebase/firebase_core/firebase_messaging.dart';
import 'package:etkinlik_takip/product/state/container/product_state_container.dart';
import 'package:etkinlik_takip/product/state/container/product_state_items.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

@immutable
final class ApplicationStart {
  const ApplicationStart._();
  static Future<void> init() async {
    WidgetsFlutterBinding.ensureInitialized();
    await runZonedGuarded<Future<void>>(
      () async {
        await _initialize();
      },
      (error, stack) {
        CrashlyticsService.instance.setError(exception: error, stackTrace: stack, message: 'RunzonedGuarded error');
      },
    );
  }

  static Future<void> _initialize() async {
    await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    ProductContainer.setup();
    await ProductStateItems.productCache.init();
    await FbCore.instance.init();
    FbMessaging.instance.init();
  }
}
