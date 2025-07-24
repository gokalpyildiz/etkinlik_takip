import 'package:etkinlik_takip/product/extensions/context_extension.dart';
import 'package:etkinlik_takip/product/utility/copy_clipboard_function.dart';
import 'package:flutter/material.dart';

extension WidgetExtension on Widget {
  Widget get toSliver => SliverToBoxAdapter(child: this);
  Widget toCopyWidgetWithIcon(BuildContext context, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(child: this),
        Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: InkWell(
            onTap: () {
              CopyClipboardFunction.copyToClipboard(value, context);
            },
            child: Icon(Icons.copy, color: context.appTheme.colorScheme.onSurfaceVariant),
          ),
        ),
      ],
    );
  }
}
