import "package:flutter/material.dart";
import 'package:pfe_frontend/accueil/utils/api_methods.dart';
import 'package:pfe_frontend/accueil/widgets/publicDoctorListScreen.dart';
import 'package:pfe_frontend/accueil/widgets/publicPatientListScreen.dart';
import 'package:pfe_frontend/admin/utils/StatefulWrapper.dart';
import 'package:pfe_frontend/authentication/models/user.dart';
import 'package:pfe_frontend/authentication/utils/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';




class AccueilUserListScroller extends StatefulWidget {
    final int numberOfDoctor;
    final int numberOfPatient;
    final List<User> patientList;
    final List<User> doctorList;
  const AccueilUserListScroller({ Key? key , 
  required this.numberOfDoctor ,
  required this.numberOfPatient ,
  required this.patientList,
  required this.doctorList,
  }) : super(key: key);

  @override
  State<AccueilUserListScroller> createState() => _AccueilUserListScrollerState();
}

class _AccueilUserListScrollerState extends State<AccueilUserListScroller> {

    
  // redirection de l'utilisateur : 
  _navigateToPatientList(){
    print(widget.numberOfPatient);
    Navigator.of(context)
    .push(
      MaterialPageRoute(
        builder: (context) => PublicPatientListScreen(patientList:widget.patientList ,)
        )
    );
  }
  _navigateToDoctorList(){
    print(widget.numberOfDoctor);
    Navigator.of(context)
    .push(
      MaterialPageRoute(
        builder: (context) => PublicDoctorListScreen(doctorList: widget.doctorList,)
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    final double categoryHeight = MediaQuery.of(context).size.height * 0.30 - 50; 
    return Container(
      child:  SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      scrollDirection: Axis.horizontal,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 2),
        child: FittedBox(
          fit: BoxFit.fill,
          alignment: Alignment.topCenter,
          child: Row(
            children: <Widget>[
              InkWell(
                onTap: _navigateToPatientList,
                child: Container(
                width: 120,
                margin: EdgeInsets.only(right: 20 , left: 2),
                height: categoryHeight,
                decoration: BoxDecoration(color:fourthAdminColor, borderRadius: BorderRadius.all(Radius.circular(8.0)) ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Liste des\nPatient",
                        style: TextStyle(fontSize: 22, color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      Text(
                        "${widget.numberOfPatient} patients",
                        style: TextStyle(fontSize: 16, color: Color.fromARGB(255, 255, 254, 254)),
                      ),
                    ],
                  ),
                ),
              ),),
              InkWell(
                onTap: _navigateToDoctorList,
                child:Container(
                width: 120,
                margin: EdgeInsets.only(right: 20),
                height: categoryHeight,
                decoration: BoxDecoration(color: fourthAdminColor, borderRadius: BorderRadius.all(Radius.circular(8.0))),
                child: Container(
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Liste des\nDocteurs",
                          style: TextStyle(fontSize: 22, color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        Text(
                          " ${widget.numberOfDoctor}  docteurs",
                          style: TextStyle(fontSize: 16, color: Color.fromARGB(255, 255, 255, 255)),
                        ),
                      ],
                    ),
                  ),
                ),
              ),),
              InkWell(
                onTap: _navigateToPatientList,
                child:              Container(
                width: 120,
                margin: EdgeInsets.only(right: 20),
                height: categoryHeight,
                decoration: BoxDecoration(color: fourthAdminColor, borderRadius: BorderRadius.all(Radius.circular(8.0))),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Voir tout",
                        style: TextStyle(fontSize: 22, color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      
                    ],
                  ),
                ),
              ),),
            ],
          ),
        ),
      ),),
    );
  }
}