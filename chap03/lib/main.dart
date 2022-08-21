import 'package:chap03/basic_screen.dart';
import 'package:flutter/material.dart';

void main() => runApp(const StaticApp());

class StaticApp extends StatelessWidget {
  const StaticApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.green,
        appBarTheme: const AppBarTheme(
          elevation: 10,
          textTheme: TextTheme(
            subtitle1: TextStyle(
              fontFamily: 'LeckerliOne',
              fontSize: 24,
            ),
          ),
        ),
      ),
      home: const BasicScreen(),
    );
  }
}
