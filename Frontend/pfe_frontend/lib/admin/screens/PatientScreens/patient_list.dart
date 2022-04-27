import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:pfe_frontend/authentication/models/user.dart';

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

  // enregistrer les patient dans une liste : 

  _retrievePatient() async {
    patients = [];
    // recuperer les patients avec une requete get // 
    List response = json.decode((await client.get(Uri.parse("http://10.0.2.2:8000/adminapp/patients/"))).body);
    response.forEach((element) {
      patients.add(User.fromJson(element));
    });
    setState(() {});
  }
  // **************************************** //

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