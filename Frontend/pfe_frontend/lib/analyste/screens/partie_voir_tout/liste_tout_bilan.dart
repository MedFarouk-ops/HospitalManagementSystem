import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/animation/animation_controller.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/src/widgets/ticker_provider.dart';
import 'package:pfe_frontend/accueil/utils/api_methods.dart';
import 'package:pfe_frontend/admin/utils/dimensions.dart';
import 'package:pfe_frontend/analyste/screens/partie_creation_bilan/creer_bilan.dart';
import 'package:pfe_frontend/analyste/screens/partie_details/bilan_details.dart';
import 'package:pfe_frontend/analyste/utils/analyste_api_methods.dart';
import 'package:pfe_frontend/authentication/context/authcontext.dart';
import 'package:pfe_frontend/authentication/models/user.dart';
import 'package:pfe_frontend/authentication/utils/colors.dart';
import 'package:pfe_frontend/docteur/models/doctor_api_models.dart';
import 'package:pfe_frontend/docteur/utils/constant.dart';

class BilansListe extends StatefulWidget {
  final String? token ;
  const BilansListe({Key? key , required this.token }) : super(key: key);

  @override
  State<BilansListe> createState() => _BilansListeState();
}

class _BilansListeState extends State<BilansListe>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  List<Analyse> analyses = [];  
  List<User> _patients = [];
  List<User> _docteurs = [];

  // Hemato = 1
  // Bioch  = 2
  // Microb = 3
  // Anatomo = 4
  final int _type = 4; // Anatomo

    void setStateIfMounted(f) {
      if (mounted) setState(f);
    }

    _setUsers() async {
      _patients = await ApiMethods().getPatients();
      _docteurs = await ApiMethods().getDoctors();
      setStateIfMounted(() {});
    }

    _getAnalyses() async {
      User currentuser = await AuthContext().getUserDetails();
      analyses = await AnalysteApiMethods().getAnalysesByAnalysteId(currentuser.id);
    } 

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _setUsers();
    _getAnalyses();
  }

  _navigateToCreateAnalyse(){
    Navigator.of(context)
    .push(
      MaterialPageRoute(
        builder: (context) => CreerBilan(typeBilan: _type , docteurslist: _docteurs, patientslist: _patients)
        // builder: (context) => const FormTestWidget()
        )
    );
          setStateIfMounted(() {});

  }
  

  @override
  Widget build(BuildContext context) {
    if(_patients.isEmpty){
          return const Scaffold( body : Center(
            child : CircularProgressIndicator(color: AdminColorSeven,)
      ),);
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AdminColorSeven,
        centerTitle: true,
        title: Text(
              'Tout les bilans',
              textAlign: TextAlign.start,
              style: kTitleStyle2,
            ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 30, top: 30, right: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 20,
            ),
          if(analyses.isEmpty)
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("aucun bilan trouvé" , style: TextStyle(color: AdminColorSeven ),)
                 ],),
                 
            Expanded(
              child: ListView.builder(
                itemCount: analyses.length,
                itemBuilder: (context, index) {
                  return Card(
                    margin:  EdgeInsets.zero,
                    child: Padding(
                      padding: EdgeInsets.all(15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                backgroundImage: NetworkImage('https://www.business2community.com/wp-content/uploads/2017/08/blank-profile-picture-973460_640.png'),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  FutureBuilder(future: http.get(Uri.parse("${mobileServerUrl}/adminapp/users/${analyses[index].patient_id}") ,  headers: {'Authorization': 'Bearer ${widget.token}'}) ,
                                    builder: (BuildContext context, AsyncSnapshot<http.Response> snapshot){
                                    if (snapshot.hasData) {
                                        if (snapshot.data!.statusCode != 200) {
                                          return Text('Failed to load the data!' , style : TextStyle(
                                      color: Color(MyColors.grey02),
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                    ),);
                                        } else {
                                          return Text( User.fromJson(json.decode((snapshot.data!.body))).first_name + " " + User.fromJson(json.decode((snapshot.data!.body))).last_name  ,style: TextStyle(
                                      color: Color(MyColors.header01),
                                      fontWeight: FontWeight.w700,
                                    ), );
                                        }
                                      } else if (snapshot.hasError) {
                                        return Text('Failed to make a request!' , style: TextStyle(
                                      color: Color(MyColors.header01),
                                      fontWeight: FontWeight.w700,
                                    ));
                                      } else {
                                        return Text('Loading' ,  style: TextStyle(
                                      color: Color(MyColors.header01),
                                      fontWeight: FontWeight.w700,
                                    ));
                                      }
                                    },
                                  ),

                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    "Description : " +analyses[index].description ?? "",
                                    style: TextStyle(
                                      color: Color(MyColors.grey02),
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ), 
                                  SizedBox(
                                    height: 5,
                                  ),
                                  (analyses[index].type == 1) ? Text(
                                    "Type : " +  "Hematologie",
                                    style: TextStyle(
                                      color: Color(MyColors.grey02),
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ) :
                                  (analyses[index].type == 2) ? Text(
                                    "Type : " +  "Biochimie",
                                    style: TextStyle(
                                      color: Color(MyColors.grey02),
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ) :
                                  (analyses[index].type == 3) ? Text(
                                    "Type : " +  "Microbiologie",
                                    style: TextStyle(
                                      color: Color(MyColors.grey02),
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ) : 
                                  Text(
                                    "Type : " +  "Anatomopathologie",
                                    style: TextStyle(
                                      color: Color(MyColors.grey02),
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),

                            

                                   FutureBuilder(future: http.get(Uri.parse("${mobileServerUrl}/adminapp/users/${analyses[index].docteur_id}") ,  headers: {'Authorization': 'Bearer ${widget.token}'}) ,
                                    builder: (BuildContext context, AsyncSnapshot<http.Response> snapshot){
                                    if (snapshot.hasData) {
                                        if (snapshot.data!.statusCode != 200) {
                                          return Text('Failed to load the data!' , style : TextStyle(
                                      color: Color(MyColors.grey02),
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                    ),);
                                        } else {
                                          return Text( "medecin : " + User.fromJson(json.decode((snapshot.data!.body))).first_name + " " + User.fromJson(json.decode((snapshot.data!.body))).last_name  ,style: TextStyle(
                                      color: Color(MyColors.grey02),
                                      fontWeight: FontWeight.w500,
                                    ), );
                                        }
                                      } else if (snapshot.hasError) {
                                        return Text('Failed to make a request!' , style: TextStyle(
                                      color: Color(MyColors.grey02),
                                      fontWeight: FontWeight.w500,
                                    ));
                                      } else {
                                        return Text('Loading' ,  style: TextStyle(
                                      color: Color(MyColors.grey02),
                                      fontWeight: FontWeight.w500,
                                    ));
                                      }
                                    },
                                  ), 
                                ],
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          // ConsultationCard(consultation: analyses[index],),
                          SizedBox(
                            height: 15,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: ElevatedButton(
                                  style:  ElevatedButton.styleFrom(
                                          primary: AdminColorSeven,
                                          padding: EdgeInsets.symmetric(horizontal: 50, vertical: 5),),
                                  child: Text('Voir plus de details'),
                                  onPressed: () => {
                                    Navigator.of(context)
                                    .push(
                                      MaterialPageRoute(
                                        builder: (context) => VoirBilan(bilan: analyses[index], token: widget.token)
                                        // builder: (context) => const FormTestWidget()
                                        )
                                    ),
                                  },
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
           
          ],
        ),
      ),
    );
  }
}

