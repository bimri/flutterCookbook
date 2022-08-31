import 'package:chap08/httphelper.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'pizza_detail.dart';

// using path_provider to retrieve the documents folder in the device and the dart:io
// library to create a new file, write content, and read its content.
import 'package:path_provider/path_provider.dart';
import 'dart:io';

import './pizza.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Details'),
        ),
        body: const MyHomePage(title: 'JSON demo'),
        floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const PizzaDetail()));
            }));
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

  String documentsPath = '';
  String tempPath = '';

  late File myFile;
  String fileText = '';

  Future<List<Pizza>> callPizzas() async {
    HttpHelper helper = HttpHelper();
    List<Pizza> pizzas = await helper.getPizzaList();
    return pizzas;
  }

  Future<bool> writeFile() async {
    try {
      // writeAsString method is asychronous, but there is also a
      // synchronous version of it called writeAsStringSync().
      // Unless you have a very good reason to do otherwise, always prefer the asynchronous
      // version of the method.
      await myFile.writeAsString('Margherita, Capricciosa, Napoli');
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> readFile() async {
    try {
      // Read the file.
      String fileContent = await myFile.readAsString();
      setState(() {
        fileText = fileContent;
      });
      return true;
    } catch (e) {
      // On error, return false.
      return false;
    }
  }

  // Since the temporary directory can be cleared by the system at any time, you should use the
  // documents directory whenever you need to store data that you need to save, and use the
  // temporary directory as a sort of cache or session storage for your app.
  Future getPaths() async {
    final docDir = await getApplicationDocumentsDirectory();
    final tempDir = await getTemporaryDirectory();
    setState(() {
      documentsPath = docDir.path;
      tempPath = tempDir.path;
    });
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
    // readAndWritePreference();

    callPizzas();

    getPaths().then((_) {
      myFile = File('$documentsPath/pizzas.txt');
      writeFile();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('JSON')),
      // body: Container(
      //   child: FutureBuilder(
      //       future: callPizzas(),
      //       builder: (BuildContext context, AsyncSnapshot<List<Pizza>> pizzas) {
      //         return ListView.builder(
      //             itemCount: (pizzas.data == null) ? 0 : pizzas.data.length,
      //             itemBuilder: (BuildContext context, int position) {
      //               return ListTile(
      //                 title: Text(pizzas.data[position]?.pizzaName),
      //                 subtitle: Text(pizzas.data[position]?.description +
      //                     ' - € ' +
      //                     pizzas.data[position].price.toString()),
      //               );
      //             });
      //       }),
      // ),
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
