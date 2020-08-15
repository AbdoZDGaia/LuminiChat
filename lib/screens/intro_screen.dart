import 'package:flutter/material.dart';
import 'package:liquid_swipe/liquid_swipe.dart';
import 'package:lumini_chat/helper/authenticate.dart';
import 'package:lumini_chat/screens/first_landing_screen.dart';
import 'package:lumini_chat/screens/second_landing_screen.dart';
import 'package:lumini_chat/screens/third_landing_screen.dart';
import 'package:lumini_chat/widgets/AZWidgets.dart';

class IntroScreen extends StatefulWidget {
  @override
  _IntroScreenState createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  int page = 0;
  LiquidController liquidController;
  UpdateType updateType;
  final pages = [
    FirstLandingScreen(),
    SecondLandingScreen(),
    ThirdLandingScreen(),
  ];

  @override
  void initState() {
    liquidController = LiquidController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    pageChangeCallback(int lpage) {
      setState(() {
        page = lpage;
      });
    }

    return Scaffold(
      backgroundColor: Color(0xff829298),
      body: Stack(
        children: <Widget>[
          LiquidSwipe(
            pages: pages,
            onPageChangeCallback: pageChangeCallback,
            waveType: WaveType.liquidReveal,
            fullTransitionValue: 300,
            liquidController: liquidController,
            ignoreUserGestureWhileAnimating: true,
            enableSlideIcon: true,
            positionSlideIcon: 0.5,
            enableLoop: true,
          ),
          Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: EdgeInsets.only(top: screenHeight * 0.07),
              child: RaisedButton(
                color: Theme.of(context).accentColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    topLeft: Radius.circular(20),
                  ),
                ),
                padding: EdgeInsets.all(0),
                elevation: 10,
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) {
                      return Authenticate();
                    }),
                  );
                },
                child: Text(
                  'Skip',
                  style: azSimpleTextStyle(
                    fontSize: screenHeight * 0.03,
                    italic: true,
                    buildContext: context,
                    color: Colors.blueGrey,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
