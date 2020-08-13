import 'package:flutter/material.dart';
import 'package:lumini_chat/widgets/AZWidgets.dart';

class SecondLandingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Padding(
      padding: EdgeInsets.all(40.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Center(
            child: Image(
              image: AssetImage(
                'assets/images/privacy.png',
              ),
              height: 200,
              width: 300,
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Text(
            'Stay Secure!',
            style: azTitleStyle(
              buildContext: context,
              color: Theme.of(context).accentColor,
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Text(
            'Privacy is guaranteed.\nStay connected away from prying eyes.',
            style: azSimpleTextStyle(
              buildContext: context,
              color: Theme.of(context).accentColor,
            ),
          ),
        ],
      ),
    );
  }
}
