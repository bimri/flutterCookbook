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
  int milliseconds = 0;
  bool isTicking = true;
  int seconds = 0;
  late Timer timer;

  final laps = <int>[];

  /* 
  new feature for the list to scroll to the bottom every time the
  lap button is tapped. Flutter makes this easy with the ScrollController class.

  link these values with ListView by feeding them into the
  widget's constructor: ListView.builder Widget 
  */
  final itemHeight = 60.0;
  final scrollController = ScrollController();

  // performing a job similar to a constructor
  //

  /* 
  avoid performing any complex operations inside the setState closure
  since that can cause performance bottlenecks.
  */
  void _onTick(Timer timer) {
    setState(() {
      milliseconds += 100;
    });
  }

  void _startTimer() {
    timer = Timer.periodic(const Duration(milliseconds: 100), _onTick);

    setState(() {
      laps.clear();
      isTicking = true;
    });
  }

  void _stopTimer() {
    timer.cancel();

    setState(() {
      isTicking = false;
    });
  }

  void _lap() {
    // tell ListView to scroll when a new lap is added
    scrollController.animateTo(
      itemHeight * laps.length,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeIn,
    );
    setState(() {
      laps.add(milliseconds);
      milliseconds = 0;
    });
  }

  String _secondsText(int milliseconds) {
    final seconds = milliseconds / 1000;
    return '$seconds seconds';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('masaa'),
      ),
      body: Column(
        children: <Widget>[
          /* 
          One final important thing to keep in mind about scrolling widgets is that because they need
          to know their parent's constraints to activate scrolling, putting scroll widgets inside widgets
          with unbounded constraints can cause Flutter to throw errors.
          In our example, we placed ListView inside a Column, which is a flex widget that lays out
          its children based on their intrinsic size. This works fine for widgets such
          as Containers, Buttons, and Text, but it fails for ListViews. To make scrolling work
          inside Column, we had to wrap it in an Expanded widget, which will then tell
          ListView how much space it has to work with. Try removing Expanded; the whole widget
          will disappear and you should see an error in the Debug console:

          These types of errors can be pretty unsettling to see and don't always immediately tell you
          how to fix your code. There is also a long explosion of log entries that have nothing to do
          with your code. When you see this error, it just means that you have an unbounded
          scrolling widget. If you place a scrolling widget inside a Flex widget, which is pretty
          common, just don't forget to always wrap the scrolling content
          in Expanded or Flexible first.
          */
          Expanded(child: _buildCounter(context)),
          Expanded(child: _buildLapDisplay()),
        ],
      ),
    );
  }

  Widget _buildCounter(BuildContext context) {
    return Container(
      color: Theme.of(context).primaryColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Lap ${laps.length + 1}',
            style: Theme.of(context)
                .textTheme
                .subtitle1
                ?.copyWith(color: Colors.white),
          ),
          Text(
            _secondsText(milliseconds),
            style: Theme.of(context)
                .textTheme
                .headline5
                ?.copyWith(color: Colors.white),
          ),
          const SizedBox(
            height: 20,
          ),
          _buildControls(),
        ],
      ),
    );
  }

  Widget _buildControls() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
            foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
          ),
          onPressed: isTicking ? null : _startTimer,
          child: const Text('Start'),
        ),
        const SizedBox(
          width: 20,
        ),
        ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(Colors.yellow),
          ),
          onPressed: isTicking ? _lap : null,
          child: const Text('Lap'),
        ),
        const SizedBox(width: 20),
        TextButton(
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
              foregroundColor: MaterialStateProperty.all<Color>(Colors.white)),
          onPressed: isTicking ? _stopTimer : null,
          child: const Text('Stop'),
        )
      ],
    );
  }

  Widget _buildLapDisplay() {
    //  ScrollViews can get too big, so it's usually a good idea to show the user their
    //  position in the list. Wrap ListView in a Scrollbar widget.
    return Scrollbar(
      child: ListView.builder(
        /*
        One other interesting thing about scrolling in Flutter is that it is platform aware. If you can,
        try running the app in both the Android Emulator and the iOS Simulator; you'll notice that
        the scroll feels different. What you are encountering is something called ScrollPhysics.
        These are objects that define how the list is supposed to scroll and what happens when you
        get to the end of the list. On iOS, the list is supposed to bounce, whereas, on Android, you
        get a glow effect when you get to the edges. The widget can pick the correct
        ScrollPhysics strategy based on the platform, but you can also override this behavior if
        you want to make the app behave in a particular way, regardless of the platform:
    
        You generally shouldn't override the platform's expected behavior, unless
        there is a good reason for doing so. It might confuse your users if they
        start adding iOS paradigms on Android and vice versa.
        */
        // physics: const BouncingScrollPhysics(),

        /* 
        ScrollController is a special object that allows to key into ListView from outside the
        build methods. This is a frequently used pattern in Flutter where you can optionally
        provide a controller object that has methods to manipulate its
        widget.
        */
        controller: scrollController,

        /*
        The itemExtent property is a way to supply a fixed height to all the items in ListView.
        Instead of letting the widget figure out its own height based on the content, using
        the itemExtent property will enforce a fixed height for every item. This has added
        performance benefits, since ListView now needs to do less work when laying out its
        children, and it also makes it easier to calculate scrolling animations.
        */
        itemExtent: itemHeight,
        itemCount: laps.length,
        itemBuilder: (context, index) {
          final milliseconds = laps[index];
          return ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 50),
            title: Text('Lap ${index + 1}'),
            trailing: Text(_secondsText(milliseconds)),
          );
        },
      ),
    );
  }

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
