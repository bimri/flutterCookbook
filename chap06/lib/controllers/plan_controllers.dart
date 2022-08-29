// responsible for all the business logic in our app

import '../models/data_layer.dart';

class PlanController {
  final _plans = <Plan>[];
  // This public getter cannot be modified by any other object
  List<Plan> get plans => List.unmodifiable(_plans);

  // methods that will be responsible for creating and deleting plans.
  String _checkForDuplicates(Iterable<String> items, String text) {
    final duplicatedCount = items.where((item) => item.contains(text)).length;

    if (duplicatedCount > 0) {
      text += ' ${duplicatedCount + 1}';
    }
    return text;
  }

  // use our new business logic to check the input for new plans
  void addNewPlan(String name) {
    if (name.isEmpty) {
      return;
    }

    name = _checkForDuplicates(_plans.map((plan) => plan.name), name);

    final plan = Plan()..name = name;
    _plans.add(plan);
  }

  // method for deleting a plan
  void deletePlan(Plan plan, Task task) {
    _plans.remove(plan);
  }

  // method to add a new Task
  void createNewTask(Plan plan, [String? description]) {
    if (description == null || description.isEmpty) {
      description = 'New Task';
    }

    description = _checkForDuplicates(
        plan.tasks.map((task) => task.description), description);

    final task = Task()..description = description;
    plan.tasks.add(task);
  }

  // method for deleting a task
  void deleteTask(Plan plan, Task task) {
    plan.tasks.remove(task);
  }
}

/* 
proper separation of concerns, the only
place PlanController is allowed to be instantiated 
is in the PlanProvider class.
*/


/* 
Immediately underneath the view is where you put your controllers. For the purposes of
this design, the job of the controllers is to process business logic. Business logic is defined
as any rule in your app that is not related to presentation (view) or persistence (databases,
web services, and so on). The Master Plan app is pretty thin on business logic, but one key
functionality that we added was a check to make sure that duplicates aren't created. This
procedure has nothing to with the user interface; subsequently, it would be confusing to
place it there. The correct place to store the _checkForDuplicates method is in the
controller. You were able to reuse this exact same method for both plans and tasks. If this
was placed inside the widgets, we would have to either write this code twice, once for each
widget, or conjure some contrived inheritance structure. Either way, giving each class type
a "job" and making sure that these roles are respected thins out the widgets and allows us to
focus on one task at a time.
*/
