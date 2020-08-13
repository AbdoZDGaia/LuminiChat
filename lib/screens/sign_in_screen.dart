import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lumini_chat/helper/helper_methods.dart';
import 'package:lumini_chat/screens/chats_screen.dart';
import 'package:lumini_chat/services/auth.dart';
import 'package:lumini_chat/services/database.dart';
import 'package:lumini_chat/widgets/AZWidgets.dart';
import 'package:lumini_chat/widgets/main_appbar.dart';

class SignIn extends StatefulWidget {
  final Function toggle;
  SignIn({this.toggle});
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  bool isLoading = false;
  AuthMethods authMethods = new AuthMethods();
  DatabaseMethods databaseMethods = new DatabaseMethods();

  TextEditingController emailTextEditingController =
      new TextEditingController();
  TextEditingController passwordTextEditingController =
      new TextEditingController();
  final formKey = GlobalKey<FormState>();

  void signMeInWithEmailAndPass() {
    String passHash = passwordTextEditingController.text;
    String email = emailTextEditingController.text;
    QuerySnapshot userSnapshot;

    if (formKey.currentState.validate()) {
      setState(() {
        isLoading = true;
      });

      authMethods.signInWithEmailAndPassword(email, passHash).then((val) {
        if (val != null) {
          databaseMethods.getUserByUserEmail(email).then((val) {
            userSnapshot = val;
            HelperFunctions.setLoggedInUserNameSharePreferences(
                userSnapshot.documents[0].data["username"]);
          });
          HelperFunctions.setLoggedInUserEmailSharePreferences(email);
          HelperFunctions.setIsUserLoggedInSharedPreferences(true);
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => ChatRoom()));
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: () {
        return FocusScope.of(context).unfocus();
      },
      child: isLoading
          ? Container(
              color: Theme.of(context).primaryColor,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            )
          : Scaffold(
              appBar: mainAppBar(buildContext: context),
              backgroundColor: Theme.of(context).primaryColor,
              body: Padding(
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
                          Form(
                            key: formKey,
                            child: Column(
                              children: [
                                TextFormField(
                                  validator: (val) {
                                    return RegExp(
                                                r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$")
                                            .hasMatch(val)
                                        ? null
                                        : 'Please enter a valid Email';
                                  },
                                  controller: emailTextEditingController,
                                  style: azSimpleTextStyle(
                                      buildContext: context, italic: true),
                                  decoration: azTextFieldInputDecoration(
                                    underlineColor: Colors.grey,
                                    buildContext: context,
                                    hintText: 'email',
                                  ),
                                ),
                                TextFormField(
                                  obscureText: true,
                                  validator: (val) {
                                    return (val.length < 6)
                                        ? "Password must at least be 6 digits/letters"
                                        : null;
                                  },
                                  controller: passwordTextEditingController,
                                  style: azSimpleTextStyle(
                                      buildContext: context, italic: true),
                                  decoration: azTextFieldInputDecoration(
                                    underlineColor: Colors.grey,
                                    buildContext: context,
                                    hintText: 'password',
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // SizedBox(
                          //   height: screenHeight * 0.35,
                          // ),
                          Container(
                            padding: EdgeInsets.only(
                                top: 15.0, bottom: 15.0, right: 15),
                            alignment: Alignment.centerRight,
                            child: Text(
                              'Forgot Password?',
                              style: azSimpleTextStyle(
                                buildContext: context,
                                italic: false,
                                color: Colors.blueGrey,
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              signMeInWithEmailAndPass();
                            },
                            child: Container(
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
                                  buildContext: context,
                                  fontSize: 18,
                                  color: Theme.of(context).accentColor,
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
                              'Sign in with Google',
                              style: azSimpleTextStyle(
                                buildContext: context,
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
                                  buildContext: context,
                                  fontSize: screenWidth * 0.04,
                                  color: Colors.blueGrey,
                                ),
                              ),
                              SizedBox(
                                width: 6,
                              ),
                              GestureDetector(
                                onTap: () {
                                  widget.toggle();
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(vertical: 8.0),
                                  child: Text(
                                    'Sign up now',
                                    style: azSimpleTextStyle(
                                      buildContext: context,
                                      fontSize: screenWidth * 0.045,
                                      color: Colors.blueGrey,
                                      underlined: true,
                                    ),
                                  ),
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
