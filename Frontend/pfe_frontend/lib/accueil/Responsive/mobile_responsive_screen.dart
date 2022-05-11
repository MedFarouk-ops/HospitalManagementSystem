import 'package:flutter/material.dart';
import 'package:pfe_frontend/accueil/utils/constants.dart';

class AccueilMobileScreenLayout extends StatefulWidget {
  const AccueilMobileScreenLayout({ Key? key }) : super(key: key);

  @override
  State<AccueilMobileScreenLayout> createState() => _AccueilMobileScreenLayoutState();
}

class _AccueilMobileScreenLayoutState extends State<AccueilMobileScreenLayout> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
         length: 3,
         child: Scaffold(
          appBar:  PreferredSize(
          preferredSize: Size.fromHeight(50.0), // here the desired height
          child: AppBar(
            //  backgroundColor:thirdAdminColor ,
             automaticallyImplyLeading: false,
             bottom: TabBar(
               tabs: [
                 Tab(text: "Accueil",),
                 Tab(text: "Profile",),
               ]
               ),
           ),),
           body: TabBarView(
             children: accueilScreenItems,
           ),
         ),
        );
  }
}