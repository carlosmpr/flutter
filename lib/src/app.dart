import 'package:animation/src/screens/home.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  Widget build(context) {
    return MaterialApp(
      title: 'Animation',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: Home(),
    );
  }
}
