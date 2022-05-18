import 'package:flutter/material.dart';
import 'package:pfe_frontend/accueil/Screens/Reservations/Reservation_layout.dart';
import 'package:pfe_frontend/accueil/models/reservation.dart';
import 'package:pfe_frontend/accueil/utils/api_methods.dart';
import 'package:pfe_frontend/authentication/utils/colors.dart';

class ReservationList extends StatefulWidget {
  final List<Reservation> reservations;
  final List<UserFullNames> names ;
  const ReservationList({ Key? key , required this.reservations ,required this.names }) : super(key: key);

  @override
  State<ReservationList> createState() => _ReservationListState();
}

class _ReservationListState extends State<ReservationList> {
  
  
  _navigateToReservations(){
    Navigator.of(context)
    .push(
      MaterialPageRoute(
        builder: (context) => const ReservationLayout()
        )
    );
  }
  
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 2, horizontal: 2),
      decoration: BoxDecoration(color : primaryColor , borderRadius: BorderRadius.all(Radius.circular(8.0)) ),
      padding: const EdgeInsets.symmetric(
        vertical: 10
      ),
      child : Column(
        children: [
          // Header Section : 
          Container(
            padding: const EdgeInsets.symmetric(
              vertical: 4,
              horizontal: 16,
            ).copyWith(right: 0),
            child: Row(
              children: [
                Expanded(
                  child: Padding(
                  padding: const EdgeInsets.only(left: 8,),
                  child : Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text( "Reservations Recentes : " , style: TextStyle(fontWeight: FontWeight.bold,),)
                    ],
                  ),
                 ),
                ),
                IconButton(onPressed: () {
                  showDialog(
                    context: context, builder: (context) => Dialog(
                      child: ListView(
                        padding: const EdgeInsets.symmetric(vertical:16 ),
                        shrinkWrap: true,
                        children: [
                          "Voir tous les reservations",
                        ].map((e) => InkWell(
                          onTap: () {
                            _navigateToReservations();
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              vertical: 12,horizontal: 16
                            ),
                            child: Text(e),
                          ),
                        )).toList(),
                        ),
                      ),
                    );
                }, icon: Icon(Icons.more_vert),),
              ],
              ),
          ),
        // Reservation Table Section : 
        SingleChildScrollView(
         scrollDirection: Axis.vertical,
          child: FittedBox(
            child:DataTable(
          columns: [
            DataColumn(label: Text("Patient")),
            DataColumn(label: Text("Docteur")),
            DataColumn(label: Text("Date")),
            DataColumn(label: Text("heure debut")),
            DataColumn(label: Text("heure fin")),
          ] ,
          rows: [
            if((!widget.reservations.isEmpty)&&(!widget.names.isEmpty))
              for( var i = 0 ; i < 4; i++ ) 
               DataRow(cells: [
                DataCell(Text(widget.names[i].patientfullname)),
                DataCell(Text(widget.names[i].doctorfullname)),
                DataCell(Text(widget.reservations[i].dateRendezvous)),
                DataCell(Text(widget.reservations[i].startTime.substring(0,5))),
                DataCell(Text(widget.reservations[i].startTime.substring(0,5))),
              ]),
            
          ],),
          ),
          ),
        ],
        ),
        );
  }
}