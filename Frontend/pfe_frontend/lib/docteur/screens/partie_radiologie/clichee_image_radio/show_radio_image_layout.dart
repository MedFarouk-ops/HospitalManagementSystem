import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/animation/animation_controller.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/ticker_provider.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:http/http.dart' as http;
import 'package:pfe_frontend/admin/utils/dimensions.dart';
import 'package:pfe_frontend/analyste/utils/analyste_api_methods.dart';
import 'package:pfe_frontend/authentication/models/user.dart';
import 'package:pfe_frontend/authentication/utils/colors.dart';
import 'package:pfe_frontend/docteur/models/doctor_api_models.dart';
import 'package:pfe_frontend/docteur/utils/constant.dart';
import 'package:pfe_frontend/docteur/utils/doctor_api_methods.dart';

class VoirDetailsRadio extends StatefulWidget {
  final Ordonnance ordonnance ; 
  final String? token;
  const VoirDetailsRadio({Key? key , required this.ordonnance , required this.token}) : super(key: key);

  @override
  State<VoirDetailsRadio> createState() => VoirDetailsRadioState();
}

class VoirDetailsRadioState extends State<VoirDetailsRadio>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  String localPath = "";
  Ordonnance? ord ;

   void setStateIfMounted(f) {
  if (mounted) setState(f);
}

_loadPdf(String pdfUrl){
    AnalysteApiMethods.loadPDF(pdfUrl).then((value) {
      setState(() {
        localPath = value;
      });
    });
}

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
    return Scaffold(
      appBar: AppBar(
        title: Text("Details sur l'ordonnance"),
        backgroundColor: AdminColorSeven,
      ),
      body: localPath != ""
          ? PDFView(
              filePath: localPath,
            )
          :
      SingleChildScrollView(
      child: RefreshIndicator(onRefresh: () async{
        //  _setUsers();
        },
        child : Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          
          Divider(),
        

          SizedBox( // <-- SEE HERE
            width: 400,
            height: 60,
            child:Column(children: [
              Text( "Diagnostic : " , style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600,),),
              Text( widget.ordonnance.description ,style: TextStyle(fontSize: 20,fontWeight: FontWeight.w400,) )
            ],)
          ),


          Divider(),

          SizedBox( // <-- SEE HERE
            width: 400,
            height: 40,
            child:Column(children: [
              FutureBuilder(future: http.get(Uri.parse("${mobileServerUrl}/adminapp/users/${widget.ordonnance.patient_id}") , headers: {'Authorization': 'Bearer ${widget.token}'}) ,
                                    builder: (BuildContext context, AsyncSnapshot<http.Response> snapshot){
                                    if (snapshot.hasData) {
                                        if (snapshot.data!.statusCode != 200) {
                                          return Text('Failed to load the data!' , style : TextStyle(
                                      color: Colors.black,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600,
                                    ),);
                                        } else {
                                          return Text( "Patient : " + User.fromJson(json.decode((snapshot.data!.body))).first_name + " " + User.fromJson(json.decode((snapshot.data!.body))).last_name  ,style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500,
                                    ), );
                                        }
                                      } else if (snapshot.hasError) {
                                        return Text('Failed to make a request!' , style: TextStyle(
                                      color: Color(MyColors.header01),
                                      fontWeight: FontWeight.w600,
                                    ));
                                      } else {
                                        return Text('Loading' ,  style: TextStyle(
                                      color: Color(MyColors.grey02),
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600,
                                    ),);
                                      }
                                    },
              ),
            ],)
          ),


          SizedBox( // <-- SEE HERE
            width: 400,
            height: 40,
            child:Column(children: [
              FutureBuilder(future: http.get(Uri.parse("${mobileServerUrl}/adminapp/users/${widget.ordonnance.docteur_id}") , headers: {'Authorization': 'Bearer ${widget.token}'}) ,
                                    builder: (BuildContext context, AsyncSnapshot<http.Response> snapshot){
                                    if (snapshot.hasData) {
                                        if (snapshot.data!.statusCode != 200) {
                                          return Text('Failed to load the data!' , style : TextStyle(
                                      color: Color(MyColors.grey02),
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600,
                                    ),);
                                        } else {
                                          return Text("Docteur : " +  User.fromJson(json.decode((snapshot.data!.body))).first_name + " " + User.fromJson(json.decode((snapshot.data!.body))).last_name  ,style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500,
                                    ), );
                                        }
                                      } else if (snapshot.hasError) {
                                        return Text('Failed to make a request!' , style: TextStyle(
                                      color: Color(MyColors.header01),
                                      fontWeight: FontWeight.w600,
                                    ));
                                      } else {
                                        return Text('Loading' ,  style: TextStyle(
                                      color: Color(MyColors.grey02),
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600,
                                    ),);
                                      }
                                    },
              ),
            ],)
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: ElevatedButton(
                                  style:  ElevatedButton.styleFrom(
                                          primary: AdminColorSeven,
                                          padding: EdgeInsets.symmetric(horizontal: 50, vertical: 5),),
                                  child: Text("Voir l'ordonnance pdf "),
                                  onPressed: () => {
                                    _loadPdf(widget.ordonnance.donnees)
                                  },
                                ),
                              )
                            ],
                          )
        ]))),
    );
  }
}