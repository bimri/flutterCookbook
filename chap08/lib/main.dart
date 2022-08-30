import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import './pizza.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter JSON Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const MyHomePage(title: 'JSON demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late int appCounter;
  String pizzaString = '';

  // method transforms our List of Pizza objects back into a Json string by
  // calling the jsonEncode method again in the dart_convert library
  String convertToJSON(List<Pizza> pizzas) {
    String json = '[';
    for (var pizza in pizzas) {
      json += jsonEncode(pizza);
    }
    json += ']';
    return json;
  }

  Future readAndWritePreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    appCounter = prefs.getInt('appCounter')!;
    // ignore: unnecessary_null_comparison
    if (appCounter == null) {
      appCounter = 1;
    } else {
      appCounter++;
    }

    await prefs.setInt('appCounter', appCounter);

    setState(() {
      appCounter = appCounter;
    });
  }

  Future deletePreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    setState(() {
      appCounter = 0;
    });
  }

  @override
  void initState() {
    // readJsonFile();
    readAndWritePreference();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text('You have opened the app $appCounter times.'),
            ElevatedButton(
              onPressed: () {
                deletePreference();
              },
              child: const Text('Reset counter'),
            )
          ],
        ),
      ),
    );
  }

  Future<List<Pizza>> readJsonFile() async {
    // Reading the JSON file
    String myString = await DefaultAssetBundle.of(context)
        .loadString('assets/pizzalist.json');

    // Transforming the JSON string into a list of Map objects
    List myMap = jsonDecode(myString);

    List<Pizza> myPizzas = [];

    for (var pizza in myMap) {
      Pizza myPizza = Pizza.fromJsonOrNull(pizza);
      myPizzas.add(myPizza);
    }

    String json = convertToJSON(myPizzas);

    return myPizzas;
  }
}
