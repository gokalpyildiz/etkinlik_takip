import 'dart:async';

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
    await FbCore.instance.init();
    await FbMessaging.instance.init();
    await runZonedGuarded<Future<void>>(
      () async {
        await _initialize();
      },
      (error, stack) {
        //todo crash service implement
      },
    );
  }

  static Future<void> _initialize() async {
    await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    ProductContainer.setup();
    await ProductStateItems.productCache.init();
  }
}
