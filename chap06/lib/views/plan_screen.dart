import 'package:chap06/plan_provider.dart';
import 'package:flutter/material.dart';

import '../models/data_layer.dart';

class PlanScreen extends StatefulWidget {
  final Plan plan;
  const PlanScreen({Key? key, required this.plan}) : super(key: key);

  @override
  State<PlanScreen> createState() => _PlanScreenState();
}

class _PlanScreenState extends State<PlanScreen> {
  Plan? get plan => widget.plan;
  ScrollController? scrollController;

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController()
      ..addListener(() {
        FocusScope.of(context).requestFocus(FocusNode());
      });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        final controller = PlanProvider.of(context);
        controller.savePlan(plan!);
        return Future.value(true);
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Master Plan'),
        ),
        body: Column(
          children: <Widget>[
            Expanded(child: _buildList()),
            SafeArea(child: Text(plan!.completenessMessage))
          ],
        ),
        floatingActionButton: _buildAddTaskButton(),
      ),
    );
  }

  Widget _buildAddTaskButton() {
    return FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          final controller = PlanProvider.of(context);
          controller.createNewTask(plan!);
        });
  }

  Widget _buildList() {
    return ListView.builder(
      controller: scrollController,
      itemBuilder: (context, index) => _buildTaskTile(plan!.tasks[index]),
    );
  }

  Widget _buildTaskTile(Task task) {
    return Dismissible(
      key: ValueKey(task),
      background: Container(
        color: Colors.red,
      ),
      direction: DismissDirection.endToStart,
      onDismissed: (_) {
        final controller = PlanProvider.of(context);
        controller.deletePlan(plan!, task);
        setState(() {});
      },
      child: ListTile(
        leading: Checkbox(
          value: task.complete,
          onChanged: (selected) {
            setState(() {
              task.complete = selected!;
            });
          },
        ),
        title: TextFormField(
          initialValue: task.description,
          onFieldSubmitted: (text) {
            setState(() {
              task.description = text;
            });
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    scrollController?.dispose();
    super.dispose();
  }
}
