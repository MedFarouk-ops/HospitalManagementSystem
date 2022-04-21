import 'dart:convert';

import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pfe_frontend/authentication/models/token.dart';
import 'package:pfe_frontend/authentication/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io' show Platform;
import 'package:jwt_decode/jwt_decode.dart';
import 'package:flutter/foundation.dart' show kIsWeb;


class AuthContext {

    List<String> authTokens = [];
    User user = User(email: "", first_name: "", last_name: "", address: "", age: "", genre: "", role: "", username: "");
    Future<User> SignIn({required String email , required String password}) async {
      SharedPreferences s_prefs = await SharedPreferences.getInstance();
      late http.Response response;
      print('aaaaaaaaaaaaaaaaaaaaaaaaaaaa');

      if (kIsWeb) {
          response = await http.post(
          Uri.parse('http://127.0.0.1:8000/auth/token/'),
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
        Uri.parse('http://10.0.2.2:8000/auth/token/'),
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
    Token token =  Token.fromJson(jsonDecode(response.body));

    Map<String, dynamic> payload = Jwt.parseJwt(token.accessToken);
    // make user from token data :   
    user = User(
      email: payload['email'] ,
      first_name: payload['nom'],
      last_name: payload['prenom'], 
      address: payload['address'], 
      age: payload['age'], 
      genre: payload['genre'], 
      role: payload['role'], 
      username: payload['username'],);
    // print user data to check everythink work correctly : 

    authTokens.add(token.accessToken);
    authTokens.add(token.refreshToken);
    print(user.username);
    print(user.address);
    print(user.age);
    print(user.email);
    print(user.first_name);
    print(user.last_name);
    print(user.genre);
    print(user.role);
    s_prefs.setStringList("authTokens", authTokens);
    return user;
    } else {
      return user;
    }
  }


    // sign up user 
    Future<User> signUpUser({
      required String email,required String password,
      required String username,required String first_name,
      required String last_name,required String address,
      required String age,required String role,
      required String genre,
    }) async { 
      String res = "some error occured";
      late http.Response response;
      print('registering ......');

      if (kIsWeb) {
          response = await http.post(
          Uri.parse('http://127.0.0.1:8000/auth/register/'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(<String, String>{
            'email': email,
            'username' : username , 
            'first_name' : first_name , 
            'last_name' : last_name,
            'address' : address , 
            'age' : age , 
            'role' : role ,
            'genre' : genre , 
            'password' : password
          }),
        );
      } else if(Platform.isAndroid) {
      response = await http.post(
        Uri.parse('http://10.0.2.2:8000/auth/register/'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'email': email,
          'username' : username , 
          'first_name' : first_name , 
          'last_name' : last_name,
          'address' : address , 
          'age' : age , 
          'role' : role ,
          'genre' : genre , 
          'password' : password
        }),
      );
    } 
  
    if (response.statusCode == 201) {
    // If the server did return a 201 CREATED response,
      print("user registred successfully ");
      User? authuser = await AuthContext().SignIn(
                email: email,
                password: password,
                );
      return authuser;
    } else {
       return user;
    }

   }
      

}