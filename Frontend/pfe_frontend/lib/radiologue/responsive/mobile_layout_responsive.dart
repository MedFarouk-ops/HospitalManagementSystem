import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/animation/animation_controller.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/ticker_provider.dart';
import 'package:pfe_frontend/authentication/utils/colors.dart';
import 'package:pfe_frontend/radiologue/screens/radiologue_home.dart';
import 'package:pfe_frontend/radiologue/widgets/radiologue_profile.dart';

const radiosMobileScreenItems = [
          RadiologueHomePage(),
          RadioProfile(),
];



class RadiologueMobileLayout extends StatefulWidget {
  const RadiologueMobileLayout({Key? key}) : super(key: key);

  @override
  State<RadiologueMobileLayout> createState() => _RadiologueMobileLayoutState();
}

class _RadiologueMobileLayoutState extends State<RadiologueMobileLayout>
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
         length: 2,
         child: Scaffold(
          appBar:  PreferredSize(
          preferredSize: Size.fromHeight(50.0), // here the desired height
          child: AppBar(
            backgroundColor:AdminColorNine,
            //  backgroundColor:thirdAdminColor ,
             automaticallyImplyLeading: false,
             bottom: TabBar(
               tabs: [
                 Tab(text: "Accueil", ),
                 Tab(text: "Presentation",),
               ],
               ),
           ),),
           body: TabBarView(
             children: radiosMobileScreenItems,
           ),
         ),
        );
  }
}