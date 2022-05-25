import "package:flutter/material.dart";
import 'package:pfe_frontend/accueil/models/reservation.dart';
import 'package:pfe_frontend/accueil/utils/api_methods.dart';
import 'package:pfe_frontend/accueil/utils/internet_widgets.dart';
import 'package:pfe_frontend/accueil/widgets/publicDoctorListScreen.dart';
import 'package:pfe_frontend/accueil/widgets/publicPatientListScreen.dart';
import 'package:pfe_frontend/admin/utils/StatefulWrapper.dart';
import 'package:pfe_frontend/authentication/context/authcontext.dart';
import 'package:pfe_frontend/authentication/models/user.dart';
import 'package:pfe_frontend/authentication/utils/colors.dart';
import 'package:pfe_frontend/docteur/screens/partie_consultations/consultation_layout.dart';
import 'package:pfe_frontend/docteur/screens/partie_reservations/all_reservations_list.dart';
import 'package:pfe_frontend/docteur/utils/doctor_api_methods.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DoctorCustomListScroller extends StatefulWidget {
  const DoctorCustomListScroller({ Key? key ,   }) : super(key: key);

  @override
  State<DoctorCustomListScroller> createState() => _DoctorCustomListScrollerState();
}

class _DoctorCustomListScrollerState extends State<DoctorCustomListScroller> {

    
  
  List<Reservation> doctorReservations = [];  
  
    void setStateIfMounted(f) {
      if (mounted) setState(f);
    }     
  
    _getReservationList() async {
      User user = await AuthContext().getUserDetails();
      print(user.first_name);
      doctorReservations = await DoctorApiMethods().getDoctorReservationList(user.id);
      setStateIfMounted(() {});
    }

     @override
    void initState() {
      super.initState();
      _getReservationList();
    }


  _navigateToConsultationLayout(){
    Navigator.of(context)
    .push(
      MaterialPageRoute(
        builder: (context) => const ConsultationLayout()
        )
    );
  } 

  _navigateToResLayout(){
    Navigator.of(context)
    .push(
      MaterialPageRoute(
        builder: (context) => DoctorAllReservationList(reservations: doctorReservations,)
        )
    );
  }


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
                onTap: () {
                  _navigateToResLayout();
                },
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
                        "",
                        style: TextStyle(fontSize: 16, color: Color.fromARGB(255, 255, 254, 254)),
                      ),
                    ],
                  ),
                ),
              ),),
              Divider(),
              
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
                        " Analyses/Bilans ",
                        style: TextStyle(fontSize: 22, color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 1,
                      ),
                      Text(
                        " ",
                        style: TextStyle(fontSize: 16, color: Color.fromARGB(255, 255, 254, 254)),
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


class DoctorSecondListScroller extends StatefulWidget {
  const DoctorSecondListScroller({ Key? key ,   }) : super(key: key);

  @override
  State<DoctorSecondListScroller> createState() => _DoctorSecondListScrollerState();
}

class _DoctorSecondListScrollerState extends State<DoctorSecondListScroller> {

    
  _navigateToConsultationLayout(){
    Navigator.of(context)
    .push(
      MaterialPageRoute(
        builder: (context) => const ConsultationLayout()
        )
    );
  }


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
          child :Row(
            children: <Widget>[
              InkWell(
                onTap: () {
                  _navigateToConsultationLayout();
                },
                child:Container(
                width: miniWidgetWidth,
                margin: EdgeInsets.only(right: 20 , left: 2),
                height: categoryHeight/1.4,
                decoration: BoxDecoration(color: AdminColorSix, borderRadius: BorderRadius.all(Radius.circular(8.0))),
                child: Container(
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "historique de consultation",
                          style: TextStyle(fontSize: 22, color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          " ",
                          style: TextStyle(fontSize: 16, color: Color.fromARGB(255, 255, 255, 255)),
                        ),
                      ],
                    ),
                  ),
                ),
              ),),
              InkWell(
                onTap: () {
                  _navigateToConsultationLayout();
                },
                child:Container(
                width: miniWidgetWidth,
                margin: EdgeInsets.only(right: 20),
                height: categoryHeight/1.4,
                decoration: BoxDecoration(color: AdminColorSix, borderRadius: BorderRadius.all(Radius.circular(8.0))),
                child: Container(
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Historique des ordonnances ",
                          style: TextStyle(fontSize: 22, color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 2,
                        ),
                        Text(
                          " ",
                          style: TextStyle(fontSize: 16, color: Color.fromARGB(255, 255, 255, 255)),
                        ),
                      ],
                    ),
                  ),
                ),
          
          ),
        ),],
              
              
              )
        ),
      ),),
    );
  }
}



