import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/animation/animation_controller.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/ticker_provider.dart';
import 'package:pfe_frontend/authentication/utils/colors.dart';
import 'package:pfe_frontend/pharmacie/screens/pharmacieHome.dart';
import 'package:pfe_frontend/pharmacie/screens/pharmacie_messages.dart';
import 'package:pfe_frontend/pharmacie/screens/pharmacienProfile.dart';

const pharmacieMobileScreenItems = [
          PharmacieHomeScreen(),
          PharMessages(),
          ProfilePharmacien(),
];


class PharmacieMobileLayout extends StatefulWidget {
  const PharmacieMobileLayout({Key? key}) : super(key: key);

  @override
  State<PharmacieMobileLayout> createState() => _PharmacieMobileLayoutState();
}

class _PharmacieMobileLayoutState extends State<PharmacieMobileLayout>
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
            backgroundColor:AdminColorSix,
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
             children: pharmacieMobileScreenItems,
           ),
         ),
        );
  }
}