import 'package:flutter/material.dart';

class StorytellingProgressIndicator extends StatefulWidget {
  const StorytellingProgressIndicator({super.key, required this.progress, required this.storySteps});
  final double progress;
  final List<String> storySteps;

  @override
  State<StorytellingProgressIndicator> createState() => _StorytellingProgressIndicatorState();
}

class _StorytellingProgressIndicatorState extends State<StorytellingProgressIndicator> {
  @override
  Widget build(BuildContext context) {
    int currentStep = (widget.progress * widget.storySteps.length).floor();
    currentStep = currentStep >= widget.storySteps.length ? widget.storySteps.length - 1 : currentStep;

    return Column(
      children: [
        LinearProgressIndicator(
          value: widget.progress,
          backgroundColor: Colors.grey[300],
          valueColor: const AlwaysStoppedAnimation<Color>(Colors.purple),
        ),
        const SizedBox(height: 20),
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 500),
          child: Text(
            widget.storySteps[currentStep],
            key: ValueKey(currentStep),
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.purple),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
