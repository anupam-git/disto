import 'package:disto/pages/todo_page/todo_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Disto',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TodoPage(),
    );
  }
}
