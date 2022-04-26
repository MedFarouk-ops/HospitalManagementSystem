import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:pfe_frontend/authentication/models/user.dart';


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
  }
  _retrievePatient() async {
    doctors = [];
    List response = json.decode((await client.get(Uri.parse("http://10.0.2.2:8000/adminapp/doctors/"))).body);
    response.forEach((element) {
      doctors.add(User.fromJson(element));
    });
    setState(() {});
  }

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
              onTap: () {},
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