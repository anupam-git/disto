import 'package:dio/dio.dart';
import 'package:disto/api/github/github_api.dart';
import 'package:disto/api/github/github_exceptions.dart';
import 'package:flutter/material.dart';

class GithubLoginStatusPage extends StatefulWidget {
  final String userCode;
  final String deviceCode;
  final int interval;
  final GithubApi api;

  GithubLoginStatusPage({
    Key? key,
    required this.userCode,
    required this.deviceCode,
    required this.interval,
    required this.api,
  }) : super(key: key);

  @override
  _GithubLoginStatusPageState createState() => _GithubLoginStatusPageState();
}

class _GithubLoginStatusPageState extends State<GithubLoginStatusPage> {
  Widget _generateStepHeading(String text) {
    return Row(
      children: [
        Text(
          "$text",
          style: TextStyle(
            fontWeight: FontWeight.w200,
            color: Colors.white,
            fontSize: 24,
          ),
        )
      ],
    );
  }

  // Widget _generateStepDescription(String text) {
  //   return Flexible(
  //     child: Text(
  //       text,
  //       style: TextStyle(
  //         fontWeight: FontWeight.w100,
  //         color: Colors.white,
  //         fontSize: 18,
  //       ),
  //     ),
  //   );
  // }

  void getAuthStatus() async {
    Response? authStatusResponse;
    bool didRaiseException = false;

    try {
      authStatusResponse =
          await widget.api.getAuthorizationStatus(widget.deviceCode);
    } on GHOAuthAuthorizationPendingException catch (_) {
      didRaiseException = true;

      print(
          "Authorization Pending. Rechecking after ${widget.interval + 1} seconds.");

      Future.delayed(Duration(seconds: widget.interval + 1), getAuthStatus);
    } catch (e) {
      didRaiseException = true;
      print(e);
    }

    if (!didRaiseException) {
      // Handle cases like no internet, slowdown error, etc
      print("Authorization Complete.");
      print(authStatusResponse!.data);

      Navigator.pop(context);
    }
  }

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration(seconds: widget.interval + 1), getAuthStatus);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        padding: EdgeInsets.all(24),
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
        child: SafeArea(
          child: Column(
            children: <Widget>[
              Row(
                children: [
                  Text(
                    'Authorize',
                    style: TextStyle(
                      fontWeight: FontWeight.w200,
                      fontSize: 48,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 40),
              _generateStepHeading(widget.userCode),
            ],
          ),
        ),
      ),
    );
  }
}
