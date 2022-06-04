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
    _retrieveDoctors();
  }

  void setStateIfMounted(f) {
    if (mounted) setState(f);
  }


//*************************************************************************************************************************************** */
//*************************************************************************************************************************************** */

  _retrieveDoctors() async {
    
     doctors = await ApiMethods().getDoctors();
     setStateIfMounted(() {});
    _initialseDoctorsNumber();
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