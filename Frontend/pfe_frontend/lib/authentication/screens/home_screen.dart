
import 'package:flutter/material.dart';
import 'package:pfe_frontend/accueil/Responsive/mobile_responsive_screen.dart';
import 'package:pfe_frontend/accueil/Screens/AccueilHome.dart';
import 'package:pfe_frontend/admin/responsive/mobile_screen_layout.dart';
import 'package:pfe_frontend/admin/screens/adminHome.dart';
import 'package:pfe_frontend/analyste/responsive/mobile_layout_screen.dart';
import 'package:pfe_frontend/authentication/context/authcontext.dart';
import 'package:pfe_frontend/authentication/models/user.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:pfe_frontend/docteur/responsive/mobile_layout_screen.dart';
import 'package:pfe_frontend/docteur/screens/docteurHome.dart';
import 'package:pfe_frontend/infermier/screens/infermierHome.dart';
import 'package:pfe_frontend/patient/responsive/mobile_screen_layout.dart';
import 'package:pfe_frontend/patient/screens/patientHome.dart';
import 'package:pfe_frontend/pharmacie/responsive/mobile_layout_screen.dart';
import 'package:pfe_frontend/radiologue/responsive/mobile_layout_responsive.dart';
import 'package:pfe_frontend/radiologue/screens/radiologue_home.dart';
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
  bool? _isAuth = false ;
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
      List<String>? authtokens = s_prefs.getStringList("authTokens");
      Map<String, dynamic> payload = Jwt.parseJwt(authtokens![0]);
      setState(() {
      _authuser = User(
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
      else if( _authuser!.role == 5 ){
        _navigateToAccueil();
      }
      else if( _authuser!.role == 6 ){
        _navigateToRadios();
      }
      else if( _authuser!.role == 7 ){
        _navigateToAnalyste();
      }
      else if( _authuser!.role == 8 ){
        _navigateToPharmacie();
      }

    }
  }

  _navigateToAdmin(){
    Navigator.of(context)
    .push(
      MaterialPageRoute(
        builder: (context) => const AdminMobileScreenLayout()
        )
    );
  }

  _navigateToDoctor(){
    Navigator.of(context)
    .push(
      MaterialPageRoute(
        builder: (context) => const DoctorMobileResponiveLayout()
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
        builder: (context) => const PatientMobileLayout()
        )
    );
  }

  _navigateToAccueil(){
    Navigator.of(context)
    .push(
      MaterialPageRoute(
        builder: (context) => const AccueilMobileScreenLayout()
        )
    );
  }

  _navigateToRadios(){
    Navigator.of(context)
    .push(
      MaterialPageRoute(
        builder: (context) => const RadiologueMobileLayout()
        )
    );
  }


  _navigateToAnalyste(){
    Navigator.of(context)
    .push(
      MaterialPageRoute(
        builder: (context) => const AnalysteMobileLayout()
        )
    );
  }
  _navigateToPharmacie(){
    Navigator.of(context)
    .push(
      MaterialPageRoute(
        builder: (context) => const PharmacieMobileLayout()
        )
    );
  }
  

  @override
  Widget build(BuildContext context) {
   return Container();
   }
}