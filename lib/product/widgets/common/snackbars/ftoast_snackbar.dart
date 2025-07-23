import 'package:etkinlik_takip/product/extensions/context_extension.dart';
import 'package:etkinlik_takip/product/initialize/theme/custom_color_scheme.dart';
import 'package:etkinlik_takip/product/widgets/common/snackbars/flutter_toast_widgets/base_toast_widget.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

final class FlutterToast {
  static void showSuccessful(
    BuildContext context, {
    required String title,
    String? subTitle,
    Color? backgroundColor,
    Color? textColor,
    ToastGravity gravity = ToastGravity.TOP,
    Widget? icon,
    Duration toastDuration = const Duration(seconds: 4),
  }) {
    final fToast = FToast();
    fToast
      ..removeQueuedCustomToasts()
      ..init(context)
      ..showToast(
        // child: ToastSuccessfulWidget(title: title, subTitle: subTitle),
        child: BaseToastWidget(
          title: title,
          subTitle: subTitle,
          icon: icon ?? Icon(Icons.check, color: context.appTheme.colorScheme.success),
          backgroundColor: context.colorScheme.primaryContainer,
          subTextColor: context.appTheme.colorScheme.onSurfaceVariant,
        ),
        //gravity: gravity,
        toastDuration: toastDuration,
        positionedToastBuilder: (context, child, gravity) {
          return Positioned(top: context.mediaSize.height / 2, left: 10, right: 10, child: child);
        },
      );
  }

  static void showError(
    BuildContext context, {
    required String title,
    String? subTitle,
    Color? backgroundColor,
    Color? textColor,
    ToastGravity gravity = ToastGravity.TOP,
    Duration toastDuration = const Duration(seconds: 4),
  }) {
    final fToast = FToast();
    fToast
      ..removeQueuedCustomToasts()
      ..init(context)
      ..showToast(
        child: BaseToastWidget(
          title: title,
          subTitle: subTitle,
          icon: Icon(Icons.error, color: context.appTheme.colorScheme.surface),
          backgroundColor: context.colorScheme.error,
          textColor: context.appTheme.colorScheme.surface,
          subTextColor: context.appTheme.colorScheme.surface,
        ),
        toastDuration: toastDuration,
        gravity: gravity,
        positionedToastBuilder: (context, child, gravity) {
          return Positioned(top: context.mediaSize.height / 2, left: 10, right: 10, child: child);
        },
      );
  }

  static void showErrorNoContext({
    required String title,
    String? subTitle,
    Color? backgroundColor,
    Color? textColor,
    ToastGravity gravity = ToastGravity.CENTER,
  }) {
    Fluttertoast.showToast(
      msg: title,
      toastLength: Toast.LENGTH_SHORT,
      gravity: gravity,
      backgroundColor: backgroundColor ?? const Color.fromRGBO(255, 82, 71, 1),
      textColor: textColor ?? Colors.white,
      fontSize: 16,
    );
  }
}
