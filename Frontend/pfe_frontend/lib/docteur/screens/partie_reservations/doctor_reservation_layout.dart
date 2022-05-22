import 'package:flutter/material.dart';
import 'package:pfe_frontend/accueil/Screens/Reservations/all_reservations_list.dart';
import 'package:pfe_frontend/accueil/Screens/Reservations/creer_reservation.dart';
import 'package:pfe_frontend/accueil/models/reservation.dart';
import 'package:pfe_frontend/accueil/utils/api_methods.dart';
import 'package:pfe_frontend/accueil/utils/internet_widgets.dart';
import 'package:pfe_frontend/admin/widget/reservations_list.dart';
import 'package:pfe_frontend/authentication/context/authcontext.dart';
import 'package:pfe_frontend/authentication/models/user.dart';
import 'package:pfe_frontend/authentication/utils/colors.dart';
import 'package:pfe_frontend/docteur/utils/doctor_api_methods.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class DoctorReservationLayout extends StatefulWidget {
  const DoctorReservationLayout({ Key? key }) : super(key: key);

  @override
  State<DoctorReservationLayout> createState() => _DoctorReservationLayoutState();
}

class _DoctorReservationLayoutState extends State<DoctorReservationLayout> {

    List<User> _patients = [];
    List<User> _docteurs = [];

    void setStateIfMounted(f) {
      if (mounted) setState(f);
    }

    _setUsers() async {
      _patients = await ApiMethods().getPatients();
      _docteurs = await ApiMethods().getDoctors();
      setStateIfMounted(() {});
    }

     List<Reservation> reservationsList = [];


    _getReservationList() async {
    User user = await AuthContext().getUserDetails();
    print(user.first_name);
    reservationsList = await DoctorApiMethods().getDoctorReservationList(user.id);
    setStateIfMounted(() {});
  }




    @override
    void initState(){
      super.initState();
      _setUsers();
      _getReservationList();
    }

  _navigateToCreateRes(){
      Navigator.of(context)
    .push(
      MaterialPageRoute(
        builder: (context) => CreateReservation(docteurslist: _docteurs,patientslist: _patients,)

        // builder: (context) => const FormTestWidget()
        )
    );
          setStateIfMounted(() {});
  }




  @override
  Widget build(BuildContext context) {
    final ButtonStyle style =
        ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 20));
    if(_docteurs.isEmpty){
          return const Scaffold( body : Center(
            child : CircularProgressIndicator()
      ),);
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AdminColorSix,
        
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
             const SizedBox(height: 30),
             Text("Tous les reservations :",maxLines: 20, style: TextStyle(fontSize: 16.0 ,fontWeight:FontWeight.bold,color: Colors.black) , ),

             const SizedBox(height: 30),
            //  SfCalendar(
            //     view : CalendarView.month,allowAppointmentResize: true,
            //   ),
              AllReservationList(reservations: reservationsList),
              const SizedBox(height: 30),
              // ElevatedButton(
              //   style: style,
              //   onPressed: () {
              //     _navigateToCreateRes();
              //   },
              //   child: const Text('Ajouter une nouvelle reservations'),
              // ),
      ],) ,
    );
  }
}

// List<Appointment> getAppointments(){
//   List<Appointment> reservations = <Appointment> [];
//   final DateTime today = DateTime.now();
//   return reservations ; 
// }

// class ReservationsDataSource extends CalendarDataSource{
//   ReservationsDataSource(List<Appointment> source){
//     appointments = source ;
//   }
// }