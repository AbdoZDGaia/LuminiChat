import 'package:flutter/material.dart';

InputDecoration azTextFieldInputDecoration(
    {@required BuildContext buildContext,
    String hintText,
    Color underlineColor = Colors.white,
    bool disableBorder = false}) {
  if (disableBorder)
    return InputDecoration(
      border: InputBorder.none,
      hintText: hintText,
      hintStyle: TextStyle(color: Colors.grey),
    );
  else
    return InputDecoration(
      hintText: hintText,
      hintStyle: TextStyle(color: Colors.grey),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(
          color: Theme.of(buildContext).primaryColor,
        ),
      ),
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(
          color: underlineColor,
        ),
      ),
    );
}

TextStyle azSimpleTextStyle(
    {@required BuildContext buildContext,
    Color color = Colors.black,
    bool italic = false,
    double fontSize = 16,
    bool underlined = false}) {
  return TextStyle(
    color: color,
    fontWeight: FontWeight.bold,
    fontStyle: italic ? FontStyle.italic : FontStyle.normal,
    fontSize: fontSize != MediaQuery.of(buildContext).size.width * 0.02
        ? fontSize
        : MediaQuery.of(buildContext).size.width * 0.02,
    decoration: underlined ? TextDecoration.underline : TextDecoration.none,
  );
}

TextStyle azTitleStyle(
    {@required BuildContext buildContext,
    Color color = Colors.black,
    bool italic = false,
    double fontSize = 26.0,
    double height = 1.5,
    bool underlined = false}) {
  return TextStyle(
    color: color,
    // fontFamily: 'CM Sans Serif',
    fontFamily: 'BalooDa2',
    fontSize: fontSize,
    fontStyle: italic ? FontStyle.italic : FontStyle.normal,
    fontWeight: FontWeight.bold,
    height: height,
    decoration: underlined ? TextDecoration.underline : TextDecoration.none,
  );
}