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
     return Scaffold(
      body:PageView(
        children: homeScreenItems,
        physics: const NeverScrollableScrollPhysics(),
        controller: pageController,
        onPageChanged: onPageChanged,
      ),
      bottomNavigationBar: CupertinoTabBar(
        height: 30,
        backgroundColor: thirdAdminColor,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home ,
            color: _page == 0 ? Color.fromARGB(255, 19, 191, 62) : secondaryColor,
            ),
            label: '',
            backgroundColor: primaryColor,
            ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_circle,
            color: _page == 1 ? Color.fromARGB(255, 19, 191, 62)  : secondaryColor,
            ),
            label: '',
            backgroundColor: primaryColor,
            ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person,
            color: _page == 2 ? Color.fromARGB(255, 19, 191, 62)  : secondaryColor,
            ),
            label: '',
            backgroundColor: primaryColor,
            ),
        ],
        onTap: navigationTapped,
        ),
    );
  }
}

  