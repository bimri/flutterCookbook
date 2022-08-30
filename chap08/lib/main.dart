import 'package:flutter/material.dart';
import 'dart:convert';

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
  String pizzaString = '';

  @override
  void initState() {
    readJsonFile();
    super.initState();
  }

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      // body: FutureBuilder(
      //     future: readJsonFile(),
      //     builder: (BuildContext context, AsyncSnapshot<List<Pizza>> pizzas) {
      //       return ListView.builder(
      //           itemCount: (pizzas.data == null) ? 0 : pizzas.data?.length,
      //           itemBuilder: (BuildContext context, int position) {
      //             return ListTile(
      //               title: Text(pizzas.data[position]?.pizzaName),
      //               subtitle: Text(pizzas.data![position].description +
      //                   ' -€ ' +
      //                   pizzas.data[position]?.price.toString()),
      //             );
      //           });
      //     }),
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
      if (myPizza != null) myPizzas.add(myPizza);
    }

    String json = convertToJSON(myPizzas);

    return myPizzas;
  }
}
