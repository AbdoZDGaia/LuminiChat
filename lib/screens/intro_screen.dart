import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  final int _numberOfPages = 3;
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

  //page indicator bar (bottom of the screen)
  List<Widget> _buildPageIndicator({BuildContext buildContext}) {
    List<Widget> list = [];
    for (int i = 0; i < _numberOfPages; i++) {
      list.add(i == _currentPage
          ? _indicator(buildContext, true)
          : _indicator(buildContext, false));
    }
    return list;
  }

  //if true returns a wider and a bit brighter border with basically the same everything else
  Widget _indicator(BuildContext context, bool isActive) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return AnimatedContainer(
      duration: Duration(milliseconds: 150),
      margin: EdgeInsets.symmetric(horizontal: 8.0),
      height: screenHeight * 0.01,
      width: isActive ? screenWidth * 0.08 : screenWidth * 0.04,
      decoration: BoxDecoration(
          color: isActive ? Colors.white : Theme.of(context).accentColor,
          borderRadius: BorderRadius.all(Radius.circular(12))),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xfff24b3f),
                Colors.red,
              ],
            ),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: screenHeight * 0.005),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                SizedBox(height: screenHeight * 0.05),
                Container(
                  alignment: Alignment.centerRight,
                  child: _currentPage == _numberOfPages - 1
                      ? Text('')
                      : RaisedButton(
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
                Container(
                  height: screenHeight * 0.78,
                  child: PageView(
                    physics: ClampingScrollPhysics(),
                    controller: _pageController,
                    onPageChanged: (int page) {
                      setState(() {
                        _currentPage = page;
                      });
                    },
                    children: <Widget>[
                      FirstLandingScreen(),
                      SecondLandingScreen(),
                      ThirdLandingScreen(),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: _buildPageIndicator(buildContext: context),
                ),
                _currentPage != _numberOfPages - 1
                    ? Expanded(
                        child: Align(
                          alignment: FractionalOffset.bottomRight,
                          child: FlatButton(
                            onPressed: () {
                              _pageController.nextPage(
                                duration: Duration(milliseconds: 600),
                                curve: Curves.ease,
                              );
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Text(
                                  'Next',
                                  style: azSimpleTextStyle(
                                      buildContext: context,
                                      color: Theme.of(context).accentColor,
                                      fontSize: screenHeight * 0.035),
                                ),
                                Icon(
                                  Icons.keyboard_arrow_right,
                                  color: Theme.of(context).accentColor,
                                  size: screenHeight * 0.06,
                                )
                              ],
                            ),
                          ),
                        ),
                      )
                    : Text(''),
              ],
            ),
          ),
        ),
      ),
      bottomSheet: _currentPage == _numberOfPages - 1
          ? Container(
              color: Colors.red,
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0xfffff0bc),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                height: screenHeight * 0.1,
                width: double.infinity,
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) {
                      return Authenticate();
                    }));
                  },
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.only(bottom: screenHeight * 0.01),
                      child: Text(
                        'Get Started',
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: screenHeight * 0.035,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            )
          : Text(''),
    );
  }
}
