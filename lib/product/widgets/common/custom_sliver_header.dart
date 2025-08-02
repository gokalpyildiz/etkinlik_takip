import 'package:flutter/material.dart';

class CustomSliverHeader extends SliverPersistentHeaderDelegate {
  final double minHeight;
  final double maxHeight;
  final Widget child;

  CustomSliverHeader({required this.minHeight, required this.maxHeight, required this.child});

  @override
  Widget build(context, double shrinkOffset, bool overlapsContent) {
    return SizedBox.expand(child: child); // Expands to fill available space
  }

  @override
  double get maxExtent => maxHeight; // Maximum header height

  @override
  double get minExtent => minHeight; // Minimum header height when collapsed

  @override
  bool shouldRebuild(covariant CustomSliverHeader oldDelegate) {
    // Only rebuild if dimensions or content changed - performance optimization
    return maxHeight != oldDelegate.maxHeight || minHeight != oldDelegate.minHeight || child != oldDelegate.child; // Optional but good practice
  }
}
