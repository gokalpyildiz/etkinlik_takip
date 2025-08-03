import 'package:flutter/material.dart';

class LiquidProgressIndicator extends StatelessWidget {
  const LiquidProgressIndicator({super.key, required this.progress, this.color = Colors.blue, this.height = 20});
  final double progress;
  final Color color;
  final double height;

  @override
  Widget build(BuildContext context) => Container(
    height: height,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(height / 2),
      border: Border.all(color: color.withValues(alpha: 0.3)),
    ),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(height / 2),
      child: Stack(
        children: [
          Container(width: double.infinity, height: height, color: color.withValues(alpha: 0.1)),
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            width: MediaQuery.of(context).size.width * progress,
            height: height,
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [color.withValues(alpha: 0.8), color, color.withValues(alpha: 0.8)], stops: const [0.0, 0.5, 1.0]),
            ),
          ),
        ],
      ),
    ),
  );
}
