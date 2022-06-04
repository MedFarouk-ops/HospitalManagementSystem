import 'package:flutter/material.dart';
import 'package:pfe_frontend/accueil/models/reservation.dart';
import 'package:pfe_frontend/accueil/utils/accueilUserListScroller.dart';
import 'package:pfe_frontend/accueil/utils/api_methods.dart';
import 'package:pfe_frontend/admin/utils/userListScroller.dart';
import 'package:pfe_frontend/admin/widget/reservations_list.dart';
import 'package:pfe_frontend/authentication/models/user.dart';
import 'package:pfe_frontend/authentication/utils/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';


class AccueilHome extends StatefulWidget {
  const AccueilHome({ Key? key }) : super(key: key);

  @override
  State<AccueilHome> createState() => _AccueilHomeState();
}

class _AccueilHomeState extends State<AccueilHome> {
  

    int? _numberOfDoctor;
    int? _numberOfPatient;
    List<User> _patientList = [];
    List<User> _doctorList = [];
    List<Reservation> reservations = [];

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
    reservations = await ApiMethods().getReservationList();
    setStateIfMounted(() {});
  }

    

    _setUsers() async {
      _patientList = await ApiMethods().getPatients();
      _doctorList = await ApiMethods().getDoctors();
      final prefs = await SharedPreferences.getInstance(); 
      prefs.setInt("NumberOfpatients", _patientList.length);
      prefs.setInt("NumberOfdoctors", _doctorList.length);
      setStateIfMounted(() {});
    }

    _setUserNumber() async {
      final prefs = await SharedPreferences.getInstance(); 
      _numberOfPatient = prefs.getInt("NumberOfpatients");
      _numberOfDoctor = prefs.getInt("NumberOfdoctors");
    }

    @override
    void initState() {
      // TODO: implement initState
      super.initState();
      _setAuthToken();
      _setUsers();
      _setUserNumber();
      _getReservationList();
    }


  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final Size size = MediaQuery.of(context).size;
    final double categoryHeight = size.height*0.30;
    
    
    if(reservations.isEmpty){
          return const Scaffold( body : Center(
            child : CircularProgressIndicator()
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
                    AnimatedOpacity(
                      duration: const Duration(milliseconds: 200),
                      opacity: 1,
                      child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          width: size.width,
                          alignment: Alignment.topCenter,
                          height: categoryHeight,
                          child: AccueilUserListScroller(
                            doctorList: _doctorList,
                            numberOfDoctor: _numberOfDoctor ?? 0,
                            numberOfPatient: _numberOfPatient ?? 0,
                            patientList: _patientList,
                            )),
                    ),
                      ReservationList(reservations: reservations , token: token),
                      const SizedBox(height: 16),
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