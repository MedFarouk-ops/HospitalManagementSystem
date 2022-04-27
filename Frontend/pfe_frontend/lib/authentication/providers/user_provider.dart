import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pfe_frontend/authentication/context/authcontext.dart';
import 'package:pfe_frontend/authentication/models/user.dart';



class UserProvider with ChangeNotifier{
  User? _user ;
  final AuthContext _authContext = AuthContext();
  User get getUser => _user!;

  Future<void> refreshUser() async {
    User user = await _authContext.getUserDetails();
    _user = user;
    notifyListeners();
  }

}