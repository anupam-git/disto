import 'package:disto/api/github/github_api.dart';
import 'package:disto/api/github/oauth_response_codes_dto.dart';
import 'package:disto/pages/login_page/github_login_status_page.dart';
import 'package:disto/pages/login_page/login_status_widget.dart';
import 'package:disto/util/constants.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  final _api = GithubApi.oauth();
  LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  LoginState _loginState = LoginState.NotLoggedIn;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomLeft,
            end: Alignment.topRight,
            colors: <Color>[
              Colors.purple.shade600,
              Colors.indigo.shade600,
            ],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              width: 128,
              height: 128,
              child: Material(
                elevation: 25,
                shape: CircleBorder(),
                clipBehavior: Clip.antiAlias,
                color: Colors.transparent,
                shadowColor: Colors.black,
                child: Image.asset(
                  'assets/logo-white.png',
                  filterQuality: FilterQuality.high,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                top: 48,
              ),
              child: Text(
                'Disto',
                style: const TextStyle(
                  fontSize: 78,
                  color: Colors.white,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                bottom: 160,
              ),
              child: Text(
                'A Dead Simple TODO list',
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w100,
                  fontSize: 16,
                ),
              ),
            ),
            LoginStatusWidget(
              loginState: _loginState,
              onLoginButtonPressed: () async {
                setState(() {
                  _loginState = LoginState.LoggingIn;
                });

                // final prefs = await SharedPreferences.getInstance();

                // prefs.setBool(Constants.preferenceField.isLoggedIn, true);
                // prefs.setBool(Constants.preferenceField.shouldSync, true);

                // Future.delayed(Duration(milliseconds: 500), () {
                //   Navigator.pushNamed(context, Constants.pageUrl.todo);
                // });

                OAuthResponseCodesDTO codes = await widget._api.getCodes();
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => GithubLoginStatusPage(
                      userCode: codes.userCode,
                      deviceCode: codes.deviceCode,
                      interval: codes.interval,
                      api: widget._api,
                    ),
                  ),
                );
              },
              onSkipPressed: () async {
                setState(() {
                  _loginState = LoginState.LoggingIn;
                });

                final prefs = await SharedPreferences.getInstance();

                prefs.setBool(Constants.preferenceField.isLoggedIn, true);
                prefs.setBool(Constants.preferenceField.shouldSync, false);

                Future.delayed(Duration(milliseconds: 500), () {
                  Navigator.popAndPushNamed(context, Constants.pageUrl.todo);
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
