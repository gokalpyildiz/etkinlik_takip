import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
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
  final bool isAnimated;

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
    this.isAnimated = false,
  });

  const MyText.displayLarge(
    this.text, {
    super.key,
    this.color,
    this.fontSize = 18.0,
    this.fontWeight = FontWeight.w600,
    this.textAlign = TextAlign.left,
    this.overflow,
    this.maxLines,
    this.decoration,
    this.isAnimated = false,
  });

  @override
  Widget build(BuildContext context) {
    if (isAnimated) {
      return _text().animate().fade().scale();
    } else {
      return _text();
    }
  }

  Text _text() {
    return Text(
      text ?? '*null*',
      style: TextStyle(decoration: decoration, fontSize: fontSize.sp, color: color, fontWeight: fontWeight),
      overflow: overflow,
      maxLines: maxLines,
      textAlign: textAlign,
      softWrap: true,
    );
  }
}
