import 'package:flutter/material.dart';

class AdminHome extends StatefulWidget {
  const AdminHome({ Key? key }) : super(key: key);

  @override
  State<AdminHome> createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(),
        elevation: 0,
        backgroundColor: Colors.lightBlue,
      ),
      body: RefreshIndicator(onRefresh: () async{
        },
        child : Column(
          crossAxisAlignment : CrossAxisAlignment.stretch,
          children : [
            Padding(
              padding:const EdgeInsets.only(top : 10, bottom: 10) ,
              child: Text(' ***** APP ADMIN ***** '
              , textAlign: TextAlign.center
              ,style: TextStyle(color:Colors.black , fontSize: 25),),
              ),
          ],
        )
      ),
    );
  }
}