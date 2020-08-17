import 'package:flutter/material.dart';
import 'package:lumini_chat/helper/constants.dart';
import 'package:lumini_chat/helper/helper_methods.dart';
import 'package:lumini_chat/screens/search_screen.dart';
import 'package:lumini_chat/services/auth.dart';
import 'package:lumini_chat/widgets/main_appbar.dart';
import 'package:lumini_chat/widgets/main_appdrawer.dart';

class ChatRoom extends StatefulWidget {
  @override
  _ChatRoomState createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {
  AuthMethods authMethods = new AuthMethods();

  @override
  void initState() {
    getUserInfo();
    super.initState();
  }

  getUserInfo() async {
    Constants.currentUser =
        await HelperFunctions.getLoggedInUserNameSharePreferences();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: mainAppBar(
        buildContext: context,
        logoutIconIncluded: true,
      ),
      drawer: MainDrawer(),
      backgroundColor: Theme.of(context).primaryColor,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => Search(
                        currentUser: Constants.currentUser,
                      )));
        },
        child: Icon(
          Icons.search,
          size: 40,
          color: Theme.of(context).primaryColor,
        ),
      ),
    );
  }
}
