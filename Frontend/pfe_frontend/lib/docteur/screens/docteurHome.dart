import 'package:flutter/material.dart';

class DocteurHome extends StatefulWidget {
  const DocteurHome({ Key? key }) : super(key: key);

  @override
  State<DocteurHome> createState() => _DocteurHomeState();
}

class _DocteurHomeState extends State<DocteurHome> {
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
              child: Text(' ***** APP DOCTEUR ***** '
              , textAlign: TextAlign.center
              ,style: TextStyle(color:Colors.black , fontSize: 25),),
              ),
          ],
        )
      ),
    );
  }
}