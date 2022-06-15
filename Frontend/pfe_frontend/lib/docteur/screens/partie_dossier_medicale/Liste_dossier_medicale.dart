import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/animation/animation_controller.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/ticker_provider.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:pfe_frontend/accueil/utils/api_methods.dart';
import 'package:pfe_frontend/admin/utils/dimensions.dart';
import 'package:pfe_frontend/authentication/models/user.dart';
import 'package:pfe_frontend/authentication/utils/colors.dart';
import 'package:pfe_frontend/docteur/models/doctor_api_models.dart';
import 'package:pfe_frontend/docteur/screens/partie_dossier_medicale/creer_dossier_medicale.dart';
import 'package:pfe_frontend/docteur/screens/partie_dossier_medicale/voir_details_dossier_medicale.dart';
import 'package:pfe_frontend/docteur/utils/constant.dart';
import 'package:pfe_frontend/docteur/widgets/datetime_card.dart';

class ListeRapportMedicale extends StatefulWidget {
  final List<RapportMedical> rapports ; 
  final String? token ; 

  const ListeRapportMedicale({Key? key , required this.rapports , required this.token}) : super(key: key);

  @override
  State<ListeRapportMedicale> createState() => _ListeRapportMedicaleState();
}

class _ListeRapportMedicaleState extends State<ListeRapportMedicale>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  List<User> _patients = [];
    void setStateIfMounted(f) {
      if (mounted) setState(f);
    }

    _setUsers() async {
      _patients = await ApiMethods().getPatients();
      setStateIfMounted(() {});
    }
  

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
    _setUsers();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  _navigateToCreateRapport(){
     Navigator.of(context)
    .push(
      MaterialPageRoute(
        builder: (context) =>  CreerRapportMedicale(patientslist: _patients)
        )
    );
  }

  @override
  Widget build(BuildContext context) {
 
   return Scaffold(
      appBar: AppBar(
        backgroundColor: AdminColorSix,
        centerTitle: true,
        title: Text(
              'Liste des Rapports medicales',
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
          (widget.rapports.isEmpty) ?
               Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("aucun rapport trouvée" , style: TextStyle(color: AdminColorSix ),)
                 ],)     
         : Expanded(
              child: ListView.builder(
                itemCount: widget.rapports.length,
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
                                  FutureBuilder(future: http.get(Uri.parse("${mobileServerUrl}/adminapp/users/${widget.rapports[index].patient_id}") , headers: {'Authorization': 'Bearer ${widget.token}',}) ,
                                    builder: (BuildContext context, AsyncSnapshot<http.Response> snapshot){
                                    if (snapshot.hasData) {
                                        if (snapshot.data!.statusCode != 200) {
                                          print("tooooooooooooookeeen : " + widget.token.toString());
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
                                    "Description : " +widget.rapports[index].description ?? "",
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
                          RapportMedicaleCard(rapport: widget.rapports[index],),
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
                                        builder: (context) => VoirDetailRapportMedicale(rapport: widget.rapports[index], token: widget.token , patientslist: _patients,)
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
       floatingActionButton : Container(
              width: MediaQuery.of(context).size.width * 0.70,
              decoration: BoxDecoration(
                borderRadius:  BorderRadius.circular(20.0),
              ),
              child: FloatingActionButton.extended(
                backgroundColor: AdminColorSix,
                onPressed: (){
                  _navigateToCreateRapport();
                },
                elevation: 0,
                label: Text(
                  "Ajouter un rapport medicale",
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
