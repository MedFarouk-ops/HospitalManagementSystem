import 'package:flutter/material.dart';

class PatientHome extends StatefulWidget {
  const PatientHome({ Key? key }) : super(key: key);

  @override
  State<PatientHome> createState() => _PatientHomeState();
}

class _PatientHomeState extends State<PatientHome> {
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
              child: Text(' ***** APP PATIENT ***** '
              , textAlign: TextAlign.center
              ,style: TextStyle(color:Colors.black ,fontSize: 25),),
              ),
          ],
        )
      ),
    );
  }
}