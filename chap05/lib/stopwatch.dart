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
  late int seconds;
  late Timer timer;

  @override
  // performing a job similar to a constructor
  void initState() {
    super.initState();

    seconds = 0;
    timer = Timer.periodic(const Duration(seconds: 1), _onTick);
  }

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
    return Text(
      '$seconds ${_secondsText()}',
      style: Theme.of(context).textTheme.headline5,
    );
  }

  String _secondsText() => seconds == 1 ? 'second' : 'seconds';

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
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