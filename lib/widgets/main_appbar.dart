import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lumini_chat/helper/authenticate.dart';
import 'package:lumini_chat/helper/helper_methods.dart';
import 'package:lumini_chat/services/auth.dart';
import 'package:flutter/foundation.dart';

Widget mainAppBar({
  @required BuildContext buildContext,
  bool logoutIconIncluded = false,
  double iconSize = 35,
  String title = 'Lumini Chat',
  bool centerTitle = false,
}) {
  final double screenHeight = MediaQuery.of(buildContext).size.height;
  final double screenWidth = MediaQuery.of(buildContext).size.width;
  AuthMethods authMethods = new AuthMethods();

  return AppBar(
    iconTheme: new IconThemeData(
        color: Theme.of(buildContext).accentColor, size: iconSize),
    elevation: 0.0,
    centerTitle: centerTitle,
    title: Padding(
      padding: EdgeInsets.only(
        top: screenHeight * 0.01,
        bottom: screenHeight * 0.02,
        left: screenWidth * 0.01,
      ),
      child: FittedBox(
        fit: BoxFit.fill,
        child: Text(
          title,
          style: TextStyle(
            color: Theme.of(buildContext).accentColor,
            fontSize: 30.0,
            // letterSpacing: 5,
            fontFamily: 'RacingSansOne',
            // fontWeight: FontWeight.bold,
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
                  HelperFunctions.setIsUserLoggedInSharedPreferences(false);
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
