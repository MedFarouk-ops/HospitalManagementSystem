import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/animation/animation_controller.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/ticker_provider.dart';
import 'package:http/http.dart' as http;
import 'package:pfe_frontend/admin/utils/dimensions.dart';
import 'package:pfe_frontend/authentication/context/authcontext.dart';
import 'package:pfe_frontend/authentication/models/user.dart';
import 'package:pfe_frontend/authentication/utils/colors.dart';
import 'package:pfe_frontend/docteur/screens/partie_ordonnance/voir_detail_ordonnance.dart';
import 'package:pfe_frontend/docteur/utils/constant.dart';
import 'package:pfe_frontend/docteur/utils/doctor_api_methods.dart';
import 'package:pfe_frontend/docteur/widgets/datetime_card.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PharmacieHomeScreen extends StatefulWidget {
  const PharmacieHomeScreen({Key? key}) : super(key: key);

  @override
  State<PharmacieHomeScreen> createState() => _PharmacieHomeScreenState();
}

class _PharmacieHomeScreenState extends State<PharmacieHomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  List ordonnances = [];
   String? token; 

    _setAuthToken() async {
          SharedPreferences s_prefs = await SharedPreferences.getInstance();
          token = s_prefs.getStringList("authTokens")![0];
          setStateIfMounted(() {});      
    }

     
    void setStateIfMounted(f) {
      if (mounted) setState(f);
    }     
    
    _getOrdonnanceList() async {
      User user = await AuthContext().getUserDetails();
      ordonnances = await DoctorApiMethods().getOrdonnanceList();
      setStateIfMounted(() {});
    }


  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
    _setAuthToken();
    _getOrdonnanceList();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if(ordonnances.isEmpty){
          return const Scaffold( body : Center(
            child : CircularProgressIndicator(color: AdminColorSix,)
      ),);
    }

   return Scaffold(
      appBar: AppBar(
        backgroundColor: AdminColorSix,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(
              'Liste des tout les ordonnances',
              textAlign: TextAlign.center,
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
          (ordonnances.isEmpty) ?
               Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("aucune ordonnance trouvée" , style: TextStyle(color: AdminColorSix ),)
                 ],)     
         : Expanded(
              child: ListView.builder(
                itemCount: ordonnances.length,
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
                                  FutureBuilder(future: http.get(Uri.parse("${mobileServerUrl}/adminapp/users/${ordonnances[index].patient_id}") , headers: {'Authorization': 'Bearer ${token}'}) ,
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
                                    "Diagnostic : " +ordonnances[index].description ?? "",
                                    style: TextStyle(
                                      color: Color(MyColors.grey02),
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ), 
                                ],
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: ElevatedButton(
                                  style:  ElevatedButton.styleFrom(
                                          primary: Colors.green,
                                          padding: EdgeInsets.symmetric(horizontal: 50, vertical: 5),),
                                  child: Text('Voir Details'),
                                  onPressed: () => {
                                     Navigator.of(context)
                                    .push(
                                      MaterialPageRoute(
                                        builder: (context) => VoirDetailsOrdonnance(ordonnance: ordonnances[index], token: token)
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
    );
  }
}
