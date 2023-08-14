import 'package:flutter/material.dart';
import 'package:nata_food/views/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nata Food',
      theme: ThemeData(
          primarySwatch: Colors.indigo,
          primaryColor: Colors.white,
          textTheme: TextTheme(bodyText2: TextStyle(color: Colors.white))),
      home: HomePage(),
    );
  }
}
