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
import 'package:shared_preferences/shared_preferences.dart';

class AdminProfile extends StatefulWidget {
  const AdminProfile({ Key? key }) : super(key: key);

  @override
  State<AdminProfile> createState() => _AdminProfileState();
}

class _AdminProfileState extends State<AdminProfile> {
  /******************************************************************************************************************************* */
  /******************************************************************************************************************************* */
  User user = User(
     id:0 ,
     email: "",
     first_name: "", 
     last_name: "", 
     address: "", 
     age: "", 
     genre: "", 
     role: "", 
     username: "");

  String genre = "";
  String? role;
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
              buildLogoutButton()
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

  Widget buildUpgradeButton() => ButtonWidget(
        text: 'Modifier',
        onClicked: () {},
      );
      
    Widget buildLogoutButton() => ButtonWidget(
        text: 'Logout',
        onClicked: () {
          AuthContext().logoutUser(context);
        },
      );
  

  Widget buildAbout(User user) => Container(
        padding: EdgeInsets.symmetric(horizontal: 48),
        child: Column(
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
            ),
          ],
        ),
      );
}
