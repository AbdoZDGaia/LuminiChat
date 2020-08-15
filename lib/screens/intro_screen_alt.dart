import 'dart:math';
import 'package:flutter/material.dart';
import 'package:liquid_swipe/liquid_swipe.dart';
import 'package:lumini_chat/helper/authenticate.dart';
import 'package:lumini_chat/screens/first_landing_screen.dart';
import 'package:lumini_chat/screens/second_landing_screen.dart';
import 'package:lumini_chat/screens/third_landing_screen.dart';
import 'package:lumini_chat/widgets/AZWidgets.dart';

class IntroScreenAlt extends StatefulWidget {
  @override
  _IntroScreenAltState createState() => _IntroScreenAltState();
}

class _IntroScreenAltState extends State<IntroScreenAlt> {
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

  Widget _buildDot(int index) {
    double selectedness = Curves.easeOut.transform(
      max(
        0.0,
        1.0 - ((page ?? 0) - index).abs(),
      ),
    );
    double zoom = 1.0 + (2.0 - 1.0) * selectedness;
    return new Container(
      width: 25.0,
      child: new Center(
        child: new Material(
          color: Colors.black,
          type: MaterialType.circle,
          child: new Container(
            width: 8.0 * zoom,
            height: 8.0 * zoom,
          ),
        ),
      ),
    );
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
      backgroundColor: Theme.of(context).primaryColor,
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
          ),
          Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              children: <Widget>[
                Expanded(child: SizedBox()),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List<Widget>.generate(pages.length, _buildDot),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: EdgeInsets.only(top: screenHeight*0.07),
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
                      buildContext: context, color: Colors.red),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
