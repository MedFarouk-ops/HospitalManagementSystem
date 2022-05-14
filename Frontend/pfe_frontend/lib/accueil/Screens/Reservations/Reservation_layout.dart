import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class ReservationLayout extends StatefulWidget {
  const ReservationLayout({ Key? key }) : super(key: key);

  @override
  State<ReservationLayout> createState() => _ReservationLayoutState();
}

class _ReservationLayoutState extends State<ReservationLayout> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SfCalendar(
        view : CalendarView.month
      ),
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