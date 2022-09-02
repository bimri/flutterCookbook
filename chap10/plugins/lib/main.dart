import 'package:flutter/material.dart';
import 'package:area/area.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Packages Demo',
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const PackageScreen(),
    );
  }
}

class PackageScreen extends StatefulWidget {
  const PackageScreen({super.key});

  @override
  State<PackageScreen> createState() => _PackageScreenState();
}

class _PackageScreenState extends State<PackageScreen> {
  final TextEditingController txtHeight = TextEditingController();
  final TextEditingController txtWidth = TextEditingController();
  String result = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Package App'),
      ),
      body: Column(
        children: [
          AppTextField(txtWidth, 'Width'),
          AppTextField(txtHeight, 'Height'),
          const Padding(padding: EdgeInsets.all(24)),
          ElevatedButton(
              onPressed: () {
                double? width = double.tryParse(txtWidth.text);
                double? height = double.tryParse(txtHeight.text);
                String res = calculateAreaRect(width!, height!);
                setState(() {
                  result = res;
                });
              },
              child: const Text('Calculate Area')),
          const Padding(padding: EdgeInsets.all(24)),
          Text(result),
        ],
      ),
    );
  }
}

class AppTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  const AppTextField(this.controller, this.label, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(hintText: label),
      ),
    );
  }
}
