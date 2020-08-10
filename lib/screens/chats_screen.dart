import 'package:flutter/material.dart';
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
    );
  }
}
