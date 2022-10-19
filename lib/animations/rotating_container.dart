import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class RotatingContainer extends HookWidget {
  @override
  Widget build(BuildContext context) {
    // All the steps above are replaced by a single line:
    final controller = useAnimationController(duration: Duration(seconds: 2))
      ..repeat(); // start the animation
    return AnimatedBuilder(
      animation: controller,
      child: Container(
        color: Colors.red,
        height: 100,
        width: 100,
      ),
      builder: (context, child) {
        return Transform(
          alignment: Alignment.center,
          transform: Matrix4.rotationZ(2 * pi * controller.value),
          child: child,
        );
      },
    );
  }
}
