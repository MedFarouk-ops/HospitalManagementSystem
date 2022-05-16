import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:pfe_frontend/accueil/widgets/show_doctor.dart';
import 'package:pfe_frontend/accueil/widgets/show_user.dart';
import 'package:pfe_frontend/admin/screens/Common/user_show.dart';
import 'package:pfe_frontend/admin/utils/dimensions.dart';
import 'dart:io' show Platform;
import 'package:pfe_frontend/authentication/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';



class PublicDoctorListScreen extends StatefulWidget {
  final   List<User> doctorList;
  const PublicDoctorListScreen({ Key? key , required this.doctorList}) : super(key: key);

  @override
  State<PublicDoctorListScreen> createState() => _PublicDoctorListScreenState();
}

class _PublicDoctorListScreenState extends State<PublicDoctorListScreen> {

  Client client = http.Client();
  
  
  
  void setStateIfMounted(f) {
    if (mounted) setState(f);
  }

  @override
  void initState(){
    super.initState();
  }

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
              title: Text( widget.doctorList[index].first_name ),
              subtitle: Text(widget.doctorList[index].email),
              onTap: () {
                 Navigator.of(context)
                  .push(
                    MaterialPageRoute(
                      builder: (context) => PublicDoctorShow(user: widget.doctorList[index],)
                      )
                  );
              },
            ),
          );
        },
        itemCount: widget.doctorList.length,
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