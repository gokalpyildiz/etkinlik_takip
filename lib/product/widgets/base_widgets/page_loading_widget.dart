import 'package:flutter/material.dart';

import '../../../product/assets/asset.dart';

class PageLoadingWidget extends StatefulWidget {
  const PageLoadingWidget({super.key});

  @override
  State<PageLoadingWidget> createState() => _PageLoadingWidgetState();
}

class _PageLoadingWidgetState extends State<PageLoadingWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  // late Animation<double> _animationSize;
  late Animation<double> _animationOpacity;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    // _animationSize = Tween<double>(begin: 50.0, end: 40.0).animate(
    //   CurvedAnimation(
    //     parent: _controller,
    //     curve: Interval(0.0, 0.5, curve: Curves.easeInOut),
    //   ),
    // );

    _animationOpacity = Tween<double>(begin: 1, end: 0.1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut, // Interval(0.5, 1.0, curve: Curves.easeInOut),
      ),
    );

    _controller.repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(final BuildContext context) => Center(
    child: AnimatedBuilder(
      animation: _controller,
      builder:
          (final BuildContext context, final Widget? child) => Opacity(
            opacity: _animationOpacity.value,
            child: Assets.images.logo.image(
              width: 150,

              // width: _animationSize.value,
              // height: _animationSize.value,
            ),
          ),
    ),
  );
}
