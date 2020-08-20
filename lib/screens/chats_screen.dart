import 'package:flutter/material.dart';
import 'package:lumini_chat/helper/constants.dart';
import 'package:lumini_chat/helper/helper_methods.dart';
import 'package:lumini_chat/screens/conversation_screen.dart';
import 'package:lumini_chat/screens/search_screen.dart';
import 'package:lumini_chat/services/auth.dart';
import 'package:lumini_chat/services/database.dart';
import 'package:lumini_chat/widgets/AZWidgets.dart';
import 'package:lumini_chat/widgets/main_appbar.dart';
import 'package:lumini_chat/widgets/main_appdrawer.dart';
import 'package:strings/strings.dart';

class ChatRoom extends StatefulWidget {
  @override
  _ChatRoomState createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {
  AuthMethods authMethods = new AuthMethods();
  DatabaseMethods databaseMethods = new DatabaseMethods();

  Widget chatRoomsList() {
    return StreamBuilder(
      stream: databaseMethods.getUserChats(Constants.currentUser),
      builder: (context, snapshot) {
        return snapshot.hasData
            ? ListView.builder(
                itemCount: snapshot.data.documents.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  String usersInvolved =
                      snapshot.data.documents[index].data()['chatRoomId'];
                  List<String> userSplitList = usersInvolved.split("_");
                  return ChatRoomsTile(
                    userName: userSplitList[0] == Constants.currentUser
                        ? userSplitList[1]
                        : userSplitList[0],
                    chatRoomId:
                        snapshot.data.documents[index].data()["chatRoomId"],
                  );
                },
              )
            : Container();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      drawer: MainDrawer(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.red,
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Search()));
        },
        child: Icon(
          Icons.search,
          size: 40,
          color: Theme.of(context).accentColor,
        ),
      ),
      appBar: mainAppBar(
        buildContext: context,
        logoutIconIncluded: true,
        title: 'Chats',
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30.0),
                  topRight: Radius.circular(30.0),
                ),
                color: Theme.of(context).accentColor,
              ),
              child: Column(
                children: <Widget>[
                  // FavortieContacts(),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.015),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            // topLeft: Radius.circular(30.0),
                            // topRight: Radius.circular(30.0),
                            ),
                        color: Colors.white,
                      ),
                      child: chatRoomsList(),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class ChatRoomsTile extends StatelessWidget {
  final String userName;
  final String chatRoomId;

  ChatRoomsTile({this.userName, @required this.chatRoomId});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Column(
      children: [
        Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            mainAxisSize: MainAxisSize.max,
            children: [
              Flexible(
                fit: FlexFit.loose,
                flex: 3,
                child: Padding(
                  padding: EdgeInsets.only(left: screenWidth * 0.03),
                  child: Container(
                    height: screenWidth * 0.12,
                    width: screenWidth * 0.12,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Theme.of(context).accentColor,
                      borderRadius: BorderRadius.circular(screenWidth * 0.12),
                    ),
                    child: Text(
                      capitalize(userName.substring(0, 1)),
                      style: azSimpleTextStyle(
                        buildContext: context,
                        color: Colors.red,
                        fontSize: 20.0,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ),
              Flexible(
                fit: FlexFit.tight,
                flex: 8,
                child: Container(
                  padding: EdgeInsets.symmetric(
                      vertical: screenHeight * 0.01,
                      horizontal: screenWidth * 0.02),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Container(
                    child: Text(
                      capitalize(userName),
                      style: azSimpleTextStyle(
                        buildContext: context,
                        color: Colors.blueGrey,
                        fontSize: 18.0,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ),
              Flexible(
                fit: FlexFit.tight,
                flex: 4,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.01),
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                        side:
                            BorderSide(color: Theme.of(context).primaryColor)),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ConversationScreen(
                                    otherUserInChat: userName,
                                    chatRoomId: chatRoomId,
                                  )));
                    },
                    color: Theme.of(context).primaryColor,
                    child: FittedBox(
                      fit: BoxFit.fitWidth,
                      child: Text(
                        "Message".toUpperCase(),
                        style: azSimpleTextStyle(
                          buildContext: context,
                          color: Theme.of(context).accentColor,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Divider(),
      ],
    );
  }
}
