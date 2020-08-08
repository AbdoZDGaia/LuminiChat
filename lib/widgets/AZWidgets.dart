import 'package:flutter/material.dart';

InputDecoration azTextFieldInputDecoration(
    {BuildContext buildContext,
    String hintText,
    Color underlineColor = Colors.white}) {
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
