import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lumini_chat/helper/authenticate.dart';
import 'package:lumini_chat/services/auth.dart';
import 'package:flutter/foundation.dart';

Widget mainAppBar(
    {@required BuildContext buildContext,
    bool logoutIconIncluded = false,
    double iconSize = 35}) {
  final double screenHeight = MediaQuery.of(buildContext).size.height;
  final double screenWidth = MediaQuery.of(buildContext).size.width;
  AuthMethods authMethods = new AuthMethods();

  return AppBar(
    elevation: 0.0,
    centerTitle: false,
    title: Padding(
      padding: EdgeInsets.only(
        top: screenHeight * 0.01,
        bottom: screenHeight * 0.02,
        left: screenWidth * 0.01,
      ),
      child: FittedBox(
        fit: BoxFit.fill,
        child: Text(
          'Lumini Chat',
          style: TextStyle(
            color: Theme.of(buildContext).accentColor,
            fontSize: 28.0,
            letterSpacing: 5,
            fontFamily: 'Lobster',
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    ),
    actions: [
      logoutIconIncluded
          ? Padding(
              padding: EdgeInsets.only(
                top: screenHeight * 0.003,
                bottom: screenHeight * 0.02,
                right: screenWidth * 0.01,
              ),
              child: IconButton(
                icon: Icon(
                  Icons.exit_to_app,
                  color: Theme.of(buildContext).accentColor,
                ),
                onPressed: () {
                  authMethods.signOut();
                  return Navigator.pushReplacement(
                      buildContext,
                      MaterialPageRoute(
                          builder: (buildContext) => Authenticate()));
                },
                iconSize: iconSize,
              ),
            )
          : SizedBox.shrink(),
    ],
  );
}
