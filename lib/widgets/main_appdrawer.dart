import 'package:flutter/material.dart';
import 'package:lumini_chat/helper/constants.dart';
import 'package:lumini_chat/helper/helper_methods.dart';
import 'package:lumini_chat/widgets/AZWidgets.dart';

class MainDrawer extends StatefulWidget {
  @override
  _MainDrawerState createState() => _MainDrawerState();
}

class _MainDrawerState extends State<MainDrawer> {
  @override
  void initState() {
    getUserInfo();
    super.initState();
  }

  getUserInfo() async {
    String currentUser =
        await HelperFunctions.getLoggedInUserNameSharePreferences();
    String currentUserEmail =
        await HelperFunctions.getLoggedInUserEmailSharePreferences();
    setState(() {
      Constants.currentUser = currentUser;
      Constants.currentUserEmail = currentUserEmail;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Theme.of(context).accentColor,
        child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountEmail: Text(
                Constants.currentUserEmail != ''
                    ? Constants.currentUserEmail
                    : 'abdelrahmanseliem5@gmail.com',
                style: azSimpleTextStyle(buildContext: context),
              ),
              accountName: Text(
                Constants.currentUser != ''
                    ? Constants.currentUser
                    : 'Abdelrahman Seliem',
                style: azSimpleTextStyle(buildContext: context),
              ),
              currentAccountPicture: Image.asset(
                'assets/images/logo1.png',
                fit: BoxFit.fill,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
              ),
            ),
            // MenuItems(),
          ],
        ),
      ),
    );
  }
}
