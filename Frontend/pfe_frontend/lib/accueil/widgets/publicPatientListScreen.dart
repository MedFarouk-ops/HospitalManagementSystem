import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:pfe_frontend/accueil/widgets/show_user.dart';
import 'package:pfe_frontend/admin/screens/Common/user_show.dart';
import 'dart:io' show Platform;
import 'package:pfe_frontend/authentication/models/user.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';



class PublicPatientListScreen extends StatefulWidget {
  const PublicPatientListScreen({ Key? key }) : super(key: key);

  @override
  State<PublicPatientListScreen> createState() => _PublicPatientListScreenState();
}

class _PublicPatientListScreenState extends State<PublicPatientListScreen> {
  Client client = http.Client();
  
  List<User> patientList = [];
  
  @override
  void initState(){
    super.initState();
    _retrieveUsers();
  }

  void setStateIfMounted(f) {
    if (mounted) setState(f);
  }
  // enregistrer les patient dans une liste : 

  _retrieveUsers() async {
    // patients = [];
    // recuperer les patients avec une requete get // 
    List response ; 

    // si l'application est lancée dans le web ( navigateur ) : 
    if (kIsWeb) {
      response = json.decode((await client.get(Uri.parse("http://127.0.0.1:8000/adminapp/patients/"))).body);
      response.forEach((element) {
        patientList.add(User.fromJson(element));
      });
      setStateIfMounted(() {});
    }

    // si l'application est lancée sur mobile ( android )

    else if(Platform.isAndroid) {
      response = json.decode((await client.get(Uri.parse("http://10.0.2.2:8000/adminapp/patients/"))).body);
      response.forEach((element) {
        patientList.add(User.fromJson(element));
      });
      setStateIfMounted(() {});
    }
    _initialsePatientNumber();
  }

  // ************************************************************************************************************************* //
  // ************************************************************************************************************************* //

    _initialsePatientNumber() async {
      final prefs = await SharedPreferences.getInstance(); 
      prefs.setInt("NumberOfpatients", patientList.length);
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
              title: Text(patientList[index].first_name),
              subtitle: Text(patientList[index].email),
              onTap: () {
                 Navigator.of(context)
                  .push(
                    MaterialPageRoute(
                      builder: (context) => PublicUserShow(user: patientList[index],)
                      )
                  );
              },
            ),
          );
        },
        itemCount: patientList.length,
        shrinkWrap: true,
        padding: EdgeInsets.all(5),
        scrollDirection: Axis.vertical,
      )
    );
  }
}