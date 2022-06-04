import 'package:flutter/material.dart';
import 'package:flutter/src/animation/animation_controller.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/ticker_provider.dart';
import 'package:pfe_frontend/analyste/screens/partie_anatomo/liste_anatomo.dart';
import 'package:pfe_frontend/analyste/screens/partie_biochimie/list_biochemie.dart';
import 'package:pfe_frontend/analyste/screens/partie_hematologie/list_hematologie.dart';
import 'package:pfe_frontend/analyste/screens/partie_microbiologie/list_microbilogie.dart';
import 'package:pfe_frontend/analyste/screens/partie_voir_tout/liste_tout_bilan.dart';
import 'package:pfe_frontend/authentication/utils/colors.dart';

class AnalysteCustomListScroller extends StatefulWidget {
  final String? token;
  const AnalysteCustomListScroller({Key? key , required this.token}) : super(key: key);

  @override
  State<AnalysteCustomListScroller> createState() => _AnalysteCustomListScrollerState();
}

class _AnalysteCustomListScrollerState extends State<AnalysteCustomListScroller>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
 void setStateIfMounted(f) {
      if (mounted) setState(f);
    }     
  
    @override
    void initState() {
      super.initState();
    }

  _navigateToHemaLayout(){
    Navigator.of(context)
    .push(
      MaterialPageRoute(
        builder: (context) => HematologieListLayout(token: widget.token,)
        )
    );
  
  }

  
  _navigateToBiochemieLayout(){
    Navigator.of(context)
    .push(
      MaterialPageRoute(
        builder: (context) => BiochemieListLayout(token: widget.token,)
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    final double categoryHeight = MediaQuery.of(context).size.height * 0.30 - 50;
    double screenWidth = MediaQuery.of(context).size.width;
    double miniWidgetWidth = screenWidth/2 - 15 ; 
    double miniWidgetHeight = categoryHeight/2 +5 ; 


// # Hématologie
// # Biochimie
// # Microbiologie
// # Anatomopathologie

    return Container(
      child:  SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      scrollDirection: Axis.horizontal,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 2),
        child: FittedBox(
          fit: BoxFit.fill,
          alignment: Alignment.topCenter,
          child: Row(
            children: <Widget>[
              InkWell(
                onTap: () {
                  _navigateToHemaLayout();
                },
                child: Container(
                width: miniWidgetWidth,
                margin: EdgeInsets.only(right: 20 , left: 2),
                height: miniWidgetHeight,
                decoration: BoxDecoration(color:AdminColorSeven, borderRadius: BorderRadius.all(Radius.circular(8.0)) ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        " Hématologie",
                        style: TextStyle(fontSize: 22, color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "",
                        style: TextStyle(fontSize: 16, color: Color.fromARGB(255, 255, 254, 254)),
                      ),
                    ],
                  ),
                ),
              ),),
              Divider(),
              
              InkWell(
                onTap: () {
                  _navigateToBiochemieLayout();
                },
                child: Container(
                width: miniWidgetWidth,
                margin: EdgeInsets.only(right: 20 , left: 2),
                height: miniWidgetHeight,
                decoration: BoxDecoration(color:AdminColorSeven, borderRadius: BorderRadius.all(Radius.circular(8.0)) ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        " Biochimie",
                        style: TextStyle(fontSize: 22, color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 1,
                      ),
                      Text(
                        " ",
                        style: TextStyle(fontSize: 16, color: Color.fromARGB(255, 255, 254, 254)),
                      ),
                    ],
                  ),
                ),
              ),),
              
            ],
          ),
        ),
      ),),
    );
  }
}








class AnalysteSecondListScroller extends StatefulWidget {
  final String? token;
  const AnalysteSecondListScroller({Key? key , required this.token}) : super(key: key);

  @override
  State<AnalysteSecondListScroller> createState() => _AnalysteSecondListScrollerState();
}

