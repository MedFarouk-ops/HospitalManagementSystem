import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/animation/animation_controller.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/ticker_provider.dart';
import 'package:pfe_frontend/accueil/models/reservation.dart';
import 'package:http/http.dart' as http;
import 'package:pfe_frontend/admin/utils/dimensions.dart';
import 'package:pfe_frontend/authentication/models/user.dart';
import 'package:pfe_frontend/authentication/utils/colors.dart';
import 'package:pfe_frontend/docteur/utils/constant.dart';
import 'package:pfe_frontend/docteur/widgets/datetime_card.dart';

class PatientReservationLayout extends StatefulWidget {
  final List<Reservation> reservations ;
  const PatientReservationLayout({Key? key , required this.reservations}) : super(key: key);

  @override
  State<PatientReservationLayout> createState() => _PatientReservationLayoutState();
}

class _PatientReservationLayoutState extends State<PatientReservationLayout>
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
  return Scaffold(
      appBar: AppBar(
        backgroundColor: AdminColorSix,
        centerTitle: true,
        title: Text(
              'Liste de Reservations',
              textAlign: TextAlign.center,
              style: kTitleStyle2,
            ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 30, top: 30, right: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: 20,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: widget.reservations.length,
                itemBuilder: (context, index) {
                  return Card(
                    margin:  EdgeInsets.zero,
                    child: Padding(
                      padding: EdgeInsets.all(15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                backgroundImage: NetworkImage('https://www.business2community.com/wp-content/uploads/2017/08/blank-profile-picture-973460_640.png'),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                   FutureBuilder(future: http.get(Uri.parse("${mobileServerUrl}/adminapp/users/${widget.reservations[index].docteur_id}")) ,
                                  builder: (BuildContext context, AsyncSnapshot<http.Response> snapshot){
                                  if (snapshot.hasData) {
                                      if (snapshot.data!.statusCode != 200) {
                                        return Text('Failed to load the data!');
                                      } else {
                                        return Text( "   " + User.fromJson(json.decode((snapshot.data!.body))).first_name + " " + User.fromJson(json.decode((snapshot.data!.body))).last_name );
                                      }
                                    } else if (snapshot.hasError) {
                                      return Text('Failed to make a request!');
                                    } else {
                                      return Text('Loading');
                                    }
                                  },
                                )
                                   ,
                                  SizedBox(
                                    height: 5,
                                  ),
                                  
                                  FutureBuilder(future: http.get(Uri.parse("${mobileServerUrl}/adminapp/users/${widget.reservations[index].docteur_id}")) ,
                                    builder: (BuildContext context, AsyncSnapshot<http.Response> snapshot){
                                    if (snapshot.hasData) {
                                        if (snapshot.data!.statusCode != 200) {
                                          return Text('Failed to load the data!' , style : TextStyle(
                                      color: Color(MyColors.grey02),
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                    ),);
                                        } else {
                                          return Text( "    " + User.fromJson(json.decode((snapshot.data!.body))).mobilenumber ,style : TextStyle(
                                      color: Color(MyColors.grey02),
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                    ), );
                                        }
                                      } else if (snapshot.hasError) {
                                        return Text('Failed to make a request!');
                                      } else {
                                        return Text('Loading');
                                      }
                                    },
                                  ),

                                ],
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 15,
                          ),
                         
                          DateTimeCard(Date: widget.reservations[index].dateRendezvous, starttime: widget.reservations[index].startTime.substring(0,5), endtime: widget.reservations[index].endTime.substring(0,5)),
                          
                          SizedBox(
                            height: 15,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: ElevatedButton(
                                  style:  ElevatedButton.styleFrom(
                                          primary: Colors.green,
                                          padding: EdgeInsets.symmetric(horizontal: 50, vertical: 5),),
                                  child: Text('Voir Details'),
                                  onPressed: () => {},
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
           
          ],
        ),
      ),
    );
  }
  
}
