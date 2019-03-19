import 'package:BirthmarkRecognition/views/analysis.dart';
import 'package:flutter/material.dart';


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
