import 'dart:async';

import 'package:flutter/material.dart';

/*
StatefulWidgets are made up of two classes: the widget and the state. The widget part of
StatefulWidget really doesn't do much, and all the properties that you store in it must be
final; otherwise, you will get a compile error.
*/

/*
All widgets, whether they are stateless or stateful, are still immutable. In
Stateful widgets, the state can change.
*/
class StopWatch extends StatefulWidget {
  const StopWatch({Key? key}) : super(key: key);

  @override
  State<StopWatch> createState() => _StopWatchState();
}

class _StopWatchState extends State<StopWatch> {
  bool isTicking = true;
  late int seconds = 0;
  late Timer timer;

  @override
  // performing a job similar to a constructor
  //

  /* 
  avoid performing any complex operations inside the setState closure
  since that can cause performance bottlenecks.
  */
  void _onTick(Timer time) {
    setState(() {
      ++seconds;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('masaa'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            '$seconds ${_secondsText()}',
            style: Theme.of(context).textTheme.headline5,
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.green),
                  foregroundColor:
                      MaterialStateProperty.all<Color>(Colors.white),
                ),
                onPressed: isTicking ? null : _startTimer,
                child: const Text('Start'),
              ),
              const SizedBox(
                width: 20,
              ),
              TextButton(
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.red),
                    foregroundColor:
                        MaterialStateProperty.all<Color>(Colors.white)),
                onPressed: isTicking ? _stopTimer : null,
                child: const Text('Stop'),
              )
            ],
          ),
        ],
      ),
    );
  }

  String _secondsText() => seconds == 1 ? 'second' : 'seconds';

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  void _startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), _onTick);

    setState(() {
      seconds = 0;
      isTicking = true;
    });
  }

  void _stopTimer() {
    timer.cancel();

    setState(() {
      isTicking = false;
    });
  }
}

/* 
The State class has a life cycle. Unlike StatelessWidget, which is nothing more than a
build method, StatefulWidgets have a few different life cycle methods that are called in a
specific order.
  - initState -> initialize any non-final value in your state class
  - didChangeDependencies -> called immediately after initState but unlike that method, the
                             widget now has access to its BuildContext
  - didUpdateWidget
  - build (required) ->  State's build method is identical to StatelessWidget's build method and is required.
  = reassemble
  - deactivate
  - dispose -> leanup method is called when the state object is removed from the widget tree.
*/

/* 
Flutter has several button types that can be used for different aesthetics, but their
functionality is the same. They are as follows:
      ElevatedButton
      TextButton
      IconButton
      FloatingActionButton
      DropDownButton
      CupertinoButton
*/
