import 'package:flutter/material.dart';
import 'package:pfe_frontend/accueil/utils/accueilUserListScroller.dart';
import 'package:pfe_frontend/admin/utils/userListScroller.dart';
import 'package:pfe_frontend/admin/widget/reservations_list.dart';
import 'package:pfe_frontend/authentication/utils/colors.dart';

class AccueilHome extends StatefulWidget {
  const AccueilHome({ Key? key }) : super(key: key);

  @override
  State<AccueilHome> createState() => _AccueilHomeState();
}

class _AccueilHomeState extends State<AccueilHome> {

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final Size size = MediaQuery.of(context).size;
    final double categoryHeight = size.height*0.30;
    return Scaffold(
      backgroundColor: thirdAdminColor,
      body: SafeArea(
        child: Container(
          height: height,
          child: Stack(
            children: <Widget>[
              Positioned(
                top: -MediaQuery.of(context).size.height * .05,
                right: -MediaQuery.of(context).size.width * .1,
                child: Container(),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                  Column( children: [
                    AnimatedOpacity(
                      duration: const Duration(milliseconds: 200),
                      opacity: 1,
                      child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          width: size.width,
                          alignment: Alignment.topCenter,
                          height: categoryHeight,
                          child: AccueilUserListScroller()),
                    ),
                    
                      ReservationList(),
                    
                      const SizedBox(height: 16),
                      ],
                      ),
                      ]
                    )
                  )
                ),
     ],
    ))));
  }
}