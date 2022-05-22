import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/animation/animation_controller.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/ticker_provider.dart';
import 'package:pfe_frontend/accueil/Screens/Reservations/Reservation_layout.dart';
import 'package:pfe_frontend/accueil/models/reservation.dart';
import 'package:pfe_frontend/admin/utils/dimensions.dart';
import 'package:pfe_frontend/authentication/models/user.dart';
import 'package:pfe_frontend/authentication/utils/colors.dart';
import 'package:http/http.dart' as http;
import 'package:pfe_frontend/docteur/screens/partie_reservations/doctor_reservation_layout.dart';

class TodayReservationLayout extends StatefulWidget {
  final List<Reservation> reservations;
  const TodayReservationLayout({Key? key , required this.reservations}) : super(key: key);

  @override
  State<TodayReservationLayout> createState() => _TodayReservationLayoutState();
}

class _TodayReservationLayoutState extends State<TodayReservationLayout>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }


  _navigateToReservations(){
    Navigator.of(context)
    .push(
      MaterialPageRoute(
        builder: (context) =>  DoctorReservationLayout()
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
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text( "Rendez vous d'aujourd'hui : " , style: TextStyle(fontWeight: FontWeight.bold , fontSize: 20 ),)
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
            DataColumn(label: Text("Patient" , style: TextStyle(fontSize: 18),)),
            DataColumn(label: Text("debut" , style: TextStyle(fontSize: 18),)),
            DataColumn(label: Text("fin" , style: TextStyle(fontSize: 18),)),
          ] ,
          rows: [

            if(!(widget.reservations.isEmpty)&&(widget.reservations.length >=4))
              for( var i = 0 ; i < 4; i++ ) 
               DataRow(cells: [
                DataCell(
                  FutureBuilder(future: http.get(Uri.parse("${mobileServerUrl}/adminapp/users/${widget.reservations[i].patient_id}")) ,
                                builder: (BuildContext context, AsyncSnapshot<http.Response> snapshot){
                                  if (snapshot.hasData) {
                                      if (snapshot.data!.statusCode != 200) {
                                        return Text('Failed to load the data!' , style: TextStyle(fontSize: 18));
                                      } else {
                                        return Text( User.fromJson(json.decode((snapshot.data!.body))).first_name + " " + User.fromJson(json.decode((snapshot.data!.body))).last_name  , style: TextStyle(fontSize: 18));
                                      }
                                    } else if (snapshot.hasError) {
                                      return Text('Failed to make a request!' ,style: TextStyle(fontSize: 18));
                                    } else {
                                      return Text('Chargement ...' , style: TextStyle(fontSize: 18));
                                    }
                                },
                ),),
                DataCell(Text(widget.reservations[i].startTime.substring(0,5) , style: TextStyle(fontSize: 18))),
                DataCell(Text(widget.reservations[i].endTime.substring(0,5) , style: TextStyle(fontSize: 18) )),
              ],),

              if(!(widget.reservations.isEmpty)&&(widget.reservations.length <4))
              
                for( var i = 0 ; i <widget.reservations.length ; i++ ) 
                DataRow(cells: [
                    DataCell(
                    FutureBuilder(future: http.get(Uri.parse("${mobileServerUrl}/adminapp/users/${widget.reservations[i].patient_id}")) ,
                                    builder: (BuildContext context, AsyncSnapshot<http.Response> snapshot){
                                      if (snapshot.hasData) {
                                          if (snapshot.data!.statusCode != 200) {
                                            return Text('Failed to load the data!' ,style: TextStyle(fontSize: 18));
                                          } else {
                                            return Text( User.fromJson(json.decode((snapshot.data!.body))).first_name + " " + User.fromJson(json.decode((snapshot.data!.body))).last_name , style: TextStyle(fontSize: 18) );
                                          }
                                        } else if (snapshot.hasError) {
                                          return Text('Failed to make a request!' , style: TextStyle(fontSize: 18));
                                        } else {
                                          return Text('Chargement ...' ,style: TextStyle(fontSize: 18));
                                        }
                                    },
                          ),
                      ),
                    DataCell(Text(widget.reservations[i].startTime.substring(0,5) , style: TextStyle(fontSize: 18))),
                    DataCell(Text(widget.reservations[i].endTime.substring(0,5) ,  style: TextStyle(fontSize: 18))),
                  ]),
                  
          ],),
          ),
          ),
        ],
        ),
        );
  }
}