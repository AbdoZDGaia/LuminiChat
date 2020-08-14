import 'package:flutter/material.dart';
import 'package:lumini_chat/widgets/main_appbar.dart';

class ConversationScreen extends StatefulWidget {
  final String chatRoomId;

  ConversationScreen({this.chatRoomId});
  @override
  _ConversationScreenState createState() => _ConversationScreenState();
}

class _ConversationScreenState extends State<ConversationScreen> {
  // _buildMessage(Message message, bool isMe) {
  //   final Container msg = Container(
  //     width: MediaQuery.of(context).size.width * 0.75,
  //     margin: isMe
  //         ? EdgeInsets.only(
  //             top: 8.0,
  //             bottom: 8.0,
  //             left: 80.0,
  //           )
  //         : EdgeInsets.only(
  //             top: 8.0,
  //             bottom: 8.0,
  //           ),
  //     padding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 15.0),
  //     decoration: BoxDecoration(
  //       color: isMe ? Theme.of(context).accentColor : Color(0xffffefee),
  //       borderRadius: isMe
  //           ? BorderRadius.only(
  //               topLeft: Radius.circular(15),
  //               bottomLeft: Radius.circular(15),
  //             )
  //           : BorderRadius.only(
  //               topRight: Radius.circular(15),
  //               bottomRight: Radius.circular(15),
  //             ),
  //     ),
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         Text(message.time),
  //         SizedBox(height: 5.0),
  //         Text(message.text),
  //       ],
  //     ),
  //   );

  //   if (isMe) return msg;
  //   return Row(
  //     children: [
  //       msg,
  //       IconButton(
  //         icon: Icon(
  //           message.isLiked ? Icons.favorite : Icons.favorite_border,
  //           size: 30.0,
  //           color: message.isLiked
  //               ? Theme.of(context).primaryColor
  //               : Colors.blueGrey,
  //         ),
  //         onPressed: () {},
  //       ),
  //     ],
  //   );
  // }

  _buildMessageComposer() {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.0),
      height: screenHeight * 0.11,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(width: 3.0, color: Theme.of(context).primaryColor),
        ),
      ),
      child: Row(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
                vertical: screenHeight * 0.01, horizontal: screenWidth * 0.01),
            child: IconButton(
              icon: Icon(
                Icons.photo,
                color: Theme.of(context).primaryColor,
              ),
              onPressed: () {},
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(
                  vertical: screenHeight * 0.01,
                  horizontal: screenWidth * 0.02),
              decoration: BoxDecoration(
                border:
                    Border.all(style: BorderStyle.solid, color: Colors.grey),
                borderRadius: BorderRadius.circular(30),
                color: Theme.of(context).accentColor,
              ),
              height: screenHeight * 0.05,
              child: TextField(
                onChanged: (value) {},
                textCapitalization: TextCapitalization.sentences,
                decoration: InputDecoration.collapsed(
                  hintText: 'Send a message...',
                ),
              ),
            ),
          ),
          IconButton(
            icon: Icon(
              Icons.send,
              color: Theme.of(context).primaryColor,
            ),
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: mainAppBar(
        buildContext: context,
      ),
      body: GestureDetector(
        onTap: () {
          return FocusScope.of(context).unfocus();
        },
        child: Column(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).accentColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30.0),
                    topRight: Radius.circular(30.0),
                  ),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(30.0),
                    topLeft: Radius.circular(30.0),
                  ),
                  child: ListView.builder(
                    reverse: true,
                    padding: EdgeInsets.only(top: 15.0),
                    itemCount: 10,
                    itemBuilder: (BuildContext context, int index) {
                      return Text('hi');
                      // final List<Message> messagesList = messages
                      //     .where((i) =>
                      //         i.sender.id == currentUser.id ||
                      //         i.sender.id == widget.user.id)
                      //     .defaultIfEmpty(Message());
                      // final message = chatroom;
                      // final bool isMe = message.sender.id == currentUser.id;
                      // return _buildMessage(message, isMe);
                    },
                  ),
                ),
              ),
            ),
            _buildMessageComposer(),
          ],
        ),
      ),
    );
  }
}
