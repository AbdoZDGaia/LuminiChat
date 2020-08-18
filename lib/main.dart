import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:lumini_chat/helper/authenticate.dart';
import 'package:lumini_chat/helper/helper_methods.dart';
import 'package:lumini_chat/screens/chats_screen.dart';
import 'package:lumini_chat/screens/intro_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isLoggedIn;
  @override
  void initState() {
    getLoggedInState();
    super.initState();
  }

  getLoggedInState() async {
    await HelperFunctions.getIsUserLoggedInSharedPreferences().then((value) {
      setState(() {
        isLoggedIn = value;
      });
    });
  }

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
      home: isLoggedIn != null
          ? isLoggedIn ? ChatRoom() : Authenticate()
          : IntroScreen(),
    );
  }
}
