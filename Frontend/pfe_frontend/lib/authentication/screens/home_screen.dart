
import 'package:flutter/material.dart';
import 'package:pfe_frontend/admin/screens/adminHome.dart';
import 'package:pfe_frontend/authentication/context/authcontext.dart';
import 'package:pfe_frontend/authentication/models/user.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:pfe_frontend/docteur/screens/docteurHome.dart';
import 'package:pfe_frontend/infermier/screens/infermierHome.dart';
import 'package:pfe_frontend/patient/screens/patientHome.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  final User user;

  const HomeScreen({ Key? key , required User this.user }) : super(key: key);

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
    _authuser = widget.user;
    _checkAuth();

    if( _authuser!.role == "1" ){
      _navigateToAdmin();
    } 
    else if( _authuser!.role == "2" ){
      _navigateToPatient();
    }
    else if( _authuser!.role == "3" ){
      _navigateToDoctor();
    }
    else if( _authuser!.role == "4" ){
      _navigateToNurse();
    }

  }
  _checkAuth() async {
    s_prefs = await SharedPreferences.getInstance();
    setState(() {
      _isAuth = s_prefs.getBool("isAuthenticated");
    });
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
   return Scaffold(
      appBar: AppBar(
        title: Center(),
        elevation: 0,
        backgroundColor: Colors.lightBlue,
      ),
      body: RefreshIndicator(onRefresh: () async{
        },
        child : Column(
          crossAxisAlignment : CrossAxisAlignment.stretch,
          children : [
            Padding(
              padding:const EdgeInsets.only(top : 10, bottom: 10) ,
              child: Text(' Logged in successfully ' +_authuser!.first_name +" connected : "+ _isAuth.toString()
              , textAlign: TextAlign.center
              ,style: TextStyle(color:Colors.black),),
              ),
          ],
        )
      ),

     
    );
   }
}