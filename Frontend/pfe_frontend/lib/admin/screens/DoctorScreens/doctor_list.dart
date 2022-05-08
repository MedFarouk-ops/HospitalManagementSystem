import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:pfe_frontend/admin/screens/Common/user_show.dart';
import 'dart:io' show Platform;
import 'package:pfe_frontend/authentication/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';


class DoctorListScreen extends StatefulWidget {
  const DoctorListScreen({ Key? key }) : super(key: key);

  @override
  State<DoctorListScreen> createState() => _DoctorListScreenState();
}

class _DoctorListScreenState extends State<DoctorListScreen> {

  Client client = http.Client();
  
  List<User> doctors = [];
  
  @override
  void initState(){
    super.initState();
    _retrievePatient();
    _initialseDoctorsNumber();
  }
//*************************************************************************************************************************************** */
//*************************************************************************************************************************************** */

  _retrievePatient() async {
    doctors = [];
    List response ;
    // si l'application est lancée dans le web ( navigateur ) : 
    if (kIsWeb) {
      response = json.decode((await client.get(Uri.parse("http://127.0.0.1:8000/adminapp/doctors/"))).body);
      response.forEach((element) {
        doctors.add(User.fromJson(element));
      });
    setState(() {});
    }
    // si l'application est lancée sur mobile ( android )
    else if(Platform.isAndroid) {
      response = json.decode((await client.get(Uri.parse("http://10.0.2.2:8000/adminapp/doctors/"))).body);
      response.forEach((element) {
        doctors.add(User.fromJson(element));
      });
      setState(() {});
    }
  }
//*************************************************************************************************************************************** */
//*************************************************************************************************************************************** */

    _initialseDoctorsNumber() async {
      final prefs = await SharedPreferences.getInstance(); 
      prefs.setInt("NumberOfdoctors", doctors.length);
    }

//*************************************************************************************************************************************** */
//*************************************************************************************************************************************** */


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Liste de docteurs :"),
      ),
      body: ListView.builder(
        itemBuilder: (BuildContext, index){
          return Card(
            child: ListTile(
              leading: CircleAvatar(backgroundImage: AssetImage("assets/images/user.png"),),
              title: Text( doctors[index].first_name ),
              subtitle: Text(doctors[index].email),
              onTap: () {
                 Navigator.of(context)
                  .push(
                    MaterialPageRoute(
                      builder: (context) => UserShow(user: doctors[index],)
                      )
                  );
              },
            ),
          );
        },
        itemCount: doctors.length,
        shrinkWrap: true,
        padding: EdgeInsets.all(5),
        scrollDirection: Axis.vertical,
      )
    );
  }
}

//*************************************************************************************************************************************** */
//*************************************************************************************************************************************** */
//*************************************************************************************************************************************** */