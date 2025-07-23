import 'package:flutter/material.dart';

class TitlePlaceholder extends StatelessWidget {
  const TitlePlaceholder({required this.width, super.key, this.height});
  final double width;
  final double? height;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: width,
          height: height ?? 12.0,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(6), color: Colors.white),
        ),
      ],
    ),
  );
}
