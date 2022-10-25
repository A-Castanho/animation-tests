import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class BoxHide extends HookWidget {
  //const BoxHide({super.key, required this.duration});
  final double animationHeight;
  final int animationSeconds;
  final Image hiderImage;
  final Image pickerImage;
  //TODO add direction to play animation

  const BoxHide(
      {super.key,
      this.animationHeight = 300.0,
      this.animationSeconds = 1,
      required this.pickerImage,
      required this.hiderImage});

  @override
  Widget build(BuildContext context) {
    AnimationController controller = useAnimationController(
        duration: Duration(seconds: animationSeconds), initialValue: 0);

    Animation<double> animation = Tween<double>(begin: 0, end: 1)
        .animate(CurvedAnimation(parent: controller, curve: Curves.easeOut));

    return Stack(alignment: Alignment.center, children: [
      AnimatedBuilder(
          animation: animation,
          builder: (context, child) {
            /*  return Transform.scale(
              scale: cos(animation.value) * 10,
              child: child,
            ); */
            return Transform.translate(
              offset: Offset(0,
                  (cos(animation.value) * animationHeight) - animationHeight),
              child: child,
            );
          },
          child: const CircleAvatar(
            backgroundColor: Colors.blue,
            radius: 30,
          )),
      GestureDetector(
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
    ]);
  }
}
