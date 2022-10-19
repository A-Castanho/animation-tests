import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class SplashScreen extends HookWidget {
  @override
  Widget build(BuildContext context) {
    AnimationController controller = useAnimationController(
        duration: const Duration(seconds: 3), initialValue: 1)
      ..repeat(reverse: false, period: const Duration(seconds: 4));

    Animation<double> animation = Tween<double>(begin: 0, end: 1)
        .animate(CurvedAnimation(parent: controller, curve: Curves.easeOut));
    controller.forward()..whenComplete(() => controller.reverse());

    /* animation.addListener(() {
      print("x: ${animation.value} - cos: ${cos(animation.value)}");
    }); */
    //controller.reverse();

    /* useEffect(() {
      Timer.periodic(const Duration(seconds: 4), (time) {
        //Go Home
        /* Route route = MaterialPageRoute(builder: (context) => HomePage());
        Navigator.of(context).pushReplacement(route); */
      });
    }); */

    return SafeArea(
        child: Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFFFFFFF), Color(0xffE3F3FF)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          children: [
            FadeTransition(
              opacity: controller,
              child: const Center(
                  child: FlutterLogo(
                size: 50,
              )),
            ),
            AnimatedBuilder(
              animation: controller,
              child: Container(
                color: Colors.red,
                height: 100,
                width: 100,
              ),
              builder: (context, child) {
                return Transform.translate(
                  offset: Offset(0, cos(animation.value) * 100),
                  child: child,
                );
              },
            ),
            Padding(
              padding: const EdgeInsets.all(100.0),
              child: AnimatedBuilder(
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
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Transform.translate(
                offset: Offset(0, cos(animation.value)),
                child: const SizedBox(
                  height: 250,
                  width: 170,
                  child: Icon(Icons.abc),
                ),
              ),
            )
          ],
        ),
      ),
    ));
  }
}
