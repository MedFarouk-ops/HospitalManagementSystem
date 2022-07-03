import 'package:flutter/material.dart';
import 'package:pfe_frontend/authentication/utils/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ToggleButtons1 extends StatefulWidget {
  @override
  _ToggleButtons1State createState() => _ToggleButtons1State();
}

class _ToggleButtons1State extends State<ToggleButtons1> {

  late SharedPreferences s_prefs;
  bool use_fingeprint = false ;
  List<String>? authtokens;

  _setFingerPrintAuthentication()async {
     s_prefs = await SharedPreferences.getInstance();
     s_prefs.setBool("use_fingerprint", use_fingeprint);
  }

  List<bool> isSelected = [false, true,];

  _setUseFingerprint() async {
     s_prefs = await SharedPreferences.getInstance();
     bool usingF =  s_prefs.getBool("use_fingerprint") ?? false;
    setState(() {
      if(usingF == true){
      isSelected = [true , false];
    }else{
      isSelected = [false , true];
    }  
    });
  
  }


  @override
  void initState() {
    // TODO: implement initState
    _setUseFingerprint();
    super.initState();

  }
  

  @override
  Widget build(BuildContext context) => Container(
        color: Colors.green.withOpacity(0.5),
        child: ToggleButtons(
          isSelected: isSelected,
          selectedColor: Colors.white,
          color: Colors.black,
          fillColor: AdminColorSix,
          renderBorder: false,
          //splashColor: Colors.red,
          highlightColor: Colors.orange,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Text('Activé', style: TextStyle(fontSize: 18)),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Text('Desactivé', style: TextStyle(fontSize: 18)),
            ),
          ],
          onPressed: (int newIndex) {
            setState(() {
              for (int index = 0; index < isSelected.length; index++) {
                if (index == newIndex) {
                  isSelected[index] = true;
                } else {
                  isSelected[index] = false;
                }
              }
              if(isSelected[0] == true){
                use_fingeprint =true;
              }
              else{
                use_fingeprint = false;
              }
              _setFingerPrintAuthentication();
              print(use_fingeprint);
            });
          },
        ),
      );
}