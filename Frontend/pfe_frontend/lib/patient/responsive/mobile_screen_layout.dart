import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/animation/animation_controller.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/ticker_provider.dart';
import 'package:pfe_frontend/authentication/utils/colors.dart';
import 'package:pfe_frontend/patient/utils/constants.dart';


class PatientMobileLayout extends StatefulWidget {
  const PatientMobileLayout({Key? key}) : super(key: key);

  @override
  State<PatientMobileLayout> createState() => _PatientMobileLayoutState();
}

class _PatientMobileLayoutState extends State<PatientMobileLayout>
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
      return DefaultTabController(
         length: 3,
         child: Scaffold(
          appBar:  PreferredSize(
          preferredSize: Size.fromHeight(50.0), // here the desired height
          child: AppBar(
            backgroundColor:AdminColorFive,
            //  backgroundColor:thirdAdminColor ,
             automaticallyImplyLeading: false,
             bottom: TabBar(
               tabs: [
                 Tab(text: "Accueil",),
                 Tab(text: "Message",),
                 Tab(text: "Presentation",),
               ],
               ),
           ),),
           body: TabBarView(
             children: patientMobileScreenItems,
           ),
         ),
        );
  }
}