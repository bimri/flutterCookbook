import 'package:chap05/stopwatch.dart';
import 'package:flutter/material.dart';
import 'login_screen.dart';
import 'stopwatch.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const LoginScreen(),
      routes: {
        '/': (context) => const LoginScreen(),
        LoginScreen.route: (context) => const LoginScreen(),
        StopWatch.route: (context) => const StopWatch(),
      },
      initialRoute: '/',
    );
  }
}

/* 
There is one significant difference between named routes and manually
constructed routes – you cannot use custom constructors to pass data to the next
screen. Instead, you can use route arguments.
*/
