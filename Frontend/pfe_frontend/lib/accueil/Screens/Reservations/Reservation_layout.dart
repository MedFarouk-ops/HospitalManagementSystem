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
        view : CalendarView.week
      ),
    );
  }
}