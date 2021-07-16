import 'dart:math';

import 'package:disto/util/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

class GithubAuthDialog extends StatelessWidget {
  final String userCode;
  final String deviceCode;

  GithubAuthDialog({
    Key? key,
    required this.userCode,
    required this.deviceCode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4),
      ),
      backgroundColor: Colors.transparent,
      elevation: 0,
      child: Stack(
        children: <Widget>[
          Container(
            width: min(MediaQuery.of(context).size.width, 400),
            padding: EdgeInsets.only(
              left: Constants.padding,
              top: Constants.avatarRadius + Constants.padding,
              right: Constants.padding,
              bottom: Constants.padding,
            ),
            margin: EdgeInsets.only(top: Constants.avatarRadius),
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  this.userCode,
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
                ),
                SizedBox(height: 15),
                Text(
                  "Enter the code when prompted",
                  style: TextStyle(fontSize: 14),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 22),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    OutlinedButton(
                      style: OutlinedButton.styleFrom(side: BorderSide.none),
                      onPressed: () {
                        final snackBar = SnackBar(
                          content: Text('Copied'),
                          duration: Duration(seconds: 1),
                        );
                        Clipboard.setData(ClipboardData(text: this.userCode));
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      },
                      child: Text("Copy"),
                    ),
                    OutlinedButton(
                      style: OutlinedButton.styleFrom(side: BorderSide.none),
                      onPressed: () {
                        launch("https://github.com/login/device");
                      },
                      child: Text("Login"),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Positioned(
            left: Constants.padding,
            right: Constants.padding,
            child: CircleAvatar(
              backgroundColor: Colors.white,
              radius: Constants.avatarRadius,
              child: ClipRRect(
                borderRadius:
                    BorderRadius.all(Radius.circular(Constants.avatarRadius)),
                child: Image.asset(
                  "assets/github-logo.png",
                  width: 74,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
