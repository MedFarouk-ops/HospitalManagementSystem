import 'package:flutter/material.dart';
import 'package:pfe_frontend/accueil/models/reservation.dart';
import 'package:pfe_frontend/authentication/context/authcontext.dart';
import 'package:pfe_frontend/authentication/models/user.dart';
import 'package:pfe_frontend/authentication/utils/colors.dart';
import 'package:pfe_frontend/docteur/models/doctor_api_models.dart';
import 'package:pfe_frontend/patient/utils/patient_api_methods.dart';
import 'package:pfe_frontend/patient/widgets/PatientCustomListScroller.dart';
import 'package:pfe_frontend/patient/widgets/Patient_Today_Reservation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PatientHome extends StatefulWidget {
  const PatientHome({ Key? key }) : super(key: key);

  @override
  State<PatientHome> createState() => _PatientHomeState();
}

class _PatientHomeState extends State<PatientHome> {

    List<Reservation> todayReservations = [];  
    List<Reservation> reservations = [];
    List<Ordonnance> ordonnances = [];
    List<Consultation> consultations = [];
    String? token; 

    _setAuthToken() async {
          SharedPreferences s_prefs = await SharedPreferences.getInstance();
          token = s_prefs.getStringList("authTokens")![0];
          setStateIfMounted(() {});      
    }
    
    void setStateIfMounted(f) {
      if (mounted) setState(f);
    }     
  
    _getReservationList() async {
      User user = await AuthContext().getUserDetails();
      reservations = await PatientApiMethod().getPatientReservationList(user.id);
      todayReservations = await PatientApiMethod().getPatientTodayReservationList(user.id);
      print(todayReservations.length);
      setStateIfMounted(() {});
    }

    _getConsultationList() async {
      User user = await AuthContext().getUserDetails();
      consultations = await PatientApiMethod().getPatientConsList(user.id);
      setStateIfMounted(() {});
    }

    _getOrdonnanceList() async {
      User user = await AuthContext().getUserDetails();
      ordonnances = await PatientApiMethod().getPatientOrdonnanceList(user.id);
      setStateIfMounted(() {});
    }



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
      _setAuthToken();
      _getConsultationList();
      _getOrdonnanceList();
      _getReservationList();
  }


  @override
  Widget build(BuildContext context) {
   final height = MediaQuery.of(context).size.height;
    final Size size = MediaQuery.of(context).size;
    final double categoryHeight = size.height*0.30;
    
    if(reservations.isEmpty){
          return const Scaffold( body : Center(
            child : CircularProgressIndicator(color: AdminColorSix,)
      ),);
    }

    return Scaffold(

      backgroundColor: thirdAdminColor,
      body: SafeArea(
        child: Container(
          height: height,
          child: Stack(
            children: <Widget>[
              Positioned(
                top: -MediaQuery.of(context).size.height * .05,
                right: -MediaQuery.of(context).size.width * .1,
                child: Container(),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                  Column( children: [
                    const SizedBox(height: 8),
                    PatientTodayReservation(reservations: todayReservations , token: token, ),
                    AnimatedOpacity(
                      duration: const Duration(milliseconds: 200),
                      opacity: 1,
                      child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          width: size.width,
                          alignment: Alignment.topCenter,
                          height: categoryHeight*2.4,
                          child: Column(children: [
                           //***************************** */
                           PatientCustomListScroller(patientReservations: reservations ,token: token),
                           PatientSecondListScroller(consList: consultations, ordList: ordonnances , token: token),
                          ],) 
                      )),
                      // const SizedBox(height: 2),
                      ],
                    ),
                  ],
                ),
              ),
            ),
     ],
    ))));
  }
}