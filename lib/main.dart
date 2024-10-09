import 'package:flutter/material.dart';
import 'package:flutter_warnet/InputPage.dart';

void main() {
  runApp(Warnet());
}

class Warnet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Form Warnet',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: InputPage(),
    );
  }
}
