import 'package:flutter/material.dart';
import 'package:pfe_frontend/accueil/Screens/Reservations/Reservation_layout.dart';
import 'package:pfe_frontend/authentication/utils/colors.dart';

class ReservationList extends StatefulWidget {
  const ReservationList({ Key? key }) : super(key: key);

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
            DataColumn(label: Text("heure")),
          ],
          rows: [
            DataRow(cells: [
              DataCell(Text('Patient1')),
              DataCell(Text('Doctor1')),
              DataCell(Text('"28/02/2022"')),
              DataCell(Text('"16:00"')),
            ]),
            DataRow(cells: [
              DataCell(Text('Patient2')),
              DataCell(Text('Doctor2')),
              DataCell(Text('"28/02/2022"')),
              DataCell(Text('"16:00"')),
            ]),DataRow(cells: [
              DataCell(Text('Patient3')),
              DataCell(Text('Doctor3')),
              DataCell(Text('"28/02/2022"')),
              DataCell(Text('"16:00"')),
            ]),
            DataRow(cells: [
              DataCell(Text('Patient4')),
              DataCell(Text('Doctor4')),
              DataCell(Text('"28/02/2022"')),
              DataCell(Text('"16:00"')),
            ])
          ],),
          ),
          ),
        ],
        ),
        );
  }
}