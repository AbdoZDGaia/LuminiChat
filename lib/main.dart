import 'package:flutter/material.dart';
import 'package:lumini_chat/helper/authenticate.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Lumini Chat',
      theme: ThemeData(
        primarySwatch: Colors.red,
        accentColor: Color(0xfffaeecd),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Authenticate(),
    );
  }
}
