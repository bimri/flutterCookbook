// In Dart and Flutter, futures and streams are the main tools for dealing with asynchronous
// programming.

// While Future represents a single value that will be delivered at a later time in the
// future, Stream is a set (sequence) of values (0 or more) that can be delivered
// asynchronously, at any time. Basically, it is a flow of continuous data.

// In order to get data from a stream, you subscribe (or listen) to it. Each time some data is
// emitted, you can receive and manipulate it as required by the logic of your app.

// each stream allows only a single subscription

import 'package:flutter/material.dart';
import 'stream.dart';
import 'dart:async';
import 'dart:math';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Stream',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const StreamHomePage(),
    );
  }
}

class StreamHomePage extends StatefulWidget {
  const StreamHomePage({super.key});

  @override
  State<StreamHomePage> createState() => _StreamHomePageState();
}

class _StreamHomePageState extends State<StreamHomePage> {
  StreamSubscription? subscription2;
  String values = '';
  StreamSubscription? subscription;
  StreamTransformer? transformer;
  int? lastNumber;
  StreamController? numberStreamController;
  NumberStream? numberStream;

  Color? bgColor;
  ColorStream? colorStream;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Stream'),
      ),
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(color: bgColor),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(values),
            ElevatedButton(
              onPressed: () => addRandomNumber(),
              child: const Text('New Random Number'),
            ),
            ElevatedButton(
              onPressed: () => stopStream(),
              child: const Text('Stop Stream'),
            ),
          ],
        ),
      ),
    );
  }

  changeColor() async {
    /* it asynchronously keeps listening to each event in a stream */
    // await for (var eventColor in colorStream!.getColors()) {
    //   setState(() {
    //     bgColor = eventColor;
    //   });
    // }

    // Instead of using an asynchronous loop,
    // you can also leverage the
    // method over for listen a stream
    colorStream?.getColors().listen((eventColor) {
      setState(() {
        bgColor = eventColor;
      });
    });
  }

  /* The main difference between listen and await for is that when there is some code after
the loop, listen will allow the execution to continue, while await for stops the
execution until the stream is completed. */

/* In this particular app, we never stop listening to the stream, but you should always close a
stream when it has completed its tasks */

  @override
  void initState() {
    numberStream = NumberStream();
    numberStreamController = numberStream?.controller;
    Stream? stream = numberStreamController?.stream.asBroadcastStream();

    subscription = stream?.listen((event) {
      setState(() {
        values += '$event - ';
      });
    });
    subscription2 = stream?.listen((event) {
      setState(() {
        values += '$event - ';
      });
    });
    super.initState();

    subscription?.onError((error) {
      setState(() {
        lastNumber = -1;
      });
    });

    subscription?.onDone(() {
      debugPrint('OnDone was called');
    });

    // StreamTransformer is an object that performs data transformations on a stream
    // so that the listeners of the stream then receive the transformed data.
    // transformer = StreamTransformer<int, dynamic>.fromHandlers(
    //   handleData: (value, sink) {
    //     sink.add(value * 10);
    //   },
    //   handleError: ((error, stackTrace, sink) => sink.add(-1)),
    //   handleDone: (sink) => sink.close(),
    // );

    // stream?.transform(transformer!).listen((event) {
    //   setState(() {
    //     lastNumber = event;
    //   });
    // }).onError((error) {
    //   setState(() {
    //     lastNumber = -1;
    //   });
    // });
    // super.initState();

    // colorStream = ColorStream();
    // changeColor();
    // super.initState();
  }

  // checks the isClosed value
// of StreamController before add ing a number to the sink.
  void addRandomNumber() {
    Random random = Random();
    int myNum = random.nextInt(10);
    if (!numberStreamController!.isClosed) {
      numberStream?.addNumberToSink(myNum);
    } else {
      setState(() {
        lastNumber = -1;
      });
    }
  }

  void stopStream() {
    numberStreamController?.close();
  }
}
