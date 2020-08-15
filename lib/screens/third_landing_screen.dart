import 'package:flutter/material.dart';
import 'package:lumini_chat/widgets/AZWidgets.dart';

class ThirdLandingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Container(
      color: Color(0xff829298),
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
                  'assets/images/thanks.png',
                ),
                height: screenHeight * 0.3,
              ),
            ),
            SizedBox(
              height: screenHeight * 0.09,
            ),
            Center(
              child: Text(
                'Thank You For Choosing',
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
                'Lumini Chat',
                style: azTitleStyle(
                  fontSize: screenWidth * 0.07,
                  italic: true,
                  buildContext: context,
                  color: Theme.of(context).accentColor,
                ),
              ),
            ),
            SizedBox(
              height: screenHeight * 0.09,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.01),
              child: Text(
                'Stay tuned for the latest updates',
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
                'Stay secure!',
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
