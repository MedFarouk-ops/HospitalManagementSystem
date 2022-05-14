import 'package:flutter/material.dart';
import 'package:pfe_frontend/authentication/utils/colors.dart';


class ReceptionActivityList extends StatefulWidget {
  const ReceptionActivityList({ Key? key }) : super(key: key);

  @override
  State<ReceptionActivityList> createState() => _ReceptionActivityListState();
}

class _ReceptionActivityListState extends State<ReceptionActivityList> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 2, horizontal: 2),
      decoration: BoxDecoration(color : activityWidgetColor , borderRadius: BorderRadius.all(Radius.circular(8.0)) ),
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
                      Text( "Activités Recentes : " , style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),)
                    ],
                  ),
                 ),
                ),
                IconButton(onPressed: () {
                  showDialog(
                    context: context, builder: (context) => Dialog(
                      child: ListView(
                        padding: const EdgeInsets.symmetric(vertical:16 ,),
                        shrinkWrap: true,
                        children: [
                          "Voir tous les activités",
                        ].map((e) => InkWell(
                          onTap: () {},
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              vertical: 4,horizontal: 16
                            ),
                            child: Text(e  , style: TextStyle(color: Color.fromARGB(255, 0, 0, 0))),
                          ),
                        )).toList(),
                        ),
                      ),
                    );
                }, icon: Icon(Icons.more_vert ,color: Color.fromARGB(255, 0, 0, 0)),),
              ],
              ),
          ),
        // Reservation Table Section : 
        SingleChildScrollView(
         scrollDirection: Axis.vertical,
          child: FittedBox(
            child:DataTable(
          columns: [
            DataColumn(label:  Text( "Nom" , style: TextStyle(color: Colors.white),)),
            DataColumn(label:  Text( "Activités : " , style: TextStyle(color: Colors.white),)),
            DataColumn(label:  Text( "Heure" , style: TextStyle(color: Colors.white),)),
          ],
          rows: [
            DataRow(cells: [
              DataCell(Text('Reception1' , style: TextStyle(color: Colors.white),)),
              DataCell(Text('supprimer un patient' , style: TextStyle(color: Colors.white),)),
              DataCell(Text('16:00' , style: TextStyle(color: Colors.white),)),
            ]),
            DataRow(cells: [
              DataCell(Text('Reception2', style: TextStyle(color: Colors.white),)),
              DataCell(Text('ajouter un patient', style: TextStyle(color: Colors.white),)),
              DataCell(Text('16:00' , style: TextStyle(color: Colors.white),)),
            ]),DataRow(cells: [
              DataCell(Text('Reception1' , style: TextStyle(color: Colors.white),)),
              DataCell(Text('annuler une reservations', style: TextStyle(color: Colors.white),)),
              DataCell(Text('16:00' , style: TextStyle(color: Colors.white),)),
            ]),
          ],),
          ),
          ),
        ],
        ),
        );
  }
}