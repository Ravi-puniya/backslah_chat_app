import 'package:backslah_chat_app/Pages/homepage.dart';
import 'package:backslah_chat_app/Pages/auth/login_page.dart';
import 'package:backslah_chat_app/constants/constants.dart';
import 'package:backslah_chat_app/helper/helper_function.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _issignedIn = false;
  @override
  void initState() {
    super.initState();
  }

  getUserlogedinstatus() async {
    await HelperFunctrion.getUserLogggedinstatus().then((value) {
      if (value != null) {
        setState(() {
            _issignedIn = value;
        });
      
      }
    });
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Constants().primaryColror,
        scaffoldBackgroundColor: Colors.white
      ),
      debugShowCheckedModeBanner: false,
      home: _issignedIn ? HomeScreen() : LoginScreen(),
    );
  }
}
