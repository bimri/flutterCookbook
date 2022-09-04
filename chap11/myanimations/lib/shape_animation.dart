import 'package:flutter/material.dart';

class ShapeAnimation extends StatefulWidget {
  const ShapeAnimation({super.key});

  @override
  State<ShapeAnimation> createState() => _ShapeAnimationState();
}

class _ShapeAnimationState extends State<ShapeAnimation>
    with SingleTickerProviderStateMixin {
  double posTop = 0;
  double posLeft = 0;
  late Animation<double> animationTop;
  late Animation<double> animationLeft;
  // late Animation<double> animation;
  // double pos = 0;
  AnimationController? controller;

  @override
  void initState() {
    controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );

    animationLeft = Tween<double>(begin: 0, end: 200).animate(controller!);
    animationTop = Tween<double>(begin: 0, end: 400).animate(controller!)
      ..addListener(() {
        moveBall();
      });

    // animation = Tween<double>(begin: 0, end: 200).animate(controller!)
    //   ..addListener(() {
    //     moveBall();
    //   });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Animation Controller'),
        actions: [
          IconButton(
            icon: const Icon(Icons.run_circle),
            onPressed: () {
              controller?.reset();
              controller?.forward();
            },
          )
        ],
      ),
      body: Stack(children: [
        Positioned(
          left: posLeft,
          top: posTop,
          child: const Ball(),
        )
      ]),
    );
  }

  void moveBall() {
    setState(() {
      posTop = animationTop.value;
      posLeft = animationLeft.value;
      // pos = animation.value;
    });
  }
}

class Ball extends StatelessWidget {
  const Ball({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 20,
      height: 20,
      decoration:
          const BoxDecoration(color: Colors.black, shape: BoxShape.circle),
    );
  }
}
