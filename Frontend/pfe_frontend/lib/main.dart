import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pfe_frontend/authentication/models/token.dart';
import 'package:pfe_frontend/authentication/models/user.dart';
import 'package:pfe_frontend/authentication/screens/auth_screen.dart';
import 'package:jwt_decode/jwt_decode.dart';

import 'package:pfe_frontend/authentication/screens/home_screen.dart';
import 'package:pfe_frontend/authentication/screens/login_screen.dart';
import 'package:pfe_frontend/authentication/utils/colors.dart';
import 'package:pfe_frontend/fingerprint_auth.dart';
import 'package:provider/provider.dart';
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
      home: const MyHomePage(title: 'App'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);


  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  late SharedPreferences s_prefs;
  bool? _isAuth = false ;
  bool use_fingeprint= false ;
  User? _user ; 
  List<String>? authtokens;
  
  


  _checkAuth() async {
    s_prefs = await SharedPreferences.getInstance();
    if(s_prefs.getBool("isAuthenticated") == null){
      s_prefs.setBool("isAuthenticated", false); 
    }
    setState(() {
      _isAuth = s_prefs.getBool("isAuthenticated");
    });

    if(s_prefs.getBool("use_fingerprint") == null){
      s_prefs.setBool("use_fingerprint", false); 
    }
    setState(() {
      use_fingeprint = s_prefs.getBool("use_fingerprint") ?? false;
    });


  }

  _initializeUser() async {
    s_prefs = await SharedPreferences.getInstance();
    if(s_prefs.getBool("isAuthenticated") == true){
      authtokens = s_prefs.getStringList("authTokens");
      String access = authtokens![0];
      Map<String, dynamic> payload = Jwt.parseJwt(authtokens![0]);
      print(payload);
      print(authtokens);
      _user = User(
        id: payload['user_id'],
        email: payload['email'] ,
        first_name: payload['nom'],
        last_name: payload['prenom'], 
        address: payload['address'], 
        mobilenumber: payload['mobilenumber'],
        age: payload['age'], 
        specialite: payload['specialite'],
        genre: payload['genre'], 
        role: payload['role'], 
        username: payload['username']
        );
    }
  }
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _checkAuth();
    _initializeUser();
  }

  
  
  @override
  Widget build(BuildContext context) {
    if(_isAuth ?? !(authtokens!.isEmpty) ){
      if(use_fingeprint){
        return Scaffold(
          body: FingerprintAuth(),
        );
      }else{
      return Scaffold(
      body: HomeScreen() ,
      );
      }
    }else{
    return Scaffold(
      body: AuthScreen() ,
    );
    }
  }
}
