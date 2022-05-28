import 'package:flutter/material.dart';
import 'package:pfe_frontend/accueil/models/reservation.dart';
import 'package:pfe_frontend/accueil/utils/api_methods.dart';
import 'package:pfe_frontend/admin/widget/reservations_list.dart';
import 'package:pfe_frontend/authentication/context/authcontext.dart';
import 'package:pfe_frontend/authentication/models/user.dart';
import 'package:pfe_frontend/authentication/utils/colors.dart';
import 'package:pfe_frontend/docteur/models/doctor_api_models.dart';
import 'package:pfe_frontend/docteur/utils/doctor_api_methods.dart';
import 'package:pfe_frontend/docteur/widgets/DoctorCustomListScroller.dart';
import 'package:pfe_frontend/docteur/widgets/Reservation_Today.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DocteurHome extends StatefulWidget {
  const DocteurHome({ Key? key }) : super(key: key);

  @override
  State<DocteurHome> createState() => _DocteurHomeState();
}

class _DocteurHomeState extends State<DocteurHome> {

    List<Reservation> todayReservations = [];  
    List<Reservation> reservations = [];  
    List<Ordonnance> ordonnances = [];
    List<Consultation> consultations = [];
  
    void setStateIfMounted(f) {
      if (mounted) setState(f);
    }     
  
    _getReservationList() async {
      User user = await AuthContext().getUserDetails();
      reservations = await DoctorApiMethods().getDoctorReservationList(user.id);
      todayReservations = await DoctorApiMethods().getDoctorTodayReservationList(user.id);
      print(todayReservations.length);
      setStateIfMounted(() {});
    }

    _getConsultationList() async {
      User user = await AuthContext().getUserDetails();
      consultations = await DoctorApiMethods().getDoctorConsList(user.id);
      setStateIfMounted(() {});
    }

    _getOrdonnanceList() async {
      User user = await AuthContext().getUserDetails();
      ordonnances = await DoctorApiMethods().getDoctorOrdonnanceList(user.id);
      setStateIfMounted(() {});
    }



    @override
    void initState() {
      // TODO: implement initState
      super.initState();
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
                    TodayReservationLayout(reservations: todayReservations ),
                    AnimatedOpacity(
                      duration: const Duration(milliseconds: 200),
                      opacity: 1,
                      child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          width: size.width,
                          alignment: Alignment.topCenter,
                          height: categoryHeight*2.4,
                          child: Column(children: [
                            DoctorCustomListScroller(doctorReservations: reservations),
                            DoctorSecondListScroller(consList: consultations , ordList: ordonnances),
                            DoctorThirdListScroller(),
                            DoctorFourthListScroller()
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