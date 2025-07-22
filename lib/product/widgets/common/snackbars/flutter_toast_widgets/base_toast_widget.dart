import 'package:etkinlik_takip/product/extensions/context_extension.dart';
import 'package:flutter/material.dart';

class BaseToastWidget extends StatelessWidget {
  const BaseToastWidget({required this.title, super.key, this.backgroundColor, this.subTitle, this.icon, this.textColor, this.subTextColor});
  final Color? backgroundColor;
  final String title;
  final String? subTitle;
  final Color? textColor;
  final Color? subTextColor;
  final Widget? icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(8)),
        color: backgroundColor ?? context.appTheme.colorScheme.primaryContainer,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(width: 12),
          if (icon != null) icon!,
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
                  style: context.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600, color: textColor),
                ),
                if (subTitle != null) Text(subTitle!, style: context.textTheme.titleSmall?.copyWith(color: subTextColor)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
