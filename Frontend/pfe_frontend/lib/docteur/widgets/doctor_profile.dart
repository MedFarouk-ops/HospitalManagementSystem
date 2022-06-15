import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decode/jwt_decode.dart';
import 'package:pfe_frontend/admin/screens/DoctorScreens/doctor_list.dart';
import 'package:pfe_frontend/admin/screens/PatientScreens/patient_list.dart';
import 'package:pfe_frontend/admin/widget/appbar_widget.dart';
import 'package:pfe_frontend/admin/widget/button_widget.dart';
import 'package:pfe_frontend/admin/widget/profile_widget.dart';
import 'package:pfe_frontend/authentication/context/authcontext.dart';
import 'package:pfe_frontend/authentication/models/user.dart';
import 'package:pfe_frontend/docteur/screens/parametre_securite.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DoctorProfile extends StatefulWidget {
  const DoctorProfile({ Key? key }) : super(key: key);

  @override
  State<DoctorProfile> createState() => _DoctorProfileState();
}

class _DoctorProfileState extends State<DoctorProfile> {

  /******************************************************************************************************************************* */
  /******************************************************************************************************************************* */
  User user = User(
     id:0 ,
     email: "",
     first_name: "", 
     last_name: "", 
     address: "", 
     mobilenumber: "0",
     age: "", 
     genre: "", 
     role: "", 
     username: "");

  String genre = "";
  String role ="";
  Client client = http.Client();
  /******************************************************************************************************************************* */
  /******************************************************************************************************************************* */


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _initializeUser();
  }

  _setGenreAndRole(){
    if(user.genre == 11){
      genre = "homme";
    }else{
      genre = "femme";
    }

    switch(user.role) { 
    case 1: { 
        role = "Admin" ; 
    } 
    break; 
    
    case 2: { 
        role = "Patient" ;
    } 
    break; 
    case 3: { 
        role = "Docteur" ;
    } 
    break; 
    case 4: { 
        role = "Infermier" ; 
    } 
    break; 
    case 5: { 
        role = "Accueil";
    } 
    break; 
        
    default: { 
        role = "PATIENT" ;
    }
    break; 
    } 






  }  

   _initializeUser() async {
        user = await AuthContext().getUserDetails();
        print(user.genre);
        _setGenreAndRole();
        setState(() {});
    }

     // *********************************************//

    // empêcher l'utilisateur de revenir en arriere : 

    ModalRoute<dynamic>? _route;

    @override
    void didChangeDependencies() {
      super.didChangeDependencies();
      _route?.removeScopedWillPopCallback(_onWillPop);
      _route = ModalRoute.of(context);
      _route?.addScopedWillPopCallback(_onWillPop);
    }

    @override
    void dispose() {
      _route?.removeScopedWillPopCallback(_onWillPop);
      super.dispose();
    }
    
    Future<bool> _onWillPop() => Future.value(false);

    // ************************************************ // 

    
  
  @override
  Widget build(BuildContext context) {
       return Scaffold(
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: [
          const SizedBox(height: 24),
          ProfileWidget(
            imagePath: 'https://www.business2community.com/wp-content/uploads/2017/08/blank-profile-picture-973460_640.png',
            onClicked: () async {},
          ),
          const SizedBox(height: 24),
          buildName(user),
          const SizedBox(height: 24),
          Center(
            child:Wrap(
            children: [
              buildUpgradeButton(),
              buildLogoutButton(),
              ParametreSecuriteButton()
            ],
          ),
          ),
          // Center(child: buildUpgradeButton()),
          const SizedBox(height: 48),
          buildAbout(user),
        ],
      ),
    );
  }

  Widget buildName(User user) => Column(
        children: [
          Text(
            user.first_name,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          ),
          const SizedBox(height: 4),
          Text(
            user.email,
            style: TextStyle(color: Colors.grey),
          )
      ],
  );

  Widget buildUpgradeButton() => SecondButtonWidget(
        text: 'Modifier',
        onClicked: () {},
      );
      
    Widget buildLogoutButton() => SecondButtonWidget(
        text: 'Deconnecter',
        onClicked: () {
          AuthContext().logoutUser(context);
        },
      );

    Widget ParametreSecuriteButton() => SecondButtonWidget(
        text: 'Parametre de securité',
        onClicked: () {
           Navigator.of(context)
          .push(
            MaterialPageRoute(
              builder: (context) => ParametreSecuritePage()
              )
          );
        },
      );
  

  Widget buildAbout(User user) => Container(
        padding: EdgeInsets.symmetric(horizontal: 70),
        child: Column(
          children: [
            Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [Text(
              'Role :   ' + role,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            const SizedBox(height: 16),
            ],),
            Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            Text(
              'Information :',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Text( "email : " + 
              user.email,
              style: TextStyle(fontSize: 16, height: 1.4),
            ),
            const SizedBox(height: 16),
            Text( "username : " + 
              user.username,
              style: TextStyle(fontSize: 16, height: 1.4),
            ),
            const SizedBox(height: 16),
            Text( "nom : " + 
              user.first_name,
              style: TextStyle(fontSize: 16, height: 1.4),
            ),
            const SizedBox(height: 16),
            Text( "prenom : " + 
              user.last_name,
              style: TextStyle(fontSize: 16, height: 1.4),
            ),
            
            const SizedBox(height: 16),
            Text( "age : " + 
              user.age,
              style: TextStyle(fontSize: 16, height: 1.4),
            ),
            const SizedBox(height: 16),
            Text( "address : " + 
              user.address,
              style: TextStyle(fontSize: 16, height: 1.4),
            ),
            const SizedBox(height: 16),
            Text( "genre : " + 
              genre,
              style: TextStyle(fontSize: 16, height: 1.4),
            ),],),
          ],
        ),
      );
}