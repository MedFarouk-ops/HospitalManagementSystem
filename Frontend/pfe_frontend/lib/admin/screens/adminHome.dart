import 'package:flutter/material.dart';
import 'package:pfe_frontend/accueil/models/reservation.dart';
import 'package:pfe_frontend/accueil/utils/api_methods.dart';
import 'package:pfe_frontend/admin/screens/DoctorScreens/doctor_list.dart';
import 'package:pfe_frontend/admin/screens/PatientScreens/patient_list.dart';
import 'package:pfe_frontend/admin/utils/userListScroller.dart';
import 'package:pfe_frontend/admin/widget/reception_activities.dart';
import 'package:pfe_frontend/admin/widget/reservations_list.dart';
import 'package:pfe_frontend/authentication/utils/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AdminHome extends StatefulWidget {
  const AdminHome({ Key? key }) : super(key: key);

  @override
  State<AdminHome> createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {



 // redirection de l'utilisateur : 
 
  _navigateToPatientList(){
    Navigator.of(context)
    .push(
      MaterialPageRoute(
        builder: (context) => const PatientListScreen()
        )
    );
  }
  _navigateToDoctorList(){
    Navigator.of(context)
    .push(
      MaterialPageRoute(
        builder: (context) => const DoctorListScreen()
        )
    );
  }
  // *********************************************//

  // empêcher l'utilisateur de revenir en arriere : 

  ModalRoute<dynamic>? _route;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _route?.removeScopedWillPopCallback(_onWillPop);
    _route = ModalRoute.of(context);
    _route?.addScopedWillPopCallback(_onWillPop);
  }

  @override
  void dispose() {
    _route?.removeScopedWillPopCallback(_onWillPop);
    super.dispose();
  }
  
  Future<bool> _onWillPop() => Future.value(false);

  // ************************************************ // 
  

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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
      _setAuthToken();
      _getReservationList();

  }



  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final Size size = MediaQuery.of(context).size;
    final double categoryHeight = size.height*0.30;
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
                          child: UserListScroller()),
                    ),
                    ReservationList(reservations: reservations , token: token),
                    const SizedBox(height: 16),
                    ReceptionActivityList(),
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