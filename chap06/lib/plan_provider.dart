import 'package:chap06/controllers/plan_controllers.dart';
import 'package:flutter/material.dart';
// import './models/data_layer.dart';

// InheritedWidget is an abstract class
// must implement the updateShouldNotify method
class PlanProvider extends InheritedWidget {
  final _controller = PlanController();
  // define an object that will store the plans
  // final _plan = <Plan>[];

  // default  unnamed constructor
  PlanProvider({Key? key, required Widget child})
      : super(key: key, child: child);

  // look at the content of the old widget and
  // determine if the child widgets need to be
  // notified that the data has changed
  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    // return false and opt-out of this functionality
    return false;
  }

  // kick off the tree traversal process
  // Flutter will start from the widget that owns this context
  // and travel upward until it finds a PlanProvider.
  static PlanController of(BuildContext context) {
    final provider = context.dependOnInheritedWidgetOfExactType<PlanProvider>();
    return provider!._controller;
  }

  /*
  An interesting side effect of this method is that after it is called, the originating widget is
  registered as a dependency. This now creates a hard link between the child widget and
  PlanProvider. The next time this method is called, there is no need to travel up the tree
  anymore; the child already knows where the data is and can retrieve it immediately. This
  optimization makes it extremely fast, if not almost instant, to get the data from
  InheritedWidgets, no matter how deep the tree goes.
  */
}
