import 'dart:async';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;

// dart:async and async/async.dart are different libraries: in
// many cases, you need both to run your asynchronous code
import 'package:async/async.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Future Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const FuturePage(),
    );
  }
}

class FuturePage extends StatefulWidget {
  const FuturePage({Key? key}) : super(key: key);

  @override
  _FuturePageState createState() => _FuturePageState();
}

class _FuturePageState extends State<FuturePage> {
  late Completer completer;
  late String result;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Back from the Future'),
      ),
      body: Center(
        child: Column(children: [
          const Spacer(),
          ElevatedButton(
            child: const Text('GO!'),
            onPressed: () {
              // count();

              // getNumber().then((value) {
              //   setState(() {
              //     result = value.toString();
              //   });
              // });

              // returnFB();

              returnError().then((value) {
                setState(() {
                  result = 'Success';
                });
              }).catchError((onError) {
                setState(() {
                  result = onError;
                });
              }).whenComplete(() => debugPrint('Complete'));
            },
          ),
          const Spacer(),
          Text(result.toString()),
          const Spacer(),
          const CircularProgressIndicator(),
          const Spacer(),
        ]),
      ),
    );
  }

  Future<Response> getData() async {
    const authority = 'www.googleapis.com';
    const String path = '/books/v1/volumes//junbDwAAQBAJ';
    Uri url = Uri.https(authority, path);
    return http.get(url);
  }

  Future<int> returnOneAsync() async {
    await Future<int>.delayed(const Duration(seconds: 3));
    return 1;
  }

  Future<int> returnTwoAsync() async {
    await Future<int>.delayed(const Duration(seconds: 3));
    return 2;
  }

  Future<int> returnThreeAsync() async {
    await Future<int>.delayed(const Duration(seconds: 3));
    return 3;
  }

  Future count() async {
    int total = 0;
    total = await returnOneAsync();
    total += await returnTwoAsync();
    total += await returnThreeAsync();
    setState(() {
      result = total.toString();
    });
  }

  /* 
    A Completer creates Future objects that can be completed later. The Completer.future
    that's set in the getNumber method is the Future that will be completed once complete is
    called.
  */
  Future getNumber() {
    completer = Completer<int>();
    calculate();
    return completer.future;
  }

  calculate() async {
    try {
      await Future.delayed(const Duration(seconds: 5));
      completer.complete(42);
    } catch (_) {
      completer.completeError("an error was emitted");
    }
  }

  void returnFB() {
    FutureGroup<int> futureGroup = FutureGroup<int>();

    futureGroup.add(returnOneAsync());
    futureGroup.add(returnTwoAsync());
    futureGroup.add(returnThreeAsync());
    futureGroup.close();
    futureGroup.future.then((value) {
      int total = 0;
      for (var element in value) {
        total += element;
      }
      setState(() {
        result = total.toString();
      });
    });
  }

  Future returnError() {
    throw ('Something dispecable happened!');
  }

  // handling errors with await/async is generally more readable
  Future handleError() async {
    try {
      await returnError();
    } catch (error) {
      setState(() {
        // result = error;
      });
    } finally {
      debugPrint('Complete');
    }
  }
}


/* 
FutureGroup is a collection of Futures that can be run in parallel. As all the tasks run in
parallel, the time of execution is generally faster than calling each asynchronous method
one after another.

When all the Futures of the collection have finished executing, a FutureGroup returns its
values as a List, in the same order they were added into the group.
*/
