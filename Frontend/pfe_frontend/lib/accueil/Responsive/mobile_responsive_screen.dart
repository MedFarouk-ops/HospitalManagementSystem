import 'package:flutter/material.dart';
import 'package:pfe_frontend/accueil/utils/constants.dart';

class AccueilMobileScreenLayout extends StatefulWidget {
  const AccueilMobileScreenLayout({ Key? key }) : super(key: key);

  @override
  State<AccueilMobileScreenLayout> createState() => _AccueilMobileScreenLayoutState();
}

class _AccueilMobileScreenLayoutState extends State<AccueilMobileScreenLayout> {

  // *********************************************//

  // empêcher l'utilisateur de revenir en arriere : 

  ModalRoute<dynamic>? _route;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _route?.removeScopedWillPopCallback(_onWillPop);
    _route = ModalRoute.of(context);
    _route?.addScopedWillPopCallback(_onWillPop);
  }

  @override
  void dispose() {
    _route?.removeScopedWillPopCallback(_onWillPop);
    super.dispose();
  }
  
  Future<bool> _onWillPop() => Future.value(false);

  // ************************************************ // 

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
         length: 2,
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