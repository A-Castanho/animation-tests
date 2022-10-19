import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class BumpySquare extends HookConsumerWidget {
  final double duration;
  const BumpySquare({super.key, required this.duration});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AnimationController? controller;
    //AnimationController instance
    final sentValue = (duration * 1000).floor();
    if (sentValue != 0) {
      controller =
          useAnimationController(duration: Duration(milliseconds: sentValue))
            ..forward()
            ..repeat(reverse: true);
    }

    return Center(
        child: controller != null
            ? AnimatedBuilder(
                animation: controller,
                child: Container(
                  color: Colors.red,
                  height: 100,
                  width: 100,
                ),
                builder: (context, child) {
                  return SizedBox(
                    height: 100 * controller!.value,
                    width: 100 * controller!.value,
                    child: child,
                  );
                  /*  Transform(
          alignment: Alignment.center,
          transform: Matrix4.rotationZ(2 * pi * controller.value),
          child: child,
        ); */
                },
              )
            : null);
  }
}
