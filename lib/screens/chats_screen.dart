import 'package:flutter/material.dart';
import 'package:lumini_chat/widgets/main_appbar.dart';

class ChatRoom extends StatefulWidget {
  @override
  _ChatRoomState createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: mainAppBar(context),
      backgroundColor: Theme.of(context).primaryColor,
    );
  }
}
