import 'package:flutter/material.dart';
import 'package:lumini_chat/widgets/AZWidgets.dart';
import 'package:lumini_chat/widgets/main_appbar.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: mainAppBar(context),
      backgroundColor: Theme.of(context).primaryColor,
      body: GestureDetector(
        onTap: () {
          return FocusScope.of(context).unfocus();
        },
        child: Padding(
          padding: EdgeInsets.only(right: 20.0, left: 20.0, top: 10.0),
          child: Container(
            alignment: Alignment.bottomCenter,
            child: Container(
              alignment: Alignment.topLeft,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  width: 10,
                  color: Theme.of(context).accentColor,
                ),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30)),
              ),
              padding: EdgeInsets.symmetric(horizontal: 24.0),
              child: SingleChildScrollView(
                child: Column(
                  // mainAxisSize: MainAxisSize.min,
                  // mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SizedBox(
                      height: 8.0,
                    ),
                    TextField(
                      style: azSimpleTextStyle(italic: true),
                      decoration: azTextFieldInputDecoration(
                        underlineColor: Colors.grey,
                        buildContext: context,
                        hintText: 'email',
                      ),
                    ),
                    TextField(
                      style: azSimpleTextStyle(italic: true),
                      decoration: azTextFieldInputDecoration(
                        underlineColor: Colors.grey,
                        buildContext: context,
                        hintText: 'password',
                      ),
                    ),
                    // SizedBox(
                    //   height: screenHeight * 0.35,
                    // ),
                    Container(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Text(
                          'Forgot Password?',
                          style: azSimpleTextStyle(
                            italic: false,
                            color: Colors.blueGrey,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 8.0,
                    ),
                    Container(
                      width: screenWidth * 0.8,
                      padding: EdgeInsets.symmetric(vertical: 15),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        gradient: LinearGradient(
                          colors: [
                            Color(0xfff24b3f),
                            Colors.red,
                          ],
                        ),
                      ),
                      alignment: Alignment.topCenter,
                      child: Text(
                        'Sign in',
                        style: azSimpleTextStyle(
                          fontSize: 18,
                          color: Theme.of(context).accentColor,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 8.0,
                    ),
                    Container(
                      width: screenWidth * 0.8,
                      padding: EdgeInsets.symmetric(vertical: 15),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        gradient: LinearGradient(
                          colors: [
                            Color(0xfff24b3f),
                            Colors.red,
                          ],
                        ),
                      ),
                      alignment: Alignment.topCenter,
                      child: Text(
                        'Sign in with Google',
                        style: azSimpleTextStyle(
                          fontSize: 18,
                          color: Theme.of(context).accentColor,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 8.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Haven\'t signed up yet?',
                          style: azSimpleTextStyle(
                            fontSize: 15,
                            color: Colors.blueGrey,
                          ),
                        ),
                        SizedBox(
                          width: 6,
                        ),
                        Text(
                          'Sign up now',
                          style: azSimpleTextStyle(
                            fontSize: 17,
                            color: Colors.blueGrey,
                            underlined: true,
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: screenHeight * 0.05,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
