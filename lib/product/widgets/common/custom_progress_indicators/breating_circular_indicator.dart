import 'package:flutter/material.dart';

class BreathingProgressIndicator extends StatefulWidget {
  const BreathingProgressIndicator({super.key, required this.progress, this.color = Colors.blue});
  final double progress;
  final Color color;

  @override
  State<BreathingProgressIndicator> createState() => _BreathingProgressIndicatorState();
}

class _BreathingProgressIndicatorState extends State<BreathingProgressIndicator> with TickerProviderStateMixin {
  late AnimationController _breathingController;
  late Animation<double> _breathingAnimation;

  @override
  void initState() {
    super.initState();
    _breathingController = AnimationController(duration: const Duration(seconds: 2), vsync: this);
    _breathingAnimation = Tween<double>(begin: 0.8, end: 1.2).animate(CurvedAnimation(parent: _breathingController, curve: Curves.easeInOut));

    _breathingController.repeat(reverse: true);
  }

  @override
  Widget build(BuildContext context) => AnimatedBuilder(
    animation: _breathingAnimation,
    builder: (context, child) => Transform.scale(
      scale: _breathingAnimation.value,
      child: Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(shape: BoxShape.circle, color: widget.color.withValues(alpha: 0.3)),
        child: Center(
          child: CircularProgressIndicator(value: widget.progress, strokeWidth: 3, valueColor: AlwaysStoppedAnimation<Color>(widget.color)),
        ),
      ),
    ),
  );

  @override
  void dispose() {
    _breathingController.dispose();
    super.dispose();
  }
}
