import 'package:disto/util/constants.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashPage extends StatefulWidget {
  SplashPage({Key? key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  bool isLoggedIn = false;

  void setIsLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    isLoggedIn = prefs.getBool(Constants.preferenceField.isLoggedIn) ?? false;

    if (isLoggedIn) {
      Navigator.popAndPushNamed(
        context,
        Constants.pageUrl.todo,
      );
    } else {
      Navigator.popAndPushNamed(
        context,
        Constants.pageUrl.login,
      );
    }
  }

  @override
  void initState() {
    super.initState();

    setIsLoggedIn();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Colors.white,
      child: Center(
        child: SizedBox(
          width: 128,
          height: 128,
          child: Image.asset(
            'assets/logo-colored.png',
            filterQuality: FilterQuality.high,
          ),
        ),
      ),
    );
  }
}
