import 'package:flutter/material.dart';

class SlideFromBottomPageTransition extends StatefulWidget {
  const SlideFromBottomPageTransition({super.key});

  @override
  State<SlideFromBottomPageTransition> createState() =>
      _SlideFromBottomPageTransitionState();
}

class _SlideFromBottomPageTransitionState
    extends State<SlideFromBottomPageTransition>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
