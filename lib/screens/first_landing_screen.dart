import 'package:flutter/material.dart';
import 'package:lumini_chat/widgets/AZWidgets.dart';

class FirstLandingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Container(
      color: Colors.red,
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
                  'assets/images/logo1.png',
                ),
                height: screenHeight * 0.3,
              ),
            ),
            SizedBox(
              height: screenHeight * 0.09,
            ),
            Center(
              child: Text(
                'Lumini Chat',
                style: azTitleStyle(
                  fontSize: screenWidth * 0.07,
                  italic: true,
                  buildContext: context,
                  color: Theme.of(context).accentColor,
                ),
              ),
            ),
            Center(
              child: Text(
                'Stay Connected!',
                style: azTitleStyle(
                  fontSize: screenWidth * 0.07,
                  italic: true,
                  buildContext: context,
                  color: Theme.of(context).accentColor,
                ),
              ),
            ),
            SizedBox(
              height: screenHeight * 0.07,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.01),
              child: Text(
                'Privacy is our goal',
                style: azSimpleTextStyle(
                  fontSize: screenWidth * 0.05,
                  buildContext: context,
                  color: Theme.of(context).accentColor,
                ),
              ),
            ),
            SizedBox(
              height: screenHeight * 0.01,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.01),
              child: Text(
                'A must that everyone should have',
                style: azSimpleTextStyle(
                  fontSize: screenWidth * 0.05,
                  buildContext: context,
                  color: Theme.of(context).accentColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
