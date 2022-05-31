import 'dart:io';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/animation/animation_controller.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/ticker_provider.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:pfe_frontend/accueil/utils/api_methods.dart';
import 'package:pfe_frontend/authentication/context/authcontext.dart';
import 'package:pfe_frontend/authentication/models/user.dart';
import 'package:pfe_frontend/authentication/utils/colors.dart';
import 'package:pfe_frontend/authentication/utils/utils.dart';
import 'package:pfe_frontend/docteur/models/doctor_api_models.dart';
import 'package:pfe_frontend/docteur/utils/constant.dart';
import 'package:pfe_frontend/docteur/utils/doctor_api_methods.dart';


class CreerConsultation extends StatefulWidget {
  final User patient ;
  const CreerConsultation({Key? key ,
  required this.patient
  }) : super(key: key);

  @override
  State<CreerConsultation> createState() => _CreerConsultationState();
}

class _CreerConsultationState extends State<CreerConsultation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  
  TextEditingController description_cons = TextEditingController();
  TextEditingController description_ord = TextEditingController();
  TextEditingController file_name = TextEditingController();
  int patient_id = 0;
  int docteur_id = 0;
  int ordonnance_id = 0 ;
  bool _isLoading = false ;
  var file ;
  String? patient_full_name = "";
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
    description_cons.dispose();
    description_ord.dispose();
    file_name.dispose();
  }

 void setStateIfMounted(f) {
  if (mounted) setState(f);
}

  _creerConsultation() async {
    setStateIfMounted(() {
              _isLoading = true;
    });
    String? result ;
    User currentuser = await AuthContext().getUserDetails();
    Ordonnance ord = Ordonnance(id: 0, description: "", donnees: "", patient_id: 0, docteur_id: 0, created: "", updated: "");
    if (file == null) return;
    ord = await DoctorApiMethods().creerOrdonnance(File(file.path), description_ord.text, widget.patient.id, currentuser.id);
    if(ord.id != 0){
      print(ord.id);
      result = await DoctorApiMethods().creerConsultation(
        description: description_cons.text,
        ordonnance_id: ord.id,
        patient_id: widget.patient.id,
        docteur_id: currentuser.id);        
    }
    setStateIfMounted(() {
              _isLoading = false;
    });
    if(result == "success"){
              showSnackBar("Consultation ajouter avec success", context); 
    }
    else{
        showSnackBar("une erreur s'est produite, veuillez réessayer", context); 
    }

  }

  void _pickFile() async {
      
    // opens storage to pick files and the picked file or files
    // are assigned into result and if no file is chosen result is null.
    // you can also toggle "allowMultiple" true or false depending on your need
    final result = await FilePicker.platform.pickFiles(allowMultiple: false);
  
    // if no file is picked
    if (result == null) return;
    if(result != null){
      file = result.files.first ;
    }
    file_name.text = file.name;
    // we will log the name, size and path of the
    // first picked file (if multiple are selected)
    print(result.files.first.name);
    print(result.files.first.size);
    print(result.files.first.path);
  }
  

  @override
  Widget build(BuildContext context) {
   String _formattedate;

    // Build a Form widget using the _formKey created above.
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AdminColorSix,
        title:  Text(
              'Commencer une nouvelle consultation',
              textAlign: TextAlign.left,
              style: kTitleStyle3,
            ),
        
      ),
      body:  SingleChildScrollView(
  child:RefreshIndicator(onRefresh: () async{
        //  _setUsers();
        },
        child : Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
        Form( 
          key: _formKey,
          child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
          const SizedBox(height: 30),
          // Text("Commencer une nouvelle consultation ",maxLines: 20, style: TextStyle(fontSize: 16.0 ,fontWeight:FontWeight.bold,color: Colors.black) , ),
          Divider(),  
          
           Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("Patient : "+ widget.patient!.first_name + " " + widget.patient!.last_name , style: TextStyle(color: AdminColorSix  , fontSize: 20),),
                Divider(),
                Text("age : "+ widget.patient!.age +" ans " , style: TextStyle(color: Colors.black  , fontSize: 20),),
          ],),


          const SizedBox(height: 30),
        
          SizedBox( // <-- SEE HERE
            width: 400,
            height: 100,
            child:TextFormField(
            controller: description_cons,
            decoration: InputDecoration(labelText: 'Motif : ' , border: OutlineInputBorder(borderRadius: BorderRadius.circular(5))),
            maxLines: 2,
            validator: (value) {
              if (value!.isEmpty) {
                return 'ce champ ne peut pas être vide';
              }
              return null;
            },
          ),),
          const SizedBox(height: 30),
          Text("Ajouter une ordonnance ",maxLines: 20, style: TextStyle(fontSize: 16.0 ,fontWeight:FontWeight.bold,color: Colors.black) , ),
          const SizedBox(height: 30),
          SizedBox( // <-- SEE HERE
            width: 400,
            height: 100,
            child:TextFormField(
            controller: description_ord,
            decoration: InputDecoration(labelText: 'Diagnostic : ' , border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)) ),
            maxLines: 3,
            validator: (value) {
              if (value!.isEmpty) {
                return 'ce champ ne peut pas être vide';
              }
              return null;
            },
          ),),
          const SizedBox(height: 30),
        
          MaterialButton(
            onPressed: () {
              _pickFile(); 
            },
            child: Text(
              "Choisir l`ordonnance pdf",
              style: TextStyle(color: Colors.white),
            ),
            color: Colors.green,
          ),
          
          const SizedBox(height: 30),
            SizedBox( // <-- SEE HERE
            width: 400,
            height: 100,
            child: TextFormField(
                      enabled: false,
                      controller: file_name,
                      decoration: InputDecoration(labelText: 'fichier choisit : ' , border: OutlineInputBorder(borderRadius: BorderRadius.circular(2))),
                      maxLines: 3,
          ),),
          const SizedBox(height: 30),
          Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: ElevatedButton(
                   style: ElevatedButton.styleFrom(primary: AdminColorSix),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                          _creerConsultation();
                        }
                      },
                    child:  Container(
                            child: _isLoading ? Center(child: CircularProgressIndicator(
                              color: primaryColor,
                        ),)
                    : const Text('Enregistrer'),),
                  ),
                ),                
            ],           
        ),
      )],),)));
    }
}