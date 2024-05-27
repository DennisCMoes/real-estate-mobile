import 'package:flutter/material.dart';

class SlideFromBottom extends StatefulWidget {
  final Widget child;

  final int durationMS;
  final double bottomOffset;

  const SlideFromBottom({
    super.key,
    required this.child,
    this.durationMS = 500,
    this.bottomOffset = 0.4,
  });

  @override
  State<SlideFromBottom> createState() => _SlideFromBottomState();
}

class _SlideFromBottomState extends State<SlideFromBottom>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: Duration(milliseconds: widget.durationMS),
      vsync: this,
    );

    _offsetAnimation =
        Tween<Offset>(begin: Offset(0.0, widget.bottomOffset), end: Offset.zero)
            .animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _offsetAnimation,
      child: widget.child,
    );
  }
}
