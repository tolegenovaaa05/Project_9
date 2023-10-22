import 'package:flutter/material.dart';
import 'package:flutter_9lb_aruka/firstpage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.yellow,
      ),
      home: FirstPage(),
    );
  }
}
