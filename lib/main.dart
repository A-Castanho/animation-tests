import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_animations/animations/rotating_container.dart';
import 'package:hooks_animations/splash_screen.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'animations/box_hide.dart';
import 'animations/bumpy_square.dart';

//CHECK FOLLOWING:
//

//TODO Animate cat from box or cookie monster with cookie or from bin or something funny with images
//TODO Display several aimations all different as you swipe left and right
//https://www.bacancytechnology.com/blog/flutter-hooks-tutorial
//https://medium.com/@s.nazdrajic/flutter-hooks-through-animation-example-336cb4fe92e1

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: DynamicCircle(),
    );
  }
}

final valueProvider = StateProvider<double>(
  (ref) => 0.0,
);

class DynamicCircle extends HookConsumerWidget {
  const DynamicCircle({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sliderValue = ref.watch(valueProvider.state).state;
    final animDuration = (sliderValue * 10).round();

    //AnimationController instance
    final controller = useAnimationController(
        duration: Duration(seconds: animDuration > 0 ? animDuration : 1))
      ..repeat();
    //Animation instance
    final sizeAnimation = Tween<double>(begin: 0, end: 50).animate(
        CurvedAnimation(parent: controller, curve: Curves.bounceInOut));

    controller.forward();

    return Scaffold(
      body: Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width / 3,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              /*  Slider(
                  value: sliderValue,
                  max: 1.0,
                  min: 0.0,
                  onChanged: (value) {
                    print(value);
                    ref.read(valueProvider.notifier).state = value;
                  }),
              Text(sliderValue.toString()),
              BumpySquare(
                duration: sliderValue,
              ),
              RotatingContainer(), */
              BoxHide()
            ],
          ),
        ),
      ),
    );
  }
}
