import 'package:disto/pages/login_page/login_page.dart';
import 'package:disto/pages/login_page/github_login_status_page.dart';
import 'package:disto/pages/splash_page/splash_page.dart';
import 'package:disto/pages/todo_page/todo_page.dart';
import 'package:disto/util/constants.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var _theme = new ThemeData(
      primarySwatch: Colors.blueGrey,
      unselectedWidgetColor: Colors.white,
      fontFamily: 'Roboto',
    );

    var _routes = {
      Constants.pageUrl.splash: (context) => SplashPage(key: UniqueKey()),
      Constants.pageUrl.login: (context) => LoginPage(key: UniqueKey()),
      Constants.pageUrl.todo: (context) => TodoPage(key: UniqueKey()),
    };

    return MaterialApp(
      key: UniqueKey(),
      title: 'Disto',
      theme: _theme,
      initialRoute: Constants.pageUrl.splash,
      // home: OAuthAuthorizePage(key: UniqueKey()),
      routes: _routes,
    );
  }
}
