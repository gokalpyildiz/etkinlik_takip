import 'package:etkinlik_takip/product/extensions/context_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyText extends StatelessWidget {
  final String? text;
  final Color? color;
  final double fontSize;
  final FontWeight? fontWeight;
  final TextAlign? textAlign;
  final TextOverflow? overflow;
  final int? maxLines;
  final TextDecoration? decoration;

  const MyText(
    this.text, {
    super.key,
    this.color,
    this.fontSize = 14.0,
    this.fontWeight,
    this.textAlign = TextAlign.left,
    this.overflow,
    this.maxLines,
    this.decoration,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text ?? '*null*',
      style: TextStyle(decoration: decoration, fontSize: fontSize.sp, color: color ?? context.colorScheme.onPrimary, fontWeight: fontWeight),
      overflow: overflow,
      maxLines: maxLines,
      textAlign: textAlign,
      softWrap: true,
    );
  }
}
