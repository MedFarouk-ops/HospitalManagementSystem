import "package:flutter/material.dart";
import 'package:pfe_frontend/accueil/utils/api_methods.dart';
import 'package:pfe_frontend/accueil/widgets/publicDoctorListScreen.dart';
import 'package:pfe_frontend/accueil/widgets/publicPatientListScreen.dart';
import 'package:pfe_frontend/admin/utils/StatefulWrapper.dart';
import 'package:pfe_frontend/authentication/models/user.dart';
import 'package:pfe_frontend/authentication/utils/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DoctorCustomListScroller extends StatefulWidget {
  const DoctorCustomListScroller({ Key? key ,   }) : super(key: key);

  @override
  State<DoctorCustomListScroller> createState() => _DoctorCustomListScrollerState();
}

class _DoctorCustomListScrollerState extends State<DoctorCustomListScroller> {

    
  


  @override
  Widget build(BuildContext context) {
    final double categoryHeight = MediaQuery.of(context).size.height * 0.30 - 50;
    double screenWidth = MediaQuery.of(context).size.width;
    double miniWidgetWidth = screenWidth/2 - 15 ; 
    double miniWidgetHeight = categoryHeight/2 +5 ; 

 

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
                onTap: () {},
                child: Container(
                width: miniWidgetWidth,
                margin: EdgeInsets.only(right: 20 , left: 2),
                height: miniWidgetHeight,
                decoration: BoxDecoration(color:AdminColorSix, borderRadius: BorderRadius.all(Radius.circular(8.0)) ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        " Rendez vous",
                        style: TextStyle(fontSize: 22, color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "12 ",
                        style: TextStyle(fontSize: 16, color: Color.fromARGB(255, 255, 254, 254)),
                      ),
                    ],
                  ),
                ),
              ),),
              InkWell(
                onTap: () {},
                child:Container(
                width: miniWidgetWidth,
                margin: EdgeInsets.only(right: 20),
                height: miniWidgetHeight,
                decoration: BoxDecoration(color: AdminColorSix, borderRadius: BorderRadius.all(Radius.circular(8.0))),
                child: Container(
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Consulations",
                          style: TextStyle(fontSize: 22, color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          " ${10} ",
                          style: TextStyle(fontSize: 16, color: Color.fromARGB(255, 255, 255, 255)),
                        ),
                      ],
                    ),
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