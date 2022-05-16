import 'package:flutter/material.dart';
import 'package:pfe_frontend/admin/screens/adminHome.dart';
import 'package:pfe_frontend/admin/screens/Common/create_user.dart';
import 'package:pfe_frontend/authentication/widgets/user_profile.dart';


const adminHomeScreenItems = [
          AdminHome(),
          CreateUser(),
          UserProfile(),
];

const String serverUrl = "http://127.0.0.1:8000" ; 
const String mobileServerUrl = "http://10.0.2.2:8000" ; 