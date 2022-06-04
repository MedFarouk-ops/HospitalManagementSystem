import 'package:flutter/material.dart';
import 'package:pfe_frontend/accueil/models/reservation.dart';
import 'package:pfe_frontend/authentication/utils/colors.dart';
import 'package:pfe_frontend/docteur/models/doctor_api_models.dart';
import 'package:pfe_frontend/patient/screens/partie-consultation/patient_consultation_layout.dart';
import 'package:pfe_frontend/patient/screens/partie-ordonnance/patient_ordonnance_layout.dart';
import 'package:pfe_frontend/patient/screens/partie-reservation/patient_reservation_layout.dart';
import 'package:pfe_frontend/patient/screens/partie_docteurs/patient_search_doctor.dart';


class PatientCustomListScroller extends StatefulWidget {
  final List<Reservation> patientReservations;
  final String? token; 
  const PatientCustomListScroller({ Key? key , required this.patientReservations , required this.token   }) : super(key: key);

  @override
  State<PatientCustomListScroller> createState() => _PatientCustomListScrollerState();
}

class _PatientCustomListScrollerState extends State<PatientCustomListScroller> {

    
  
    void setStateIfMounted(f) {
      if (mounted) setState(f);
    }     
  

     @override
    void initState() {
      super.initState();
    }



  _navigateToResLayout(){
    Navigator.of(context)
    .push(
      MaterialPageRoute(
        builder: (context) => PatientReservationLayout(reservations: widget.patientReservations, token:  widget.token,)
        )
    );
  }
  _navigaterToDoctorSearch(){
    Navigator.of(context)
    .push(
      MaterialPageRoute(
        builder: (context) => PatientSearchDoctor()
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
                onTap: () {
                  _navigaterToDoctorSearch();
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
                        " Docteurs ",
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


class PatientSecondListScroller extends StatefulWidget {
  final List<Consultation> consList ; 
  final List<Ordonnance> ordList ; 
  final String? token;
  const PatientSecondListScroller({ Key? key , required this.consList , required this.ordList , required this.token  }) : super(key: key);

  @override
  State<PatientSecondListScroller> createState() => _PatientSecondListScrollerState();
}

class _PatientSecondListScrollerState extends State<PatientSecondListScroller> {

    
  _navigateToConsultationLayout(){
    Navigator.of(context)
    .push(
      MaterialPageRoute(
        builder: (context) => PatientConsultationLayout(consultations: widget.consList, token: widget.token,)
        )
    );
  }
    _navigateToOrdonnanceLayout(){
    Navigator.of(context)
    .push(
      MaterialPageRoute(
        builder: (context) =>  PatientOrdonnanceLayout(ordonnances: widget.ordList, token: widget.token,)
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
                  _navigateToOrdonnanceLayout();
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


