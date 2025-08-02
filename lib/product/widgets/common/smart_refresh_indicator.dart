import 'package:flutter/material.dart';

class SmartRefreshIndicator extends StatelessWidget {
  final Widget child;
  final Future<void> Function() onRefresh;

  const SmartRefreshIndicator({super.key, required this.child, required this.onRefresh});

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: onRefresh,
      edgeOffset: 50,
      child: ScrollConfiguration(
        behavior: ScrollConfiguration.of(context).copyWith(
          // Always allows scrolling even when content is short
          physics: const AlwaysScrollableScrollPhysics(),
        ),
        child: child,
      ),
    );
  }
}