class DoctorThirdListScroller extends StatefulWidget {
  const DoctorThirdListScroller({ Key? key ,   }) : super(key: key);

  @override
  State<DoctorThirdListScroller> createState() => _DoctorThirdListScrollerState();
}

class _DoctorThirdListScrollerState extends State<DoctorThirdListScroller> {

    
  _navigateToConsultationLayout(){
    Navigator.of(context)
    .push(
      MaterialPageRoute(
        builder: (context) => const ConsultationLayout()
        )
    );
  }


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
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
        child: FittedBox(
          fit: BoxFit.fill,
          alignment: Alignment.topCenter,
          child:Row(
            children: <Widget>[
               InkWell(
                onTap: () {
                  _navigateToConsultationLayout();
                },
                child:Container(
                width: miniWidgetWidth,
                margin: EdgeInsets.only(right: 20),
                height: categoryHeight/1.2,
                decoration: BoxDecoration(color: AdminColorSix, borderRadius: BorderRadius.all(Radius.circular(8.0))),
                child: Container(
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "compte rendu des explorations radiologique ",
                          style: TextStyle(fontSize: 22, color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 2,
                        ),
                        Text(
                          " ",
                          style: TextStyle(fontSize: 16, color: Color.fromARGB(255, 255, 255, 255)),
                        ),
                      ],
                    ),
                  ),
                ),
          
          ),
        ),

        InkWell(
                onTap: () {
                  _navigateToConsultationLayout();
                },
                child:Container(
                width: miniWidgetWidth,
                margin: EdgeInsets.only(right: 20),
                height: categoryHeight/1.2,
                decoration: BoxDecoration(color: AdminColorSix, borderRadius: BorderRadius.all(Radius.circular(8.0))),
                child: Container(
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "cliché des images radiologique ",
                          style: TextStyle(fontSize: 22, color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 2,
                        ),
                        Text(
                          " ",
                          style: TextStyle(fontSize: 16, color: Color.fromARGB(255, 255, 255, 255)),
                        ),
                      ],
                    ),
                  ),
                ),
          
          ),
        ),
        
        
        
        
        ]),
      ))),
    );
  }
}





class DoctorFourthListScroller extends StatefulWidget {
  const DoctorFourthListScroller({ Key? key ,   }) : super(key: key);

  @override
  State<DoctorFourthListScroller> createState() => _DoctorFourthListScrollerState();
}

class _DoctorFourthListScrollerState extends State<DoctorFourthListScroller> {

    
  _navigateToConsultationLayout(){
    Navigator.of(context)
    .push(
      MaterialPageRoute(
        builder: (context) => const ConsultationLayout()
        )
    );
  }


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
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
        child: FittedBox(
          fit: BoxFit.fill,
          alignment: Alignment.topCenter,
          child:Row(
            children: <Widget>[
               InkWell(
                onTap: () {
                  _navigateToConsultationLayout();
                },
                child:Container(
                width: miniWidgetWidth*2+12,
                margin: EdgeInsets.only(right: 20),
                height: categoryHeight/2,
                decoration: BoxDecoration(color: AdminColorSix, borderRadius: BorderRadius.all(Radius.circular(8.0))),
                child: Container(
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "Résumé des dossiers médicaux",
                          style: TextStyle(fontSize: 22, color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),          
          ),
        ),
        
        ]),
      ))),
    );
  }
}























