import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget mainAppBar(BuildContext buildContext){
  return AppBar(
        elevation: 0.0,
        centerTitle: false,
        title: FittedBox(
          alignment: Alignment.center,
          fit: BoxFit.fill,
                  child: Text(
            'Lumini Chat',
            style: TextStyle(
              fontSize: 28.0,
              letterSpacing: 5,
              fontFamily: 'Lobster',
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      );
}