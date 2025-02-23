import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todoapp/screens/HomeScreen.dart';
import 'package:todoapp/screens/login_screen.dart';
import 'package:todoapp/screens/signup_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
  );
  runApp(MyApp());
}

final FirebaseAuth _auth = FirebaseAuth.instance;

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.blue, primaryColor: Colors.white),
      home: _auth.currentUser != null ? Homescreen() : LoginScreen(),
    );
  }
}
