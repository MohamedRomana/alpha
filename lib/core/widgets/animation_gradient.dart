import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constants/colors.dart';

class AnimatedGradientCircle extends StatefulWidget {
  final Widget child;

  const AnimatedGradientCircle({super.key, required this.child});

  @override
  State<AnimatedGradientCircle> createState() => _AnimatedGradientCircleState();
}

class _AnimatedGradientCircleState extends State<AnimatedGradientCircle>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      child: widget.child,
      builder: (context, child) {
        final value = _controller.value;

        return Container(
          height: 50.w,
          width: 50.w,
          decoration: BoxDecoration(
            shape: BoxShape.circle,

            gradient: LinearGradient(
              begin: Alignment(-1.0 + (value * 2.0), -1.0),
              end: Alignment(1.0 + (value * 2.0), 1.0),
              colors: const [
                Colors.black,
                Color(0xFF350000),
                AppColors.darkRed,
                Colors.black,
              ],
              stops: const [0.0, 0.35, 0.65, 1.0],
            ),

            border: Border.all(color: Colors.red, width: 1.w),
          ),
          child: child,
        );
      },
    );
  }
}