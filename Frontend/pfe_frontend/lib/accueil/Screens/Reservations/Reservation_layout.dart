import 'package:flutter/material.dart';
import 'package:pfe_frontend/accueil/Screens/Reservations/all_reservations_list.dart';
import 'package:pfe_frontend/accueil/Screens/Reservations/creer_reservation.dart';
import 'package:pfe_frontend/accueil/models/reservation.dart';
import 'package:pfe_frontend/accueil/utils/api_methods.dart';
import 'package:pfe_frontend/accueil/utils/internet_widgets.dart';
import 'package:pfe_frontend/admin/widget/reservations_list.dart';
import 'package:pfe_frontend/authentication/models/user.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class ReservationLayout extends StatefulWidget {
  final String? token;
  const ReservationLayout({ Key? key , required this.token }) : super(key: key);

  @override
  State<ReservationLayout> createState() => _ReservationLayoutState();
}

class _ReservationLayoutState extends State<ReservationLayout> {

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
    reservationsList = await ApiMethods().getReservationList();
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
              AllReservationList(reservations: reservationsList , token: widget.token ),
              const SizedBox(height: 30),
              ElevatedButton(
                style: style,
                onPressed: () {
                  _navigateToCreateRes();
                },
                child: const Text('Ajouter une nouvelle reservations'),
              ),
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