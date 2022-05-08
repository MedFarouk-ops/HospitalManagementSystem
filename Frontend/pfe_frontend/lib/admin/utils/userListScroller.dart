import "package:flutter/material.dart";
import 'package:pfe_frontend/admin/screens/DoctorScreens/doctor_list.dart';
import 'package:pfe_frontend/admin/screens/PatientScreens/patient_list.dart';
import 'package:pfe_frontend/admin/utils/StatefulWrapper.dart';
import 'package:pfe_frontend/authentication/utils/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';


class UserListScroller extends StatefulWidget {
  const UserListScroller({ Key? key }) : super(key: key);

  @override
  State<UserListScroller> createState() => _UserListScrollerState();
}

class _UserListScrollerState extends State<UserListScroller> {
  int? numberOfDoctor;
  int? numberOfPatient;
    
  // redirection de l'utilisateur : 
  _navigateToPatientList(){
    print(numberOfPatient);
    Navigator.of(context)
    .push(
      MaterialPageRoute(
        builder: (context) => const PatientListScreen()
        )
    );
  }
  _navigateToDoctorList(){
    print(numberOfDoctor);
    Navigator.of(context)
    .push(
      MaterialPageRoute(
        builder: (context) => const DoctorListScreen()
        )
    );
  }
  // ************************************************************************************************************************* //
  // ************************************************************************************************************************* //
    _initialiseNumberOfUser() async {
            final prefs = await SharedPreferences.getInstance(); 
            numberOfPatient = prefs.getInt("NumberOfpatients");
            numberOfDoctor = prefs.getInt("NumberOfdoctors");
            setState(() {});
    }
  // ************************************************************************************************************************* //
  // ************************************************************************************************************************* //
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    _initialiseNumberOfUser();
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
                        "${numberOfPatient} patients",
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
                          " ${numberOfDoctor}  docteurs",
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