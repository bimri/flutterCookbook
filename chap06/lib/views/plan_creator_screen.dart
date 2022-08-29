import 'dart:ffi';

import 'package:chap06/plan_provider.dart';
import 'package:chap06/views/plan_screen.dart';
import 'package:flutter/material.dart';

import '../models/plan.dart';

class PlanCreatorScreen extends StatefulWidget {
  const PlanCreatorScreen({Key? key}) : super(key: key);

  @override
  State<PlanCreatorScreen> createState() => _PlanCreatorScreenState();
}

class _PlanCreatorScreenState extends State<PlanCreatorScreen> {
  final textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Master Plans')),
      body: Column(
        children: <Widget>[
          _buildListCreator(),
          Expanded(
            child: _buildMasterPlans(),
          ),
        ],
      ),
    );
  }

  Widget _buildListCreator() {
    return Padding(
        padding: const EdgeInsets.all(20.0),
        child: Material(
          color: Theme.of(context).cardColor,
          elevation: 10,
          child: TextField(
              controller: textController,
              decoration: InputDecoration(
                labelText: 'Add a plan',
                contentPadding: EdgeInsets.all(20),
              ),
              onEditingComplete: addPlan),
        ));
  }

  // addPlan method will check whether the user actually typed something into
  // the field and will then reset the screen
  void addPlan() {
    final text = textController.text;
    if (text.isEmpty) {
      return;
    }

    final plan = Plan()..name = text;
    PlanProvider.of(context).add(plan);
    textController.clear();
    FocusScope.of(context).requestFocus(FocusNode());
    setState(() {});
  }

  Widget _buildMasterPlans() {

    if (plans.isEmpty) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(
            Icons.note,
            size: 100,
            color: Colors.grey,
          ),
          Text(
            'You do not have any plans yet.',
            style: Theme.of(context).textTheme.headline5,
          )
        ],
      );
    }

    return ListView.builder(
      itemCount: plans.length,
      itemBuilder: ((context, index) {
        final plan = plans[index];
        return ListTile(
          title: Text(plan.completenessMessage),
          subtitle: Text(plan.completenessMessage),
          onTap: () {
            Navigator.of(context).push (
              MaterialPageRoute(
                builder: (_) => PlanScreen(plan: plan)
              )
            );
          }
        );
      }),
    );
  }

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }
}
