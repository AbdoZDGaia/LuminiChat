import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lumini_chat/helper/constants.dart';
import 'package:lumini_chat/helper/helper_methods.dart';
import 'package:lumini_chat/services/database.dart';
import 'package:lumini_chat/widgets/main_appbar.dart';

class ConversationScreen extends StatefulWidget {
  final String chatRoomId;
  final String otherUserInChat;

  ConversationScreen({this.chatRoomId, @required this.otherUserInChat});
  @override
  _ConversationScreenState createState() => _ConversationScreenState();
}

class _ConversationScreenState extends State<ConversationScreen> {
  DatabaseMethods databaseMethods = new DatabaseMethods();
  TextEditingController messageBodyTextController = new TextEditingController();
  ScrollController _scrollController = new ScrollController();

  sendMessages() {
    if (messageBodyTextController.text.isNotEmpty) {
      Map<String, dynamic> messageMap = {
        "Message": messageBodyTextController.text,
        "SentBy": Constants.currentUser,
        "TimeSent": setTimeNow(),
        "Time": DateTime.now().millisecondsSinceEpoch,
        "Liked": false,
      };
      databaseMethods.addConversationMessageByRoomId(
          widget.chatRoomId, messageMap);
      messageBodyTextController.text = '';
    }
  }

  setTimeNow() {
    DateTime now = DateTime.now();
    String formattedTime = DateFormat.jm().format(now);
    return formattedTime;
  }

  getReadableTimeAmPmFromTimeStamp(int timeStamp) {
    var date = new DateTime.fromMillisecondsSinceEpoch(timeStamp * 1000);
    String formattedTime = DateFormat.jm().format(date);
    return formattedTime;
  }

  Widget chatMessagesList() {
    return StreamBuilder(
      stream:
          databaseMethods.getConversationMessagesByRoomId(widget.chatRoomId),
      builder: (context,snapshot) {
        if (snapshot.data == null)
          return Center(
            child: CircularProgressIndicator(),
          );
        else
          return Container(
            child: ListView.builder(
              reverse: true,
              shrinkWrap: true,
              controller: _scrollController,
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.01),
              itemCount: snapshot.data.documents.length,
              itemBuilder: (BuildContext context, int index) {
                final message = snapshot.data.documents[index].data()["Message"];
                final liked = snapshot.data.documents[index].data()["Liked"];
                final isMe = snapshot.data.documents[index].data()["SentBy"] ==
                    Constants.currentUser;
                final time = snapshot.data.documents[index].data()["TimeSent"];
                return MessageTile(
                  isMe: isMe,
                  liked: liked,
                  message: message,
                  time: time,
                );
              },
            ),
          );
      },
    );
  }

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

  _buildMessageComposer() {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: screenWidth * 0.01, vertical: screenHeight * 0.01),
      height: screenHeight * 0.11,
      decoration: BoxDecoration(
        color: Colors.white,
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
                  horizontal: screenWidth * 0.04),
              decoration: BoxDecoration(
                border: Border.all(
                    style: BorderStyle.solid,
                    width: 2.0,
                    color: Theme.of(context).primaryColor),
                borderRadius: BorderRadius.circular(30),
              ),
              height: screenHeight * 0.06,
              child: TextField(
                controller: messageBodyTextController,
                onTap: () {
                  _scrollController.animateTo(
                    0.0,
                    curve: Curves.easeOut,
                    duration: const Duration(milliseconds: 300),
                  );
                },
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
            onPressed: () {
              sendMessages();
            },
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
          centerTitle: true,
          title: widget.otherUserInChat),
      body: GestureDetector(
        onTap: () {
          return FocusScope.of(context).unfocus();
        },
        child: Column(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
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
                  child: chatMessagesList(),
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

class MessageTile extends StatelessWidget {
  final String message;
  final bool liked;
  final String time;
  final bool isMe;

  MessageTile(
      {@required this.isMe,
      @required this.liked,
      @required this.message,
      @required this.time});

  _buildMessage(
      {String messageBody,
      bool isMe,
      bool isLiked,
      String timeSent,
      @required BuildContext context}) {
    final Container msg = Container(
      width: MediaQuery.of(context).size.width * 0.75,
      margin: isMe
          ? EdgeInsets.only(
              top: 8.0,
              bottom: 8.0,
              left: 80.0,
            )
          : EdgeInsets.only(
              top: 8.0,
              bottom: 8.0,
            ),
      padding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 15.0),
      decoration: BoxDecoration(
        color: isMe ? Theme.of(context).accentColor : Color(0xffffefee),
        borderRadius: isMe
            ? BorderRadius.only(
                topLeft: Radius.circular(15),
                bottomLeft: Radius.circular(15),
              )
            : BorderRadius.only(
                topRight: Radius.circular(15),
                bottomRight: Radius.circular(15),
              ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(timeSent),
          SizedBox(height: 5.0),
          Text(messageBody),
        ],
      ),
    );

    if (isMe) return msg;
    return Row(
      children: [
        msg,
        IconButton(
          icon: Icon(
            isLiked ? Icons.favorite : Icons.favorite_border,
            size: 30.0,
            color: isLiked ? Theme.of(context).primaryColor : Colors.blueGrey,
          ),
          onPressed: () {},
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildMessage(
        isLiked: liked,
        context: context,
        isMe: isMe,
        messageBody: message,
        timeSent: time);
  }
}
