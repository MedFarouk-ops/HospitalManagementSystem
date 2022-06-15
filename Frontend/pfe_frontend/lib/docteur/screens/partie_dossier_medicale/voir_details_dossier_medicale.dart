import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/animation/animation_controller.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/ticker_provider.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:pfe_frontend/admin/utils/dimensions.dart';
import 'package:pfe_frontend/admin/widget/button_widget.dart';
import 'package:pfe_frontend/analyste/screens/partie_details/afficher_pdf.dart';
import 'package:pfe_frontend/analyste/utils/analyste_api_methods.dart';
import 'package:pfe_frontend/authentication/models/user.dart';
import 'package:pfe_frontend/authentication/utils/colors.dart';
import 'package:pfe_frontend/docteur/models/doctor_api_models.dart';
import 'package:pfe_frontend/docteur/responsive/mobile_layout_screen.dart';
import 'package:pfe_frontend/docteur/screens/docteurHome.dart';
import 'package:pfe_frontend/docteur/screens/partie_dossier_medicale/update-rapport.dart';
import 'package:pfe_frontend/docteur/utils/constant.dart';
import 'dart:io' show Platform;

class VoirDetailRapportMedicale extends StatefulWidget {
  final List<User> patientslist;
  final RapportMedical rapport ;
  final String? token;
  const VoirDetailRapportMedicale({Key? key ,  required this.rapport , required this.token , required this.patientslist}) : super(key: key);

  @override
  State<VoirDetailRapportMedicale> createState() => _VoirDetailRapportMedicaleState();
}

class _VoirDetailRapportMedicaleState extends State<VoirDetailRapportMedicale>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  String localPath = "";
  RapportMedical? ord ;
  Client client = http.Client();

  

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

_navigateToPDFViex( String pdf){
  _loadPdf(pdf);
  if(localPath != ""){
   Navigator.of(context)
    .push(
      MaterialPageRoute(
        builder: (context) => VoirPDF(localPath: localPath,)
        )
    );
    setStateIfMounted(() {});
  }
}


  void showDialog()
  {
   showCupertinoDialog(
     context: context,
     builder: (context) {
       return AlertDialog(
         title: Text("Supprimer Rapport"),
         content: Text("Êtes-vous sûr de vouloir supprimer ce rapport?"),
         actions: [
           CupertinoDialogAction(
               child: Text("Oui"),
               onPressed: ()
               {
                 _deleteUser(widget.rapport.id);
               }
           ),
           CupertinoDialogAction(
             child: Text("Non"),
             onPressed: (){
               Navigator.of(context).pop();
             }
             ,
           )
         ],
       );
     },
   );
 }
  void _deleteUser(int id){
    String apiServerUrl = "";
    if (kIsWeb) {apiServerUrl = serverUrl ; }
    else if(Platform.isAndroid) { apiServerUrl = mobileServerUrl ; }
    String deleteUrl = "$apiServerUrl/api/rapport-medicale/delete/"+id.toString()+"/";
    client.delete(Uri.parse(deleteUrl) ,headers: {'Authorization': 'Bearer ${widget.token}',} );
    _returnToDashboard();
  }

  _returnToDashboard(){
        Navigator.of(context)
        .push(
          MaterialPageRoute(
            builder: (context) => DoctorMobileResponiveLayout()
            )
        );
    }

    _navigateToEditPage(){
        Navigator.of(context)
        .push(
          MaterialPageRoute(
            builder: (context) => ModifierRapport(patientslist: widget.patientslist, rapport: widget.rapport,)
            )
        );
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
        title: Text("Details sur le rapport medicale"),
        backgroundColor: AdminColorSix,
      ),
      body:
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
              Text( "Description de rapport : " , style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600,),),
              Text( widget.rapport.description ,style: TextStyle(fontSize: 20,fontWeight: FontWeight.w400,) )
            ],)
          ),


          Divider(),

          SizedBox( // <-- SEE HERE
            width: 400,
            height: 40,
            child:Column(children: [
              FutureBuilder(future: http.get(Uri.parse("${mobileServerUrl}/adminapp/users/${widget.rapport.patient_id}") , headers: {'Authorization': 'Bearer ${widget.token}'}) ,
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
              FutureBuilder(future: http.get(Uri.parse("${mobileServerUrl}/adminapp/users/${widget.rapport.docteur_id}") , headers: {'Authorization': 'Bearer ${widget.token}'}) ,
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
                              SecondButtonWidget(
                                  text: 'voir pdf',
                                  onClicked: () { _navigateToPDFViex(widget.rapport.donnees); },
                                ),
                              Divider(),
                              SecondButtonWidget(
                                  text: 'modifier',
                                  onClicked: () {
                                    _navigateToEditPage();
                                  },
                                ),
                              Divider(),
                              SecondButtonWidget(
                                  text: 'supprimer',
                                  onClicked: () {
                                     showDialog();
                                  },
                                ),
                            ],
                          )
        ]))),
    );
  }
}