import 'package:flutter/material.dart';
import 'package:pfe_frontend/accueil/models/reservation.dart';
import 'package:pfe_frontend/accueil/utils/internet_widgets.dart';
import 'package:pfe_frontend/authentication/context/authcontext.dart';
import 'package:pfe_frontend/authentication/models/user.dart';
import 'package:pfe_frontend/authentication/utils/colors.dart';
import 'package:pfe_frontend/docteur/models/doctor_api_models.dart';
import 'package:pfe_frontend/docteur/screens/partie_consultations/cree_consultation.dart';
import 'package:pfe_frontend/docteur/screens/partie_consultations/patient_selections/patient_select_type.dart';
import 'package:pfe_frontend/docteur/utils/constant.dart';
import 'package:pfe_frontend/docteur/utils/doctor_api_methods.dart';

class ConsultationLayout extends StatefulWidget {
  const ConsultationLayout({Key? key}) : super(key: key);

  @override
  State<ConsultationLayout> createState() => _ConsultationLayoutState();
}

class _ConsultationLayoutState extends State<ConsultationLayout> {
  FilterStatus status = FilterStatus.Upcoming;
  Alignment _alignment = Alignment.centerLeft;
  List<Consultation> consultations = [] ; 
  List<Reservation> reservations = [];  
  void setStateIfMounted(f) {
      if (mounted) setState(f);
    }     
  
    _getReservationList() async {
      User user = await AuthContext().getUserDetails();
      print(user.first_name);
      reservations = await DoctorApiMethods().getDoctorReservationList(user.id);
      setStateIfMounted(() {});
    }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getReservationList();
  }

  _navigateToCreateConsultation(){
     Navigator.of(context)
    .push(
      MaterialPageRoute(
        builder: (context) =>  SelectionnerPatient(reservations: reservations,)
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    if(reservations.isEmpty){
          return const Scaffold( body : Center(
            child : CircularProgressIndicator(color: AdminColorSix,)
      ),);
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AdminColorSix,
        centerTitle: true,
        title: Text(
              'Liste des Consultations',
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
          if(consultations.isEmpty)
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("aucune consultation trouvée" , style: TextStyle(color: AdminColorSix ),)
                 ],),
                 
            Expanded(
              child: ListView.builder(
                itemCount: consultations.length,
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
                                  Text(
                                    consultations[index].docteur_id.toString(),
                                    style: TextStyle(
                                      color: Color(MyColors.header01),
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    consultations[index].description,
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
       floatingActionButton : Container(
              width: MediaQuery.of(context).size.width * 0.70,
              decoration: BoxDecoration(
                borderRadius:  BorderRadius.circular(20.0),
              ),
              child: FloatingActionButton.extended(
                backgroundColor: AdminColorSix,
                onPressed: (){
                  _navigateToCreateConsultation();
                },
                elevation: 0,
                label: Text(
                  "Commencer une nouvelle consultation",
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

