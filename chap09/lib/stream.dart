import 'package:flutter/material.dart';

class ColorStream {
  Stream? colorStream;
  Stream<Color> getColors() async* {
    final List<Color> colors = [
      Colors.pink,
      Colors.black,
      Colors.white,
      Colors.deepPurple,
      Colors.teal,
    ];

    yield* Stream.periodic(const Duration(seconds: 1), (int t) {
      // In the method inside the Stream.periodic constructor, we use the modulus operator to
      // choose which color to show, based on the number of seconds that have passed since the
      // beginning of the call to the method, and we return the appropriate color.
      int index = t % 5;
      return colors[index];
    });
  }
}

/* The main difference between a stream and a future is the 
number of events that are returned: just 1 for Future, and 
0 to many for Stream. 
*/
