import 'package:flutter/material.dart';
import 'package:todo/util/constants.dart';

class TodoPage extends StatefulWidget {
  TodoPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _TodoPageState createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Container(
          child: Text(Constants.param1),
        ),
      ),
    );
  }
}
