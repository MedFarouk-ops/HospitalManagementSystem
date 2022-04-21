
import 'package:flutter/material.dart';
import 'package:pfe_frontend/admin/screens/adminHome.dart';
import 'package:pfe_frontend/authentication/context/authcontext.dart';
import 'package:pfe_frontend/authentication/models/user.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:pfe_frontend/docteur/screens/docteurHome.dart';
import 'package:pfe_frontend/infermier/screens/infermierHome.dart';
import 'package:pfe_frontend/patient/screens/patientHome.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {

  const HomeScreen({ Key? key }) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Client client = http.Client();
  late SharedPreferences s_prefs;
  User? _authuser;
  bool _isAuth = false ;
  @override
  void initState(){
    super.initState();
    _initializeUser();
    _checkAuth();
  }
  _checkAuth() async {
    s_prefs = await SharedPreferences.getInstance();
    setState(() {
      _isAuth = s_prefs.getBool("isAuthenticated");
    });
  }

   _initializeUser() async {
    s_prefs = await SharedPreferences.getInstance();
    if(s_prefs.getBool("isAuthenticated") == true){
      List<String> authtokens = s_prefs.getStringList("authTokens");
      Map<String, dynamic> payload = Jwt.parseJwt(authtokens[0]);
      setState(() {
      _authuser = User(
        email: payload['email'] ,
        first_name: payload['nom'],
        last_name: payload['prenom'], 
        address: payload['address'], 
        age: payload['age'], 
        genre: payload['genre'], 
        role: payload['role'], 
        username: payload['username']
        );
      });
            
      if( _authuser!.role == 1 ){
        _navigateToAdmin();
      } 
      else if( _authuser!.role == 2 ){
        _navigateToPatient();
      }
      else if( _authuser!.role == 3 ){
        _navigateToDoctor();
      }
      else if( _authuser!.role == 4 ){
        _navigateToNurse();
      }

    }
  }

  _navigateToAdmin(){
    Navigator.of(context)
    .push(
      MaterialPageRoute(
        builder: (context) => const AdminHome()
        )
    );
  }

  _navigateToDoctor(){
    Navigator.of(context)
    .push(
      MaterialPageRoute(
        builder: (context) => const DocteurHome()
        )
    );
  }

  _navigateToNurse(){
    Navigator.of(context)
    .push(
      MaterialPageRoute(
        builder: (context) => const InfermierHome()
        )
    );
  }
  _navigateToPatient(){
    Navigator.of(context)
    .push(
      MaterialPageRoute(
        builder: (context) => const PatientHome()
        )
    );
  }
  

  @override
  Widget build(BuildContext context) {
   return Container();
   }
}