import 'package:flutter/material.dart';

class InfermierHome extends StatefulWidget {
  const InfermierHome({ Key? key }) : super(key: key);

  @override
  State<InfermierHome> createState() => _InfermierHomeState();
}

class _InfermierHomeState extends State<InfermierHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     
      body: RefreshIndicator(onRefresh: () async{
        },
        child : Column(
          crossAxisAlignment : CrossAxisAlignment.stretch,
          children : [
            Padding(
              padding:const EdgeInsets.only(top : 10, bottom: 10) ,
              child: Text(' ***** APP INFERMIER ***** '
              , textAlign: TextAlign.center
              ,style: TextStyle(color:Colors.black , fontSize: 25),),
              ),
          ],
        )
      ),
    );
  }
}