class _AnalysteSecondListScrollerState extends State<AnalysteSecondListScroller>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
 void setStateIfMounted(f) {
      if (mounted) setState(f);
    }     
  

     @override
    void initState() {
      super.initState();
    }



  _navigateToMicroBioLayout(){
    Navigator.of(context)
    .push(
      MaterialPageRoute(
        builder: (context) => MicrobiologieListLayout(token: widget.token,)
        )
    );
  }

  _navigateToListeBilan(){
    Navigator.of(context)
    .push(
      MaterialPageRoute(
        builder: (context) => BilansListe(token: widget.token ,)
        )
    );
  }


  

  @override
  Widget build(BuildContext context) {
    final double categoryHeight = MediaQuery.of(context).size.height * 0.30 - 50;
    double screenWidth = MediaQuery.of(context).size.width;
    double miniWidgetWidth = screenWidth/2 - 15 ; 
    double miniWidgetHeight = categoryHeight/2 +5 ; 

    // # Hématologie
// # Biochimie
// # Microbiologie
// # Anatomopathologie

    return Container(
      child:  SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      scrollDirection: Axis.horizontal,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 2),
        child: FittedBox(
          fit: BoxFit.fill,
          alignment: Alignment.topCenter,
          child: Row(
            children: <Widget>[
              InkWell(
                onTap: () {
                  _navigateToMicroBioLayout();
                },
                child: Container(
                width: miniWidgetWidth,
                margin: EdgeInsets.only(right: 20 , left: 2),
                height: miniWidgetHeight,
                decoration: BoxDecoration(color:AdminColorSeven, borderRadius: BorderRadius.all(Radius.circular(8.0)) ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        " Microbiologie",
                        style: TextStyle(fontSize: 22, color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "",
                        style: TextStyle(fontSize: 16, color: Color.fromARGB(255, 255, 254, 254)),
                      ),
                    ],
                  ),
                ),
              ),),
              Divider(),
              
              InkWell(
                onTap: () {
                  _navigateToListeBilan();
                },
                child: Container(
                width: miniWidgetWidth,
                margin: EdgeInsets.only(right: 20 , left: 2),
                height: miniWidgetHeight,
                decoration: BoxDecoration(color:AdminColorSeven, borderRadius: BorderRadius.all(Radius.circular(8.0)) ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        " voir tout",
                        style: TextStyle(fontSize: 22, color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 1,
                      ),
                      Text(
                        " ",
                        style: TextStyle(fontSize: 16, color: Color.fromARGB(255, 255, 254, 254)),
                      ),
                    ],
                  ),
                ),
              ),),
              
            ],
          ),
        ),
      ),),
    );
  }
}





class AnalysteThirdListScroller extends StatefulWidget {
  final String? token;
  const AnalysteThirdListScroller({Key? key , required this.token}) : super(key: key);

  @override
  State<AnalysteThirdListScroller> createState() => _AnalysteThirdListScrollerState();
}

class _AnalysteThirdListScrollerState extends State<AnalysteThirdListScroller>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
 void setStateIfMounted(f) {
      if (mounted) setState(f);
    }     
  

     @override
    void initState() {
      super.initState();
    }



  _navigateToAnatomoLayout(){
     Navigator.of(context)
    .push(
      MaterialPageRoute(
        builder: (context) => AnatomopathListLayout(token: widget.token,)
        )
    );
  }



  @override
  Widget build(BuildContext context) {
    final double categoryHeight = MediaQuery.of(context).size.height * 0.30 - 50;
    double screenWidth = MediaQuery.of(context).size.width;
    double miniWidgetWidth = screenWidth/2 - 15 ; 
    double miniWidgetHeight = categoryHeight/2 +5 ; 

    // # Hématologie
// # Biochimie
// # Microbiologie
// # Anatomopathologie

    return Container(
      child:  SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      scrollDirection: Axis.horizontal,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 2),
        child: FittedBox(
          fit: BoxFit.fill,
          alignment: Alignment.topCenter,
          child: Row(
            children: <Widget>[             
              InkWell(
                onTap: () {
                  _navigateToAnatomoLayout();
                },
                child: Container(
                width: miniWidgetWidth*2.1,
                margin: EdgeInsets.only(right: 20 , left: 2),
                height: miniWidgetHeight,
                decoration: BoxDecoration(color:AdminColorSeven, borderRadius: BorderRadius.all(Radius.circular(8.0)) ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        " Anatomopathologie",
                        style: TextStyle(fontSize: 22, color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 1,
                      ),
                      Text(
                        " ",
                        style: TextStyle(fontSize: 16, color: Color.fromARGB(255, 255, 254, 254)),
                      ),
                    ],
                  ),
                ),
              ),),
              
            ],
          ),
        ),
      ),),
    );
  }
}

