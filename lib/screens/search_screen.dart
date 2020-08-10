import 'package:flutter/material.dart';
import 'package:lumini_chat/widgets/AZWidgets.dart';
import 'package:lumini_chat/widgets/main_appbar.dart';

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
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
          padding: EdgeInsets.only(right: 0.0, left: 20.0, top: 10.0),
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
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    SizedBox(
                      height: 10.0,
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
                                decoration: azTextFieldInputDecoration(
                                  hintText: 'Search by username',
                                  buildContext: context,
                                  underlineColor: Colors.grey,
                                  disableBorder: true,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: screenWidth * 0.04,
                            ),
                            Material(
                              type: MaterialType.circle,
                              color: Theme.of(context).primaryColor,
                              child: IconButton(
                                icon: Icon(
                                  Icons.search,
                                  color: Theme.of(context).accentColor,
                                  size: 40,
                                ),
                                onPressed: () {},
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
