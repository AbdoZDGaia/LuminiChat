import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lumini_chat/screens/conversation_screen.dart';
import 'package:lumini_chat/services/database.dart';
import 'package:lumini_chat/widgets/AZWidgets.dart';
import 'package:strings/strings.dart';

class Search extends StatefulWidget {
  final String currentUser;

  Search({@required this.currentUser});
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  DatabaseMethods databaseMethods = new DatabaseMethods();
  TextEditingController searchByUserEmailTextEditingController =
      new TextEditingController();
  QuerySnapshot userSnapshot;

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
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    String emailSearch = searchByUserEmailTextEditingController.text;

    if (userSnapshot == null) {
      return Container();
    } else if (userSnapshot.documents.length == 0) {
      return emailSearch.isEmpty
          ? Container()
          : Padding(
              padding: EdgeInsets.symmetric(
                vertical: screenHeight * 0.1,
                horizontal: screenWidth * 0.1,
              ),
              child: Container(
                child: Container(
                  width: screenWidth * 0.7,
                  alignment: Alignment.topCenter,
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
              ));
    } else {
      return userSnapshot.documents[0].data["username"].toString() !=
              widget.currentUser
          ? ListView.builder(
              shrinkWrap: true,
              itemCount: userSnapshot.documents.length,
              itemBuilder: (BuildContext context, int index) {
                String username =
                    userSnapshot.documents[index].data["username"].toString();
                String email = userSnapshot.documents[index].data["email"];
                return searchTile(
                  buildContext: context,
                  userEmailLabel: email,
                  usernameLabel: username,
                );
              },
            )
          : Padding(
              padding: EdgeInsets.only(
                top: screenHeight * 0.1,
                bottom: screenHeight * 0.1,
                left: screenWidth * 0.1,
              ),
              child: Container(
                alignment: Alignment.topCenter,
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

  createChatRoomAndStartConversation({String userName}) {
    String chatRoomId = getChatRoomId(userName, widget.currentUser);
    List<String> users = [userName, widget.currentUser];
    Map<String, dynamic> chatroomMap = {
      "users": users,
      "chatRoomId": chatRoomId
    };

    if (userName != widget.currentUser) {
      DatabaseMethods().createChatRoom(chatRoomId, chatroomMap);
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ConversationScreen(
                    otherUserInChat: userName,
                    currentUser: widget.currentUser,
                    chatRoomId: chatRoomId,
                  )));
    } else {
      print("Nope!!!");
    }
  }

  Widget searchTile(
      {BuildContext buildContext,
      String usernameLabel,
      String userEmailLabel}) {
    final double screenHeight = MediaQuery.of(buildContext).size.height;
    final double screenWidth = MediaQuery.of(buildContext).size.width;

    return Padding(
      padding: EdgeInsets.only(
        top: screenWidth * 0.02,
        bottom: screenWidth * 0.02,
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(30),
            bottomRight: Radius.circular(30),
          ),
        ),
        padding: EdgeInsets.symmetric(
            vertical: screenHeight * 0.03, horizontal: screenWidth * 0.04),
        height: screenHeight * 0.135,
        alignment: Alignment.topRight,
        child: Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                width: screenWidth * 0.02,
              ),
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      width: screenWidth * 0.5,
                      child: Text(
                        capitalize(usernameLabel),
                        style: azSimpleTextStyle(
                          buildContext: context,
                          color: Colors.black,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Container(
                      width: screenWidth * 0.5,
                      child: Text(
                        userEmailLabel,
                        style: azSimpleTextStyle(
                          buildContext: context,
                          color: Colors.black,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: screenWidth * 0.03),
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
                  child: Text("Message".toUpperCase(),
                      style: azSimpleTextStyle(
                        buildContext: context,
                        color: Theme.of(context).accentColor,
                      )),
                ),
              ),
            ],
          ),
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
        body: Padding(
          padding: EdgeInsets.only(bottom: 0.0),
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(
                  right: 0.0,
                  left: screenWidth * 0.06,
                  top: screenHeight * 0.01),
              child: Container(
                alignment: Alignment.bottomCenter,
                child: Container(
                  alignment: Alignment.topLeft,
                  decoration: BoxDecoration(
                    color: Theme.of(context).accentColor,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      bottomLeft: Radius.circular(30),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      SizedBox(
                        height: screenHeight * 0.02,
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            top: screenHeight * 0.02,
                            right: 0.0,
                            left: screenHeight * 0.03),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20),
                                bottomLeft: Radius.circular(20),
                              )),
                          padding: EdgeInsets.only(
                            top: screenHeight * 0.011,
                            bottom: screenHeight * 0.011,
                            right: screenWidth * 0.02,
                            left: screenWidth * 0.04,
                          ),
                          height: screenHeight * 0.1,
                          alignment: Alignment.topRight,
                          child: Row(
                            children: [
                              Expanded(
                                child: TextField(
                                  controller:
                                      searchByUserEmailTextEditingController,
                                  decoration: azTextFieldInputDecoration(
                                    // hintText: 'Search by username',
                                    hintText: 'Search by email',
                                    buildContext: context,
                                    underlineColor: Colors.grey,
                                    disableBorder: true,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: screenWidth * 0.04,
                              ),
                              ClipOval(
                                child: Material(
                                  color: Theme.of(context)
                                      .primaryColor, // button color
                                  child: InkWell(
                                    splashColor: Theme.of(context)
                                        .accentColor, // inkwell color
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
                      ),
                      SizedBox(
                        height: screenHeight * 0.02,
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: screenHeight * 0.02),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(20),
                              bottomRight: Radius.circular(20),
                              topLeft: Radius.circular(20),
                              bottomLeft: Radius.circular(20),
                            ),
                          ),
                          padding: EdgeInsets.only(
                            top: screenHeight * 0.011,
                            bottom: 0.0,
                            right: screenWidth * 0.02,
                            left: screenWidth * 0.0,
                          ),
                          height: screenHeight * 0.65,
                          // alignment: Alignment.topRight,
                          child: userListView(),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
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
