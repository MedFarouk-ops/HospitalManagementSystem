import 'dart:convert';

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
import 'package:pfe_frontend/docteur/models/doctor_api_models.dart';
import 'package:pfe_frontend/docteur/utils/constant.dart';
import 'package:pfe_frontend/radiologue/utils/radiologue_api.dart';

class ClicheeRadioLayout extends StatefulWidget {
  final  List<RadioData> radios;  
  final String? token;
  const ClicheeRadioLayout({Key? key , required this.radios , required this.token}) : super(key: key);

  @override
  State<ClicheeRadioLayout> createState() => _ClicheeRadioLayoutState();
}

class _ClicheeRadioLayoutState extends State<ClicheeRadioLayout>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
    
    void setStateIfMounted(f) {
      if (mounted) setState(f);
    }

  


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
     if(widget.radios.isEmpty){
           return const Scaffold( body : Center(
             child : CircularProgressIndicator(color: AdminColorSix,)
       ),);
     }

    return Scaffold(
    appBar: AppBar(
        backgroundColor: AdminColorSix,
        centerTitle: true,
        title: Text(
              'Clichés des images radio',
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
          if(widget.radios.isEmpty)
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("aucun image radio trouvé" , style: TextStyle(color: AdminColorSix ),)
                 ],),
                 
            Expanded(
              child: ListView.builder(
                itemCount: widget.radios.length,
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
                                  FutureBuilder(future: http.get(Uri.parse("${mobileServerUrl}/adminapp/users/${widget.radios[index].patient_id}") , headers: {'Authorization': 'Bearer ${widget.token}'}) ,
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
                                    "  description : " +widget.radios[index].description ?? "",
                                    style: TextStyle(
                                      color: Color(MyColors.grey02),
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ), 

                                  SizedBox(
                                    height: 5,
                                  ),
                                   FutureBuilder(future: http.get(Uri.parse("${mobileServerUrl}/adminapp/users/${widget.radios[index].docteur_id}") ,  headers: {'Authorization': 'Bearer ${widget.token}',}) ,
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
                                  //  FutureBuilder(future: http.get(Uri.parse("${mobileServerUrl}/adminapp/users/${widget.radios[index].analyste_id}")) ,
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
                                          primary: AdminColorSix,
                                          padding: EdgeInsets.symmetric(horizontal: 50, vertical: 5),),
                                  child: Text('Voir plus de details'),
                                  onPressed: () => {},
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
