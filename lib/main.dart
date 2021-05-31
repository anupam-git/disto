import 'package:disto/pages/login_page/login_page.dart';
import 'package:disto/pages/todo_page/todo_page.dart';
import 'package:disto/util/page_url.dart';
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
        primarySwatch: Colors.blueGrey,
        unselectedWidgetColor: Colors.white,
        fontFamily: 'Roboto',
      ),
      initialRoute: PageURL.LoginPageURL,
      routes: {
        PageURL.LoginPageURL: (context) => LoginPage(),
        PageURL.TodoPageURL: (context) => TodoPage(),
      },
    );
  }
}
