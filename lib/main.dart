import 'package:flutter/material.dart';
import 'package:mobile_app/views/analysis.dart';

void main() => runApp(MyApp());

/// Root widget
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Birthmark Classification',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}
