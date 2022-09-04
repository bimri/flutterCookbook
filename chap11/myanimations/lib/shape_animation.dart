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

  double maxTop = 0;
  double maxLeft = 0;
  final int ballSize = 100;
  late Animation<double> animation;
  // double pos = 0;
  AnimationController? controller;

  @override
  void initState() {
    controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );

    animation = CurvedAnimation(
      parent: controller!,
      curve: Curves.easeInOut,
    );

    animation.addListener(() {
      moveBall();
    });
    // animationLeft = Tween<double>(begin: 0, end: 200).animate(controller!);
    // animationTop = Tween<double>(begin: 0, end: 400).animate(controller!)
    // ..addListener(() {
    // moveBall();
    // });

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
      body: SafeArea(
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            maxLeft = constraints.maxWidth - ballSize;
            maxTop = constraints.maxHeight - ballSize;
            return Stack(children: [
              Positioned(
                left: posLeft,
                top: posTop,
                child: const Ball(),
              )
            ]);
          },
        ),
      ),
    );
  }

  void moveBall() {
    setState(() {
      posTop = animation.value * maxTop;
      posLeft = animation.value * maxLeft;
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
