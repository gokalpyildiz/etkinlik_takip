import 'package:flutter/material.dart';

class SmartRefreshIndicator extends StatelessWidget {
  const SmartRefreshIndicator({super.key, required this.child, required this.onRefresh});
  final Widget child;
  final Future<void> Function() onRefresh;

  @override
  Widget build(BuildContext context) => RefreshIndicator(
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
