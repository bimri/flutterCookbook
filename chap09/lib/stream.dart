import 'package:flutter/material.dart';
import 'dart:async';

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

/* StreamControllers create a linked Stream and Sink. While streams contain data
emitted sequentially that can be received by any subscriber, Sinks are used to insert
events. 

A stream controller simplifies stream management, automatically creating a stream and a
sink, and methods to control their events and features.*/

class NumberStream {
  StreamController<int> controller = StreamController<int>();

  addNumberToSink(int newNumber) {
    // sink is an instance of the class StreamSink
    // which is the "way in" for a stream.
    controller.sink.add(newNumber);
  }

  close() {
    controller.close();
  }

  addError() {
    controller.sink.addError('stream error');
  }
}
