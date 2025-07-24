import 'package:etkinlik_takip/product/widgets/common/snackbars/ftoast_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

final class CopyClipboardFunction {
  static void copyToClipboard(String value, BuildContext context, {String? message}) {
    Clipboard.setData(ClipboardData(text: value));
    FlutterToast.showSuccessful(context, title: message ?? 'Metin Kopyalandı', backgroundColor: Colors.grey);
  }
}
