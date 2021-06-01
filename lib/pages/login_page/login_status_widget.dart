import 'package:disto/pages/login_page/login_page.dart';
import 'package:flutter/material.dart';

class LoginStatusWidget extends StatelessWidget {
  final LoginState loginState;
  final VoidCallback onLoginButtonPressed;

  LoginStatusWidget({
    required this.loginState,
    required this.onLoginButtonPressed,
  });

  @override
  Widget build(BuildContext context) {
    if (loginState == LoginState.NotLoggedIn) {
      // User not logged in
      return Column(
        children: <Widget>[
          OutlinedButton(
            onPressed: onLoginButtonPressed,
            child: Text('Sign In with GitHub'),
            style: OutlinedButton.styleFrom(
              primary: Colors.white,
              side: BorderSide(
                color: Colors.white60,
                width: 2,
              ),
              padding: EdgeInsets.only(
                left: 48,
                right: 48,
                top: 12,
                bottom: 12,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(
              top: 24,
            ),
            child: Text(
              // 'Continue without remote sync',
              'Skip',
              style: const TextStyle(
                color: Colors.white70,
                decoration: TextDecoration.underline,
              ),
            ),
          ),
        ],
      );
    } else if (loginState == LoginState.LoggingIn ||
        loginState == LoginState.Syncing) {
      // Login/Sync operation in progress
      return Column(
        children: <Widget>[
          CircularProgressIndicator(
            color: Colors.white,
          ),
          Container(
            margin: EdgeInsets.only(
              top: 12,
            ),
            child: Text(
              loginState == LoginState.LoggingIn ? 'Logging In' : 'Syncing',
              style: const TextStyle(
                  color: Colors.white38,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.w100),
            ),
          )
        ],
      );
    } else if (loginState == LoginState.SyncComplete) {
      // Sync operation is complete
      return Icon(
        Icons.check_circle,
        size: 48,
        color: Colors.green,
      );
    } else {
      // Control should never come here
      return Container();
    }
  }
}
