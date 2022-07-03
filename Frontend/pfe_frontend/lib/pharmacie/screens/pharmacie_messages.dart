import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/animation/animation_controller.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/ticker_provider.dart';
import 'package:pfe_frontend/accueil/models/reservation.dart';
import 'package:pfe_frontend/accueil/utils/api_methods.dart';
import 'package:pfe_frontend/authentication/models/user.dart';
import 'package:pfe_frontend/authentication/utils/colors.dart';
import 'package:pfe_frontend/authentication/utils/utils.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:io' show Platform;


class PharMessages extends StatefulWidget {
  const PharMessages({Key? key}) : super(key: key);

  @override
  State<PharMessages> createState() => _PharMessagesState();
}

class _PharMessagesState extends State<PharMessages>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;


  List<User> _foundUsers = [];
  List<User> docteurList = [];
  
  void setStateIfMounted(f) {
      if (mounted) setState(f);
  }

  _setListDocteurs() async 
  {
    docteurList = await ApiMethods().getDoctors();
  }






//***************************** Ouvrir whats app *************************** */

   void launchWhatsApp( String phone) async {
        String url() {
          if (Platform.isAndroid) {
            return "whatsapp://send?phone=$phone/}";
          } else {
            return "https://api.whatsapp.com/send?phone=$phone}";
          }
      }
      if (await canLaunch(url())) {
      await launch(url());
      } else {
        showSnackBar("Verifier que whatsapp est installé dans votre machine", context);
        // throw 'Could not launch ${url()}';
      }
   }





  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
    _setListDocteurs();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

 // This function is called whenever the text field changes
  void _runFilter(String enteredKeyword) {
    List<User> results = [];
    if (enteredKeyword.isEmpty) {
      // if the search field is empty or only contains white-space, we'll display all users
      results = docteurList;
    } else {
      results = docteurList
          .where((user) =>
              user.first_name.toLowerCase().contains(enteredKeyword.toLowerCase()) || user.last_name.toLowerCase().contains(enteredKeyword.toLowerCase()) )
          .toList();
      // we use the toLowerCase() method to make it case-insensitive
    }

    // Refresh the UI
    setState(() {
      _foundUsers = results;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AdminColorSix,
        centerTitle: true,
        title: const Text('rechercher et sélectionner un docteur' , style: TextStyle(fontSize: 15),),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            TextField(
              onChanged: (value) => _runFilter(value),
              cursorColor: Colors.black,
              decoration: const InputDecoration(
                  enabledBorder: UnderlineInputBorder(      
                        borderSide: BorderSide(color: Colors.black),   
                        ),  
                  focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                      ),
                  labelStyle: TextStyle(
                    color: Colors.black
                  ), 
                  hoverColor: AdminColorSix ,
                  labelText: 'Rechercher', suffixIcon: Icon(Icons.search , color: Colors.black,)),
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: docteurList.isNotEmpty
                  ? ListView.builder(
                      itemCount: _foundUsers.length,
                      itemBuilder: (context, index) => Card(
                        key: ValueKey(_foundUsers[index].id),
                        color: AdminColorSix,
                        elevation: 4,
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        child: ListTile(
                          leading: Text(
                            (index+1).toString(),
                            style: const TextStyle(fontSize: 24),
                          ), 
                          title: Text(_foundUsers[index].first_name +" "+ _foundUsers[index].last_name),
                          subtitle: Text(
                              'specialité : ${_foundUsers[index].specialite} '),
                          onTap: () {
                            launchWhatsApp(docteurList[index].mobilenumber);
                          },
                        ),
                      ),
                    )
                  : const Text(
                      'No results found',
                      style: TextStyle(fontSize: 24),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}