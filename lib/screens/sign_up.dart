import 'package:flutter/material.dart';
import 'package:lumini_chat/screens/chats_screen.dart';
import 'package:lumini_chat/services/auth.dart';
import 'package:lumini_chat/widgets/AZWidgets.dart';
import 'package:lumini_chat/widgets/main_appbar.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool isLoading = false;
  AuthMethods authMethods = new AuthMethods();
  TextEditingController userNameTextEditingController =
      new TextEditingController();
  TextEditingController emailTextEditingController =
      new TextEditingController();
  TextEditingController passwordTextEditingController =
      new TextEditingController();
  final formKey = GlobalKey<FormState>();

  signMeUp() {
    if (formKey.currentState.validate()) {
      setState(() {
        isLoading = true;
      });
      authMethods
          .signUpWithEmailAndPassword(emailTextEditingController.text,
              passwordTextEditingController.text)
          .then((value) {
        print('{$value.uid}');

        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => ChatRoom()));
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
              appBar: mainAppBar(context),
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
                                  controller: userNameTextEditingController,
                                  style: azSimpleTextStyle(italic: true),
                                  decoration: azTextFieldInputDecoration(
                                    underlineColor: Colors.grey,
                                    buildContext: context,
                                    hintText: 'username',
                                  ),
                                ),
                                SizedBox(
                                  height: 8.0,
                                ),
                                TextFormField(
                                  validator: (val) {
                                    return RegExp(
                                                r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$")
                                            .hasMatch(val)
                                        ? null
                                        : 'Please enter a valid Email';
                                  },
                                  controller: emailTextEditingController,
                                  style: azSimpleTextStyle(italic: true),
                                  decoration: azTextFieldInputDecoration(
                                    underlineColor: Colors.grey,
                                    buildContext: context,
                                    hintText: 'email',
                                  ),
                                ),
                                TextFormField(
                                  obscureText: true,
                                  validator: (val) {
                                    return val.length >= 6
                                        ? null
                                        : "Password must at least be 6 digits/letters";
                                  },
                                  controller: passwordTextEditingController,
                                  style: azSimpleTextStyle(italic: true),
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
                            onTap: () {
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
                                  fontSize: 13,
                                  color: Colors.blueGrey,
                                ),
                              ),
                              SizedBox(
                                width: 6,
                              ),
                              Text(
                                'Sign in now',
                                style: azSimpleTextStyle(
                                  fontSize: 13,
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
