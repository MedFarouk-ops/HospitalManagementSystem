import 'package:flutter/material.dart';
import 'package:pfe_frontend/authentication/screens/auth_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';


void main() async {
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  
  const MyApp({Key? key}) : super(key: key);
    

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter app',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: AuthScreen(),
    );
  }
}

