import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:pfe_frontend/accueil/utils/api_methods.dart';
import 'package:pfe_frontend/admin/screens/Common/user_show.dart';
import 'package:pfe_frontend/admin/utils/dimensions.dart';
import 'dart:io' show Platform;
import 'package:pfe_frontend/authentication/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';


class PatientListScreen extends StatefulWidget {
  const PatientListScreen({ Key? key }) : super(key: key);

  @override
  State<PatientListScreen> createState() => _PatientListScreenState();
}

class _PatientListScreenState extends State<PatientListScreen> {
  
  Client client = http.Client();
  
  List<User> patients = [];
  
  @override
  void initState(){
    super.initState();
    _retrievePatient();
  }

  void setStateIfMounted(f) {
  if (mounted) setState(f);
  }


  // enregistrer les patient dans une liste : 

  _retrievePatient() async {
     
     patients = await ApiMethods().getPatients();
     setStateIfMounted(() {});
    _initialsePatientNumber();
  }

  // ************************************************************************************************************************* //
  // ************************************************************************************************************************* //

    _initialsePatientNumber() async {
      final prefs = await SharedPreferences.getInstance(); 
      prefs.setInt("NumberOfpatients", patients.length);
    }

  // ************************************************************************************************************************* //
  // ************************************************************************************************************************* //


  @override
  Widget build(BuildContext context) {
     return Scaffold(
      appBar: AppBar(
        title: Text("Liste de patients"),
      ),
      body: ListView.builder(
        itemBuilder: (BuildContext, index){
          return Card(
            child: ListTile(
              leading: CircleAvatar(backgroundImage: AssetImage("assets/images/user.png"),),
              title: Text(patients[index].first_name),
              subtitle: Text(patients[index].email),
              onTap: () {
                 Navigator.of(context)
                  .push(
                    MaterialPageRoute(
                      builder: (context) => UserShow(user: patients[index],)
                      )
                  );
              },
            ),
          );
        },
        itemCount: patients.length,
        shrinkWrap: true,
        padding: EdgeInsets.all(5),
        scrollDirection: Axis.vertical,
      )
    );
  }
}