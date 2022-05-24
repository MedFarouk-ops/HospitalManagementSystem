import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:pfe_frontend/admin/responsive/mobile_screen_layout.dart';
import 'package:pfe_frontend/admin/screens/DoctorScreens/doctor_list.dart';
import 'package:pfe_frontend/admin/screens/PatientScreens/patient_list.dart';
import 'package:pfe_frontend/admin/screens/adminHome.dart';
import 'package:pfe_frontend/admin/widget/appbar_widget.dart';
import 'package:pfe_frontend/admin/widget/button_widget.dart';
import 'package:pfe_frontend/admin/widget/numbers_widget.dart';
import 'package:pfe_frontend/admin/widget/profile_widget.dart';
import 'package:pfe_frontend/authentication/models/user.dart';
import 'package:pfe_frontend/authentication/utils/colors.dart';
import 'package:url_launcher/url_launcher.dart';

class PublicUserShow extends StatefulWidget {
  final User user;

  const PublicUserShow({ Key? key , required this.user}) : super(key: key);

  @override
  State<PublicUserShow> createState() => _PublicUserShowState();
}

class _PublicUserShowState extends State<PublicUserShow> {
  String genre = "";
  String? role;
  Client client = http.Client();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _setGenreAndRole();
  }

  _setGenreAndRole(){
    if(widget.user.genre == 11){
      genre = "homme";
    }else{
      genre = "femme";
    }
  }



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
          buildName(widget.user),
          const SizedBox(height: 24),
          Center(
            child:Wrap(
            children: [
              buildCallButton(widget.user.mobilenumber),
              buildUpgradeButton(),
            ],
          ),
          ),
          // Center(child: buildUpgradeButton()),
          const SizedBox(height: 48),
          buildAbout(widget.user),
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
      
  Widget buildCallButton(String mobile) => ButtonWidget(
        text: 'Appeler',
        onClicked:  () => launch("tel://$mobile"),
      );

  _returnToDashboard(){
      Navigator.of(context)
      .push(
        MaterialPageRoute(
          builder: (context) => const AdminMobileScreenLayout()
          )
      );
  }
  
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
            Text( "telephone : " + 
              user.mobilenumber,
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
