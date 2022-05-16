import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:pfe_frontend/accueil/widgets/show_user.dart';
import 'package:pfe_frontend/admin/screens/Common/user_show.dart';
import 'package:pfe_frontend/admin/utils/dimensions.dart';
import 'dart:io' show Platform;
import 'package:pfe_frontend/authentication/models/user.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';



class PublicPatientListScreen extends StatefulWidget {
  final   List<User> patientList;
  const PublicPatientListScreen({ Key? key , required this.patientList}) : super(key: key);

  @override
  State<PublicPatientListScreen> createState() => _PublicPatientListScreenState();
}

class _PublicPatientListScreenState extends State<PublicPatientListScreen> {
  Client client = http.Client();
  
  
  @override
  void initState(){
    super.initState();
  }

  void setStateIfMounted(f) {
    if (mounted) setState(f);
  }
 

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
              title: Text(widget.patientList[index].first_name),
              subtitle: Text(widget.patientList[index].email),
              onTap: () {
                 Navigator.of(context)
                  .push(
                    MaterialPageRoute(
                      builder: (context) => PublicUserShow(user: widget.patientList[index],)
                      )
                  );
              },
            ),
          );
        },
        itemCount: widget.patientList.length,
        shrinkWrap: true,
        padding: EdgeInsets.all(5),
        scrollDirection: Axis.vertical,
      )
    );
  }
}