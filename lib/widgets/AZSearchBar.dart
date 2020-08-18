import 'package:flutter/material.dart';
import 'AZWidgets.dart';

Widget azSearchBar({
  @required BuildContext buildContext,
  @required TextEditingController searchByUserEmailTextEditingController,
  @required Function searchFunction(buildContext),
  String hintText = 'Search by email',
}) {
  final double screenWidth = MediaQuery.of(buildContext).size.width;
  return Row(
    children: [
      Expanded(
        child: TextField(
          controller: searchByUserEmailTextEditingController,
          decoration: azTextFieldInputDecoration(
            hintText: hintText,
            buildContext: buildContext,
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
          color: Theme.of(buildContext).primaryColor, // button color
          child: InkWell(
            splashColor: Theme.of(buildContext).accentColor, // inkwell color
            child: SizedBox(
              width: screenWidth * 0.12,
              height: screenWidth * 0.12,
              child: Icon(
                Icons.search,
                color: Theme.of(buildContext).accentColor,
                size: 40,
              ),
            ),
            onTap: () {
              searchFunction(buildContext);
            },
          ),
        ),
      ),
    ],
  );
}
