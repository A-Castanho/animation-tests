import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class BoxHide extends HookWidget {
  //const BoxHide({super.key, required this.duration});

  @override
  Widget build(BuildContext context) {
    AnimationController controller = useAnimationController(
        duration: const Duration(seconds: 3), initialValue: 0);

    Animation<double> animation = Tween<double>(begin: 0, end: 1)
        .animate(CurvedAnimation(parent: controller, curve: Curves.easeOut));

/*     //AnimationController instance
    final sentValue = (duration * 1000).floor();
    if (sentValue != 0) {
      controller =
          useAnimationController(duration: Duration(milliseconds: sentValue))
            ..forward()
            ..repeat(reverse: true);
    } */

    return Stack(alignment: Alignment.bottomCenter, children: [
      Positioned(
        child: AnimatedBuilder(
            animation: animation,
            builder: (context, child) {
              return Transform.translate(
                offset: Offset(0, cos(animation.value) * 500),
                child: child,
              );
            },
            child: const CircleAvatar(
              backgroundColor: Colors.red,
              radius: 30,
            )),
      ),
      /* Positioned(
        bottom: cos(animation.value) * 500,
        child: Container(color: Colors.blue, height: 50, width: 50),
      ), */
      Positioned(
        child: GestureDetector(
          child: Container(
            color: Colors.brown,
            width: 300,
            height: 100,
          ),
          onTap: () {
            print("TAP : ${(controller.status != AnimationStatus.completed)}");
            if (controller.status != AnimationStatus.completed) {
              controller.forward().whenComplete(() => controller.reverse());
            }
          },
        ),
      ),
    ]);
  }
}
