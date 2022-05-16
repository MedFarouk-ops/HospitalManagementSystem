import 'package:flutter/material.dart';
import 'package:pfe_frontend/accueil/Screens/Reservations/creer_reservation.dart';
import 'package:pfe_frontend/accueil/utils/internet_widgets.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class ReservationLayout extends StatefulWidget {
  const ReservationLayout({ Key? key }) : super(key: key);

  @override
  State<ReservationLayout> createState() => _ReservationLayoutState();
}

class _ReservationLayoutState extends State<ReservationLayout> {


  _navigateToCreateRes(){
      Navigator.of(context)
    .push(
      MaterialPageRoute(
        builder: (context) => const CreateReservation()
        // builder: (context) => const FormTestWidget()
        )
    );
  }




  @override
  Widget build(BuildContext context) {
    final ButtonStyle style =
        ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 20));
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
             SfCalendar(
                view : CalendarView.month,allowAppointmentResize: true,
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                style: style,
                onPressed: () {
                  _navigateToCreateRes();
                },
                child: const Text('Creer une nouvelle reservations'),
              ),
      ],)      
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