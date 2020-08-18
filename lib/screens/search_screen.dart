import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lumini_chat/helper/constants.dart';
import 'package:lumini_chat/screens/conversation_screen.dart';
import 'package:lumini_chat/services/database.dart';
import 'package:lumini_chat/widgets/AZWidgets.dart';
import 'package:strings/strings.dart';

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  DatabaseMethods databaseMethods = new DatabaseMethods();
  TextEditingController searchByUserEmailTextEditingController =
      new TextEditingController();
  QuerySnapshot userSnapshot;
  QuerySnapshot chatRoomSnapshot;

  initiateSearch() {
    databaseMethods
        .getUserByUserEmail(searchByUserEmailTextEditingController.text)
        .then((val) {
      setState(() {
        userSnapshot = val;
      });
    });
  }

  Widget userListView() {
    String emailSearch = searchByUserEmailTextEditingController.text;

    if (userSnapshot == null) {
      return Container();
    } else if (userSnapshot.docs.length == 0) {
      return emailSearch.isEmpty
          ? Container()
          : Container(
              child: Container(
                alignment: Alignment.center,
                child: FittedBox(
                  fit: BoxFit.fitWidth,
                  child: Text(
                    'Please provide a registered E-mail.',
                    style: azSimpleTextStyle(
                      buildContext: context,
                    ),
                  ),
                ),
              ),
            );
    } else {
      return userSnapshot.docs[0].data()["username"].toString() !=
              Constants.currentUser
          ? ListView.builder(
              shrinkWrap: true,
              itemCount: userSnapshot.docs.length,
              itemBuilder: (BuildContext context, int index) {
                String username =
                    userSnapshot.docs[index].data()["username"].toString();
                String email =
                    userSnapshot.docs[index].data()["email"].toString();
                return searchTile(
                  buildContext: context,
                  userEmailLabel: email,
                  usernameLabel: username,
                );
              },
            )
          : Center(
              child: Container(
                child: Text(
                  'This email belongs to you.',
                  style: azSimpleTextStyle(
                    buildContext: context,
                  ),
                ),
              ),
            );
    }
  }

  _invertRoomId(String roomId) {
    List<String> userSplitList = roomId.split("_");
    return '${userSplitList[1]}_${userSplitList[0]}';
  }

  createChatRoomAndStartConversation({String userName}) {
    String chatRoomId = getChatRoomId(userName, Constants.currentUser);
    List<String> users = [userName, Constants.currentUser];
    String invertedChatRoomId = _invertRoomId(chatRoomId);
    Map<String, dynamic> chatroomMap = {
      "users": users,
      "chatRoomId": chatRoomId
    };

    databaseMethods.isRoomDuplicated(invertedChatRoomId).then((val) {
      setState(() {
        chatRoomSnapshot = val;
        if (chatRoomSnapshot.docs.length == 0) {
          if (userName != Constants.currentUser) {
            DatabaseMethods().createChatRoom(chatRoomId, chatroomMap);
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ConversationScreen(
                          otherUserInChat: userName,
                          chatRoomId: chatRoomId,
                        )));
          } else {
            print("Nope!!!");
          }
        } else {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ConversationScreen(
                        otherUserInChat: userName,
                        chatRoomId: invertedChatRoomId,
                      )));
        }
      });
    });
  }

  Widget searchTile(
      {BuildContext buildContext,
      String usernameLabel,
      String userEmailLabel}) {
    final double screenHeight = MediaQuery.of(buildContext).size.height;
    final double screenWidth = MediaQuery.of(buildContext).size.width;

    return Padding(
      padding: EdgeInsets.only(top: screenHeight * 0.03),
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          mainAxisSize: MainAxisSize.max,
          children: [
            Flexible(
              fit: FlexFit.tight,
              flex: 4,
              child: Padding(
                padding: EdgeInsets.only(right: screenWidth*0.03),
                child: Container(
                  padding: EdgeInsets.symmetric(vertical:screenHeight*0.03,horizontal: screenWidth*0.03),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        child: Text(
                          capitalize(usernameLabel),
                          style: azSimpleTextStyle(
                            buildContext: context,
                            color: Colors.blueGrey,
                            fontSize: 20.0,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Container(
                        child: Text(
                          userEmailLabel,
                          style: azSimpleTextStyle(
                            buildContext: context,
                            color: Colors.blueGrey,
                            fontSize: 16,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Flexible(
              fit: FlexFit.tight,
              flex: 2,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.02),
                child: RaisedButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                      side: BorderSide(color: Theme.of(context).primaryColor)),
                  onPressed: () {
                    createChatRoomAndStartConversation(
                      userName: usernameLabel,
                    );
                  },
                  color: Theme.of(context).primaryColor,
                  child: FittedBox(
                    fit: BoxFit.fitWidth,
                    child: Text("Message".toUpperCase(),
                        style: azSimpleTextStyle(
                          buildContext: context,
                          color: Theme.of(context).accentColor,
                        )),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () {
        return FocusScope.of(context).unfocus();
      },
      child: Scaffold(
          appBar: AppBar(
            elevation: 0.0,
            leading: IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  size: 30,
                  color: Theme.of(context).accentColor,
                ),
                onPressed: () {
                  Navigator.pop(context);
                }),
            centerTitle: true,
            title: Padding(
              padding: EdgeInsets.only(
                top: screenHeight * 0.01,
                bottom: screenHeight * 0.02,
                left: screenWidth * 0.01,
              ),
              child: FittedBox(
                fit: BoxFit.fill,
                child: Text(
                  'Search',
                  style: TextStyle(
                    color: Theme.of(context).accentColor,
                    fontSize: 28.0,
                    letterSpacing: 5,
                    fontFamily: 'Lobster',
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          backgroundColor: Theme.of(context).primaryColor,
          body: Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(
                    horizontal: screenWidth * 0.04,
                    vertical: screenHeight * 0.01),
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: searchByUserEmailTextEditingController,
                        decoration: azTextFieldInputDecoration(
                          hintText: 'Search by email',
                          buildContext: context,
                          underlineColor: Colors.grey,
                          disableBorder: true,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: screenWidth * 0.02,
                    ),
                    ClipOval(
                      child: Material(
                        color: Theme.of(context).primaryColor, // button color
                        child: InkWell(
                          splashColor:
                              Theme.of(context).accentColor, // inkwell color
                          child: SizedBox(
                            width: screenWidth * 0.12,
                            height: screenWidth * 0.12,
                            child: Icon(
                              Icons.search,
                              color: Theme.of(context).accentColor,
                              size: 40,
                            ),
                          ),
                          onTap: () {
                            initiateSearch();
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).accentColor,
                  ),
                  child: userListView(),
                ),
              ),
            ],
          )

          // Container(
          //   decoration: BoxDecoration(
          //     color: Theme.of(context).accentColor,
          //     borderRadius: BorderRadius.only(
          //       topLeft: Radius.circular(30),
          //       topRight: Radius.circular(30),
          //     ),
          //   ),
          //   child: SingleChildScrollView(
          //     child: Column(
          //       mainAxisAlignment: MainAxisAlignment.start,
          //       mainAxisSize: MainAxisSize.max,
          //       children: [
          //         Padding(
          //           padding: EdgeInsets.only(
          //             top: 0.0,
          //           ),
          //           child: Container(
          //             decoration: BoxDecoration(
          //               color: Colors.white,
          //               borderRadius: BorderRadius.only(
          //                 topLeft: Radius.circular(30),
          //                 topRight: Radius.circular(30),
          //               ),
          //             ),
          //             padding: EdgeInsets.only(
          //               top: screenHeight * 0.011,
          //               bottom: screenHeight * 0.011,
          //               right: screenWidth * 0.02,
          //               left: screenWidth * 0.04,
          //             ),
          //             height: screenHeight * 0.1,
          //             alignment: Alignment.topRight,
          //             child: azSearchBar(
          //               buildContext: context,
          //               searchByUserEmailTextEditingController:
          //                   searchByUserEmailTextEditingController,
          //               searchFunction: initiateSearch(),
          //             ),
          //           ),
          //         ),
          //         Container(
          //           decoration: BoxDecoration(
          //             color: Colors.blue,
          //             borderRadius: BorderRadius.only(
          //               topRight: Radius.circular(20),
          //               bottomRight: Radius.circular(20),
          //               topLeft: Radius.circular(20),
          //               bottomLeft: Radius.circular(20),
          //             ),
          //           ),
          //           padding: EdgeInsets.only(
          //             top: screenHeight * 0.011,
          //             bottom: 0.0,
          //             right: screenWidth * 0.02,
          //             left: screenWidth * 0.0,
          //           ),
          //           alignment: Alignment.center,
          //           child: userListView(),
          //         ),
          //       ],
          //     ),
          //   ),
          // ),
          ),
    );
  }
}

getChatRoomId(String a, String b) {
  if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
    return "$b\_$a";
  } else {
    return "$a\_$b";
  }
}
