import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/animation/animation_controller.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/ticker_provider.dart';
import 'package:pfe_frontend/analyste/utils/constant.dart';
import 'package:pfe_frontend/authentication/utils/colors.dart';

class AnalysteMobileLayout extends StatefulWidget {
  const AnalysteMobileLayout({Key? key}) : super(key: key);

  @override
  State<AnalysteMobileLayout> createState() => _AnalysteMobileLayoutState();
}

class _AnalysteMobileLayoutState extends State<AnalysteMobileLayout>
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
            backgroundColor:AdminColorSeven,
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
             children: analysteMobileScreenItems,
           ),
         ),
        );
  }
}

// # Hématologie
// # Biochimie
// # Microbiologie
// # Anatomopathologie
