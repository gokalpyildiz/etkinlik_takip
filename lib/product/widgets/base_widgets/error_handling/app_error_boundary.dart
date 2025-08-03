import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:etkinlik_takip/product/log/app_logger.dart';

class AppErrorBoundary extends StatefulWidget {
  const AppErrorBoundary({super.key, required this.child});
  final Widget child;

  @override
  State<AppErrorBoundary> createState() => _AppErrorBoundaryState();
}

class _AppErrorBoundaryState extends State<AppErrorBoundary> {
  @override
  void initState() {
    super.initState();
    FlutterError.onError = (FlutterErrorDetails details) {
      FlutterError.presentError(details);
      AppLogger.logError(message: 'Flutter Framework Error ', exception: details.exception, stackTrace: details.stack);
    };
    PlatformDispatcher.instance.onError = (error, stack) {
      AppLogger.logError(message: 'Async Error', exception: error, stackTrace: stack);
      return true;
    };
    ErrorWidget.builder = (FlutterErrorDetails errorDetails) {
      AppLogger.logError(message: 'Widget Build Error', exception: errorDetails.exception, stackTrace: errorDetails.stack);
      return Scaffold(
        appBar: AppBar(),
        body: const Center(
          child: Text('Bir hata oluştu', style: TextStyle(color: Colors.red)),
        ),
      );
    };
  }

  @override
  Widget build(BuildContext context) => widget.child;
}
