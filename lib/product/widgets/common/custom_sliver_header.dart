import 'package:flutter/material.dart';

class CustomSliverHeader extends SliverPersistentHeaderDelegate {
  final double minHeight;
  final double maxHeight;
  final Widget Function(BuildContext context, double shrinkOffset, bool overlapsContent)? builder;
  final Widget? child;
  final Color? backgroundColor;
  final bool withFade;
  final bool withScale;

  CustomSliverHeader({
    required this.minHeight,
    required this.maxHeight,
    this.builder,
    this.child,
    this.backgroundColor,
    this.withFade = true,
    this.withScale = true,
  }) : assert(child != null || builder != null, 'Either child or builder must be provided');

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    final percent = (shrinkOffset / (maxExtent - minExtent)).clamp(0.0, 1.0);

    Widget content = builder != null ? builder!(context, shrinkOffset, overlapsContent) : child!;

    if (withFade || withScale) {
      content = Opacity(
        opacity: withFade ? 1 - percent : 1,
        child: Transform.scale(scale: withScale ? 1 - (0.1 * percent) : 1, alignment: Alignment.center, child: content),
      );
    }

    return Container(color: backgroundColor ?? Theme.of(context).colorScheme.secondaryContainer, child: content);
  }

  @override
  double get maxExtent => maxHeight;

  @override
  double get minExtent => minHeight;

  @override
  bool shouldRebuild(covariant CustomSliverHeader oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child ||
        builder != oldDelegate.builder ||
        backgroundColor != oldDelegate.backgroundColor ||
        withFade != oldDelegate.withFade ||
        withScale != oldDelegate.withScale;
  }
}
