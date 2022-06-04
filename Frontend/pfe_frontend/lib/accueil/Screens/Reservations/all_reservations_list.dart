import 'dart:convert';

import 'package:flutter/src/animation/animation_controller.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/ticker_provider.dart';
import 'package:pfe_frontend/accueil/models/reservation.dart';
import 'package:flutter/material.dart';
import 'package:pfe_frontend/admin/utils/dimensions.dart';
import 'package:pfe_frontend/authentication/models/user.dart';
import 'package:pfe_frontend/authentication/utils/colors.dart';
import 'package:http/http.dart' as http;



class AllReservationList extends StatefulWidget {
  final String? token;
  final List<Reservation> reservations;
  const AllReservationList({Key? key , required this.reservations , required this.token}) : super(key: key);

  @override
  State<AllReservationList> createState() => _AllReservationListState();
}

class _AllReservationListState extends State<AllReservationList>
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
                      Text( " ----------------------------------------------------------------- " , style: TextStyle(fontWeight: FontWeight.bold,),)
                    ],
                  ),
                 ),
                ),
                
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
              if(!widget.reservations.isEmpty)
              for( var i = 0 ; i <widget.reservations.length ; i++ ) 
               DataRow(cells: [
                DataCell(
                  FutureBuilder(future: http.get(Uri.parse("${mobileServerUrl}/adminapp/users/${widget.reservations[i].patient_id}") ,  headers: {'Authorization': 'Bearer ${widget.token}'}) ,
                                builder: (BuildContext context, AsyncSnapshot<http.Response> snapshot){
                                  if (snapshot.hasData) {
                                      if (snapshot.data!.statusCode != 200) {
                                        return Text('Failed to load the data!');
                                      } else {
                                        return Text( User.fromJson(json.decode((snapshot.data!.body))).first_name + " " + User.fromJson(json.decode((snapshot.data!.body))).last_name );
                                      }
                                    } else if (snapshot.hasError) {
                                      return Text('Failed to make a request!');
                                    } else {
                                      return Text('Loading');
                                    }
                                },
                  )
                  
                  ),
                DataCell(
                  FutureBuilder(future: http.get(Uri.parse("${mobileServerUrl}/adminapp/users/${widget.reservations[i].docteur_id}") , headers: {'Authorization': 'Bearer ${widget.token}'} ) ,
                                builder: (BuildContext context, AsyncSnapshot<http.Response> snapshot){
                                  if (snapshot.hasData) {
                                      if (snapshot.data!.statusCode != 200) {
                                        return Text('Failed to load the data!');
                                      } else {
                                        return Text( User.fromJson(json.decode((snapshot.data!.body))).first_name + " " + User.fromJson(json.decode((snapshot.data!.body))).last_name );
                                      }
                                    } else if (snapshot.hasError) {
                                      return Text('Failed to make a request!');
                                    } else {
                                      return Text('Loading');
                                    }
                                },
                  ),
                ),
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