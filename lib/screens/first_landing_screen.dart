import 'package:flutter/material.dart';
import 'package:lumini_chat/widgets/AZWidgets.dart';

class FirstLandingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Container(
      color: Theme.of(context).primaryColor,
      child: Padding(
        padding: EdgeInsets.symmetric(
            vertical: screenHeight * 0.1, horizontal: screenWidth * 0.1),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: screenHeight * 0.08,
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
              height: 30,
            ),
            Text(
              'Lumini Chat..\nStay Connected',
              style: azTitleStyle(
                fontSize: screenWidth*0.07,
                italic: true,
                buildContext: context,
                color: Theme.of(context).accentColor,
              ),
            ),
            SizedBox(
              height: screenHeight*0.07,
            ),
            Text(
              'Privacy is our goal, a must that everyone should have.',
              style: azSimpleTextStyle(
                buildContext: context,
                color: Theme.of(context).accentColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
