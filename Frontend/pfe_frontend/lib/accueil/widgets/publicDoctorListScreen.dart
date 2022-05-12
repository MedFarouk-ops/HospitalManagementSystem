import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:pfe_frontend/accueil/widgets/show_doctor.dart';
import 'package:pfe_frontend/accueil/widgets/show_user.dart';
import 'package:pfe_frontend/admin/screens/Common/user_show.dart';
import 'dart:io' show Platform;
import 'package:pfe_frontend/authentication/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';



class PublicDoctorListScreen extends StatefulWidget {
  const PublicDoctorListScreen({ Key? key }) : super(key: key);

  @override
  State<PublicDoctorListScreen> createState() => _PublicDoctorListScreenState();
}

class _PublicDoctorListScreenState extends State<PublicDoctorListScreen> {

  Client client = http.Client();
  
  List<User> doctorList = [];
  
  void setStateIfMounted(f) {
    if (mounted) setState(f);
  }

  @override
  void initState(){
    super.initState();
    _retrieveDoctors();
  }
//*************************************************************************************************************************************** */
//*************************************************************************************************************************************** */

  _retrieveDoctors() async {
    List response ;
    // si l'application est lancée dans le web ( navigateur ) : 
    if (kIsWeb) {
      response = json.decode((await client.get(Uri.parse("http://127.0.0.1:8000/adminapp/doctors/"))).body);
      response.forEach((element) {
        doctorList.add(User.fromJson(element));
      });
    setStateIfMounted(() {});
    }
    // si l'application est lancée sur mobile ( android )
    else if(Platform.isAndroid) {
      response = json.decode((await client.get(Uri.parse("http://10.0.2.2:8000/adminapp/doctors/"))).body);
      response.forEach((element) {
        doctorList.add(User.fromJson(element));
      });
    setStateIfMounted(() {});

    }
    _initialseDoctorsNumber();
  }
//*************************************************************************************************************************************** */
//*************************************************************************************************************************************** */

    _initialseDoctorsNumber() async {
      final prefs = await SharedPreferences.getInstance(); 
      prefs.setInt("NumberOfdoctors", doctorList.length);
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
              title: Text( doctorList[index].first_name ),
              subtitle: Text(doctorList[index].email),
              onTap: () {
                 Navigator.of(context)
                  .push(
                    MaterialPageRoute(
                      builder: (context) => PublicDoctorShow(user: doctorList[index],)
                      )
                  );
              },
            ),
          );
        },
        itemCount: doctorList.length,
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