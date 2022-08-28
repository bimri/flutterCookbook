import 'package:flutter/material.dart';

import '../models/data_layer.dart';

class PlanScreen extends StatefulWidget {
  final Plan? plan;
  const PlanScreen({Key? key, this.plan}) : super(key: key);

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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Master Plan'),
      ),
      body: _buildList(),
      floatingActionButton: _buildAddTaskButton(),
    );
  }

  Widget _buildAddTaskButton() {
    return FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          plan?.tasks.add(Task());
        });
  }

  Widget _buildList() {
    return ListView.builder(
      controller: scrollController,
      itemBuilder: (context, index) => _buildTaskTile(plan!.tasks[index]),
    );
  }

  Widget _buildTaskTile(Task task) {
    return ListTile(
      leading: Checkbox(
        value: task.complete,
        onChanged: (selected) {
          setState(() {
            task.complete = selected!;
          });
        },
      ),
      title: TextField(
        onChanged: (text) {
          setState(() {
            task.description = text;
          });
        },
      ),
    );
  }

  @override
  void dispose() {
    scrollController?.dispose();
    super.dispose();
  }
}
