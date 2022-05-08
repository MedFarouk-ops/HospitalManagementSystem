import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pfe_frontend/admin/utils/dimensions.dart';
import 'package:pfe_frontend/authentication/utils/colors.dart';
import 'package:provider/provider.dart';



class AdminMobileScreenLayout extends StatefulWidget {
  const AdminMobileScreenLayout({ Key? key }) : super(key: key);

  @override
  State<AdminMobileScreenLayout> createState() => _AdminMobileScreenLayoutState();
}

class _AdminMobileScreenLayoutState extends State<AdminMobileScreenLayout> {
  int _page = 0 ;
  late PageController pageController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pageController = PageController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    pageController.dispose();
  }

  void navigationTapped(int page){
    pageController.jumpToPage(page);
  }

  void onPageChanged(int page){
    setState(() {
      _page = page;
    });
  }

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
                 Tab(text: "Creer",),
                 Tab(text: "Profile",),
               ]
               ),
           ),),
           body: TabBarView(
             children: homeScreenItems,
           ),
         ),
        );
  }
}
