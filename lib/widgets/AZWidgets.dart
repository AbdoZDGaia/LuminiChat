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
    {Color color = Colors.black,
    bool italic = false,
    double fontSize = 16,
    bool underlined = false}) {
  return TextStyle(
    color: color,
    fontWeight: FontWeight.bold,
    fontStyle: italic ? FontStyle.italic : FontStyle.normal,
    fontSize: fontSize != 16 ? fontSize : 16,
    decoration: underlined ? TextDecoration.underline : TextDecoration.none,
  );
}
