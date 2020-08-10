import 'package:flutter/material.dart';
import 'package:lumini_chat/screens/search_screen.dart';
import 'package:lumini_chat/services/auth.dart';
import 'package:lumini_chat/widgets/main_appbar.dart';

class ChatRoom extends StatefulWidget {
  @override
  _ChatRoomState createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {
  AuthMethods authMethods = new AuthMethods();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: mainAppBar(
        buildContext: context,
        logoutIconIncluded: true,
      ),
      backgroundColor: Theme.of(context).primaryColor,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Search()));
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
