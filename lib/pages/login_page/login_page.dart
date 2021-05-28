import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          color: Colors.black,
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
              margin: EdgeInsets.only(
                bottom: 24,
              ),
              width: 100,
              height: 100,
              child: Material(
                elevation: 25,
                shape: CircleBorder(),
                clipBehavior: Clip.antiAlias,
                color: Colors.transparent,
                shadowColor: Colors.black,
                child: Image.asset('assets/logo.png'),
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                bottom: 128,
              ),
              child: Text(
                'Disto',
                style: const TextStyle(
                  // fontWeight: FontWeight.bold,
                  fontSize: 100,
                  color: Colors.white,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                bottom: 128,
              ),
              child: Text(
                'A Dead Simple TODO list',
                style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w100,
                    fontSize: 16),
              ),
            ),
            OutlinedButton(
              onPressed: () => print('Login to Github'),
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
          ],
        ),
      ),
    );
  }
}
