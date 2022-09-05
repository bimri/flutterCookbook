import 'package:flutter/material.dart';

import 'dismissible.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.yellow,
      ),
      home: const DismissibleScreen(),
    );
  }
}

class MyAnimation extends StatefulWidget {
  final String title;
  const MyAnimation({super.key, required this.title});

  @override
  State<MyAnimation> createState() => _MyAnimationState();
}

class _MyAnimationState extends State<MyAnimation> {
  final List<double> sizes = [100, 125, 150, 175, 200];
  final List<double> tops = [0, 50, 100, 150, 200];

  final List<Color> colors = [
    Colors.pink,
    Colors.indigo,
    Colors.black,
    Colors.lime,
    Colors.teal,
  ];

  int iteration = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Animated container'),
        actions: [
          IconButton(
            icon: const Icon(Icons.run_circle),
            onPressed: () {
              iteration < colors.length - 1 ? iteration++ : iteration = 0;
              setState(() {
                iteration = iteration;
              });
            },
          )
        ],
      ),
      body: Center(
        child: AnimatedContainer(
          width: sizes[iteration],
          height: sizes[iteration],
          margin: EdgeInsets.only(top: tops[iteration]),
          duration: const Duration(seconds: 1),
          color: colors[iteration],
        ),
      ),
    );
  }
}
