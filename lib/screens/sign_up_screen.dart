import 'package:flutter/material.dart';
import 'package:lumini_chat/helper/helper_methods.dart';
import 'package:lumini_chat/screens/chats_screen.dart';
import 'package:lumini_chat/services/auth.dart';
import 'package:lumini_chat/services/database.dart';
import 'package:lumini_chat/widgets/AZWidgets.dart';
import 'package:lumini_chat/widgets/main_appbar.dart';

class SignUp extends StatefulWidget {
  final Function toggle;
  SignUp({this.toggle});
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool validUsername = true;
  bool validEmail = true;
  bool isLoading = false;
  AuthMethods authMethods = new AuthMethods();
  TextEditingController userNameTextEditingController =
      new TextEditingController();
  TextEditingController emailTextEditingController =
      new TextEditingController();
  TextEditingController passwordTextEditingController =
      new TextEditingController();
  final formKey = GlobalKey<FormState>();
  DatabaseMethods databaseMethods = new DatabaseMethods();

  signMeUp() async {
    String passHash = passwordTextEditingController.text;
    String email = emailTextEditingController.text;
    String username = userNameTextEditingController.text;
    List<String> userSplitList = username.split(" ");
    List<String> userIndexList = [];

    bool isUserValid = await databaseMethods.isUsernameUnique(username);
    bool isEmailValid = await databaseMethods.isEmailUnique(email);
    if (!isUserValid) {
      setState(() {
        validUsername = false;
      });
    }
    if (!isEmailValid) {
      setState(() {
        validEmail = false;
      });
    }
    if (isEmailValid && isUserValid) {
      for (int i = 0; i < userSplitList.length; i++) {
        for (int y = 1; y < userSplitList[i].length + 1; y++) {
          userIndexList.add(userSplitList[i].substring(0, y).toLowerCase());
        }
      }

      if (formKey.currentState.validate()) {
        setState(() {
          isLoading = true;
        });

        Map<String, dynamic> userMap = {
          "email": email.toLowerCase(),
          "passHash": passHash,
          "username": username,
          "searchIndex": userIndexList,
        };
        await authMethods
            .signUpWithEmailAndPassword(email, passHash)
            .then((result) {
          if (result != null) {
            databaseMethods.uploadUserInfo(userMap);

            HelperFunctions.setIsUserLoggedInSharedPreferences(true);
            HelperFunctions.setLoggedInUserNameSharePreferences(username);
            HelperFunctions.setLoggedInUserEmailSharePreferences(email);

            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => ChatRoom()));
          }
        });
      }
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
                                    return val.isEmpty || val.length < 2
                                        ? 'Please enter a valid username'
                                        : null;
                                  },
                                  onChanged: (val) {
                                    setState(() {
                                      validUsername = true;
                                    });
                                  },
                                  controller: userNameTextEditingController,
                                  style: azSimpleTextStyle(
                                      buildContext: context, italic: true),
                                  decoration: azTextFieldInputDecoration(
                                    underlineColor: Colors.grey,
                                    buildContext: context,
                                    hintText: 'username',
                                  ),
                                ),
                                validUsername
                                    ? SizedBox.shrink()
                                    : Padding(
                                        padding: EdgeInsets.only(
                                          top: screenHeight * 0.01,
                                        ),
                                        child: Container(
                                          padding: EdgeInsets.only(
                                              top: screenHeight * 0.003,
                                              left: screenWidth * 0.02),
                                          alignment: Alignment.topLeft,
                                          height: screenHeight * 0.04,
                                          child: Text(
                                            'Invalid username',
                                            style: azSimpleTextStyle(
                                                buildContext: context,
                                                color: Colors.red,
                                                fontSize: 14),
                                          ),
                                        ),
                                      ),
                                TextFormField(
                                  onChanged: (val) {
                                    setState(() {
                                      validEmail = true;
                                    });
                                  },
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
                                validEmail
                                    ? SizedBox.shrink()
                                    : Padding(
                                        padding: EdgeInsets.only(
                                          top: screenHeight * 0.01,
                                        ),
                                        child: Container(
                                          padding: EdgeInsets.only(
                                              top: screenHeight * 0.003,
                                              left: screenWidth * 0.02),
                                          alignment: Alignment.topLeft,
                                          height: screenHeight * 0.04,
                                          child: Text(
                                            'Email is already registered',
                                            style: azSimpleTextStyle(
                                                buildContext: context,
                                                color: Colors.red,
                                                fontSize: 14),
                                          ),
                                        ),
                                      ),
                                TextFormField(
                                  obscureText: true,
                                  validator: (val) {
                                    return (val.length >= 6)
                                        ? null
                                        : "Password must at least be 6 digits/letters";
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
                          SizedBox(
                            height: 20.0,
                          ),
                          GestureDetector(
                            onTap: () async {
                              signMeUp();
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
                                'Sign up',
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
                              'Sign up with Google',
                              style: azSimpleTextStyle(
                                buildContext: context,
                                fontSize: 18,
                                color: Theme.of(context).accentColor,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Already have an account?',
                                style: azSimpleTextStyle(
                                  buildContext: context,
                                  fontSize: screenWidth * 0.037,
                                  color: Colors.blueGrey,
                                ),
                              ),
                              SizedBox(
                                width: screenWidth * 0.01,
                              ),
                              GestureDetector(
                                onTap: () {
                                  widget.toggle();
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                    vertical: screenWidth * 0.02,
                                  ),
                                  child: Text(
                                    'Sign in now',
                                    style: azSimpleTextStyle(
                                      buildContext: context,
                                      fontSize: screenWidth * 0.04,
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
