import 'package:flutter/material.dart';

class DismissibleScreen extends StatefulWidget {
  const DismissibleScreen({super.key});

  @override
  State<DismissibleScreen> createState() => _DismissibleScreenState();
}

class _DismissibleScreenState extends State<DismissibleScreen> {
  final List<String> sweets = [
    'Petit Four',
    'Cupcake',
    'Donut',
    'Éclair',
    'Froyo',
    'Gingerbread ',
    'Honeycomb ',
    'Ice Cream Sandwich',
    'Jelly Bean',
    'KitKat'
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dismissible Example'),
      ),
      body: ListView.builder(
        itemCount: sweets.length,
        itemBuilder: (context, index) {
          return Dismissible(
            key: Key(sweets[index]),
            child: ListTile(
              title: Text(sweets[index]),
            ),
            onDismissed: (direction) {
              sweets.removeAt(index);
            },
          );
        },
      ),
    );
  }
}
