import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/animation/animation_controller.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/ticker_provider.dart';
import 'package:http/http.dart' as http;
import 'package:pfe_frontend/accueil/utils/api_methods.dart';
import 'package:pfe_frontend/admin/utils/dimensions.dart';
import 'package:pfe_frontend/authentication/context/authcontext.dart';
import 'package:pfe_frontend/authentication/models/user.dart';
import 'package:pfe_frontend/authentication/utils/colors.dart';
import 'package:pfe_frontend/docteur/models/doctor_api_models.dart';
import 'package:pfe_frontend/docteur/utils/constant.dart';
import 'package:pfe_frontend/radiologue/screens/partie_radio/creer_radio.dart';
import 'package:pfe_frontend/radiologue/screens/partie_radio/voir_radio.dart';
import 'package:pfe_frontend/radiologue/utils/radiologue_api.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RadiologueHomePage extends StatefulWidget {
  const RadiologueHomePage({Key? key}) : super(key: key);

  @override
  State<RadiologueHomePage> createState() => _RadiologueHomePageState();
}

class _RadiologueHomePageState extends State<RadiologueHomePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

 
  List<RadioData> radios = [];  
  List<User> _patients = [];
  List<User> _docteurs = [];

     String? token; 

    _setAuthToken() async {
          SharedPreferences s_prefs = await SharedPreferences.getInstance();
          token = s_prefs.getStringList("authTokens")![0];
          setStateIfMounted(() {});      
    }


    void setStateIfMounted(f) {
      if (mounted) setState(f);
    }

    _setUsers() async {
      _patients = await ApiMethods().getPatients();
      _docteurs = await ApiMethods().getDoctors();
      setStateIfMounted(() {});
    }

    _getRadios() async {
      User currentuser = await AuthContext().getUserDetails();
      radios = await RadioApiMethods().getRadiosByRadiologueId(currentuser.id);
    } 


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _setAuthToken();
    _getRadios();
    _setUsers();
  }

  _navigateToCreateAnalyse(){
    Navigator.of(context)
    .push(
      MaterialPageRoute(
        builder: (context) => CreerRadio( docteurslist: _docteurs , patientslist: _patients,)
        // builder: (context) => const FormTestWidget()
        )
    );
          setStateIfMounted(() {});

  }
  

  @override
  Widget build(BuildContext context) {
     if(_patients.isEmpty){
           return const Scaffold( body : Center(
             child : CircularProgressIndicator(color: AdminColorNine,)
       ),);
     }

    return Scaffold(
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
          if(radios.isEmpty)
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("aucun image radio trouvé" , style: TextStyle(color: AdminColorNine ),)
                 ],),
                 
            Expanded(
              child: ListView.builder(
                itemCount: radios.length,
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
                                  FutureBuilder(future: http.get(Uri.parse("${mobileServerUrl}/adminapp/users/${radios[index].patient_id}") , headers: {'Authorization': 'Bearer ${token}'}) ,
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
                                    "  description : " +radios[index].description ?? "",
                                    style: TextStyle(
                                      color: Color(MyColors.grey02),
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ), 

                                  SizedBox(
                                    height: 5,
                                  ),
                                   FutureBuilder(future: http.get(Uri.parse("${mobileServerUrl}/adminapp/users/${radios[index].docteur_id}") , headers: {'Authorization': 'Bearer ${token}'}) ,
                                    builder: (BuildContext context, AsyncSnapshot<http.Response> snapshot){
                                    if (snapshot.hasData) {
                                        if (snapshot.data!.statusCode != 200) {
                                          return Text('Failed to load the data!' , style : TextStyle(
                                      color: Color(MyColors.grey02),
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                    ),);
                                        } else {
                                          return Text( "  medecin : " + User.fromJson(json.decode((snapshot.data!.body))).first_name + " " + User.fromJson(json.decode((snapshot.data!.body))).last_name  ,style: TextStyle(
                                      color: Color(MyColors.grey02),
                                      fontSize: 12,
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
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                    ),);
                                      }
                                    },
                                  ),
                                   SizedBox(
                                    height: 5,
                                  ),
                                  //  FutureBuilder(future: http.get(Uri.parse("${mobileServerUrl}/adminapp/users/${radios[index].analyste_id}")) ,
                                  //   builder: (BuildContext context, AsyncSnapshot<http.Response> snapshot){
                                  //   if (snapshot.hasData) {
                                  //       if (snapshot.data!.statusCode != 200) {
                                  //         return Text('Failed to load the data!' , style : TextStyle(
                                  //     color: Color(MyColors.grey02),
                                  //     fontSize: 12,
                                  //     fontWeight: FontWeight.w600,
                                  //   ),);
                                  //       } else {
                                  //         return Text( "  analyste : " + User.fromJson(json.decode((snapshot.data!.body))).first_name + " " + User.fromJson(json.decode((snapshot.data!.body))).last_name  ,style: TextStyle(
                                  //     color: Color(MyColors.grey02),
                                  //     fontSize: 12,
                                  //     fontWeight: FontWeight.w500,
                                  //   ), );
                                  //       }
                                  //     } else if (snapshot.hasError) {
                                  //       return Text('Failed to make a request!' , style: TextStyle(
                                  //     color: Color(MyColors.header01),
                                  //     fontWeight: FontWeight.w600,
                                  //   ));
                                  //     } else {
                                  //       return Text('Loading' ,  style: TextStyle(
                                  //     color: Color(MyColors.grey02),
                                  //     fontSize: 12,
                                  //     fontWeight: FontWeight.w600,
                                  //   ),);
                                  //     }
                                  //   },
                                  // ),
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
                                          primary: AdminColorNine,
                                          padding: EdgeInsets.symmetric(horizontal: 50, vertical: 5),),
                                  child: Text('Voir plus de details'),
                                  onPressed: () => {
                                     Navigator.of(context)
                                    .push(
                                      MaterialPageRoute(
                                        builder: (context) => VoirDetailsRadioRadilogue(radio: radios[index], token: token)
                                        )
                                    )
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
       floatingActionButton : Container(
              width: MediaQuery.of(context).size.width * 0.70,
              decoration: BoxDecoration(
                borderRadius:  BorderRadius.circular(20.0),
              ),
              child: FloatingActionButton.extended(
                backgroundColor: AdminColorNine,
                onPressed: (){
                  _navigateToCreateAnalyse();
                },
                elevation: 0,
                label: Text(
                  "Ajouter une nouvelle image radio ",
                  style: TextStyle(
                    fontSize: 13.0
                  ),
                ),
              ),
            ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}


