import 'dart:convert';

import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pfe_frontend/authentication/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io' show Platform;
import 'package:flutter/foundation.dart' show kIsWeb;


class AuthContext {

    List<String> authTokens = [];
    User user = User(email: "", first_name: "", last_name: "", address: "", age: "", genre: "", role: "", username: "", tokens: Token(accessToken: '' , refreshToken: ''));
  Future<User> SignIn({required String email , required String password}) async {
    SharedPreferences s_prefs = await SharedPreferences.getInstance();
    late http.Response response;
    print('aaaaaaaaaaaaaaaaaaaaaaaaaaaa');

    if (kIsWeb) {
        response = await http.post(
        Uri.parse('http://127.0.0.1:8000/auth/login/'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'email': email,
          'password' : password
        }),
      );
    } else if(Platform.isAndroid) {
    response = await http.post(
      Uri.parse('http://10.0.2.2:8000/auth/login/'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': email,
        'password' : password
      }),
    );
  } 
  
  
  if (response.statusCode == 200) {
    // If the server did return a 201 CREATED response,
    // then parse the JSON.
    print("loggeeddd onnn");
    user = User.fromJson(jsonDecode(response.body));
    authTokens.add(user.tokens.accessToken);
    authTokens.add(user.tokens.refreshToken);
    print("access token : ");
    print(authTokens[0]);
    print("refresh token : ");
    print(authTokens[1]);
    print("user details : ");
    print(user.username);
    print(user.address);
    print(user.age);
    print(user.email);
    print(user.first_name);
    print(user.last_name);
    print(user.genre);
    print(user.role);
    
    s_prefs.setStringList("authTokens", authTokens);
    return User.fromJson(jsonDecode(response.body));
  } else {
      return user;
    }
  }

}