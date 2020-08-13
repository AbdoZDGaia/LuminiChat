import 'package:flutter/material.dart';
import 'package:lumini_chat/widgets/AZWidgets.dart';

class FirstLandingScreen extends StatelessWidget {
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
              buildContext: context,
              color: Theme.of(context).accentColor,
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Text(
            'Privacy is our goal, a must that everyone should have',
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
