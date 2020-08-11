import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lumini_chat/services/database.dart';
import 'package:lumini_chat/widgets/AZWidgets.dart';

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  DatabaseMethods databaseMethods = new DatabaseMethods();
  TextEditingController searchByUsernameTextEditingController =
      new TextEditingController();
  QuerySnapshot userSnapshot;

  initiateSearch() {
    databaseMethods
        .getUserByUsername(searchByUsernameTextEditingController.text)
        .then((val) {
      setState(() {
        userSnapshot = val;
      });
    });
  }

  @override
  void initState() {
    initiateSearch();
    super.initState();
  }

  Widget userListView() {
    return userSnapshot != null
        ? ListView.builder(
            shrinkWrap: true,
            itemCount: userSnapshot.documents.length,
            itemBuilder: (BuildContext context, int index) {
              return SearchTile(
                userEmailLabel: userSnapshot.documents[index].data["email"],
                usernameLabel: userSnapshot.documents[index].data["username"],
              );
            },
          )
        : Container();
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
                                      searchByUsernameTextEditingController,
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
                                      height: screenHeight * 0.07,
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

class SearchTile extends StatelessWidget {
  final String usernameLabel;
  final String userEmailLabel;

  SearchTile({this.userEmailLabel, this.usernameLabel});

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

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
        padding: EdgeInsets.symmetric(vertical: screenHeight * 0.02),
        height: screenHeight * 0.135,
        alignment: Alignment.topRight,
        child: Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(width: screenWidth * 0.02),
              Container(
                alignment: Alignment.centerLeft,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.circular(30)),
                      width: screenWidth * 0.55,
                      padding: EdgeInsets.symmetric(
                          vertical: screenHeight * 0.005,
                          horizontal: screenWidth * 0.03),
                      child: Text(
                        usernameLabel,
                        style: azSimpleTextStyle(
                          buildContext: context,
                          color: Theme.of(context).accentColor,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.015),
                    Container(
                      decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.circular(30)),
                      width: screenWidth * 0.55,
                      padding: EdgeInsets.symmetric(
                          vertical: screenHeight * 0.005,
                          horizontal: screenWidth * 0.03),
                      child: Text(
                        userEmailLabel,
                        style: azSimpleTextStyle(
                          buildContext: context,
                          color: Theme.of(context).accentColor,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: screenWidth * 0.02),
                child: RaisedButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                      side: BorderSide(color: Theme.of(context).primaryColor)),
                  onPressed: () {},
                  color: Theme.of(context).primaryColor,
                  child: Text("Message".toUpperCase(),
                      style: azSimpleTextStyle(
                          buildContext: context, color: Theme.of(context).accentColor)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
