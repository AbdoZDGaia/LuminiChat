import 'package:flutter/material.dart';
import 'package:lumini_chat/widgets/AZWidgets.dart';

class SecondLandingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Container(
      color: Theme.of(context).accentColor,
      child: Padding(
        padding: EdgeInsets.symmetric(
            vertical: screenHeight * 0.1, horizontal: screenWidth * 0.1),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: screenHeight * 0.05,
            ),
            Center(
              child: Image(
                image: AssetImage(
                  'assets/images/privacy.png',
                ),
                height: screenHeight * 0.3,
              ),
            ),
            SizedBox(
              height: screenHeight * 0.09,
            ),
            Center(
              child: Text(
                'Choose When to Chat',
                style: azTitleStyle(
                  fontSize: screenWidth * 0.07,
                  italic: true,
                  buildContext: context,
                  color: Colors.blueGrey,
                ),
              ),
            ),
            Center(
              child: Text(
                'And Whom to Chat',
                style: azTitleStyle(
                  fontSize: screenWidth * 0.07,
                  italic: true,
                  buildContext: context,
                  color: Colors.blueGrey,
                ),
              ),
            ),
            SizedBox(
              height: screenHeight * 0.09,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.01),
              child: Text(
                'Privacy is guaranteed',
                style: azSimpleTextStyle(
                  fontSize: screenWidth * 0.05,
                  buildContext: context,
                  color: Colors.blueGrey,
                ),
              ),
            ),
            SizedBox(
              height: screenHeight * 0.01,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.01),
              child: Text(
                'Stay connected away from prying eyes',
                style: azSimpleTextStyle(
                  fontSize: screenWidth * 0.05,
                  buildContext: context,
                  color: Colors.blueGrey,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
