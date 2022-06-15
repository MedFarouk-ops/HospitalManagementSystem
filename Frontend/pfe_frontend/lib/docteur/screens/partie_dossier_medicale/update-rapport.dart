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
import 'package:pfe_frontend/docteur/utils/doctor_api_methods.dart';

class ModifierRapport extends StatefulWidget {
  final RapportMedical rapport ; 
  final List<User> patientslist;
  const ModifierRapport({Key? key , required this.rapport , required this.patientslist}) : super(key: key);

  @override
  State<ModifierRapport> createState() => _ModifierRapportState();
}

class _ModifierRapportState extends State<ModifierRapport>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  String desc="" , patName="" , filePath="";

_setEditingValue() async {
  User pat = await ApiMethods().getUserById(widget.rapport.patient_id);
  desc =  widget.rapport.description;
  patName = pat.first_name + " "+ pat.last_name;
  filePath = widget.rapport.donnees;
  descriptionController.text = desc;
  patientCtl.text = patName;
  file_name.text =filePath;
}

@override
  void initState() {
    // TODO: implement initState
    super.initState();
    _setEditingValue();
  }

 bool _isLoading = false ;
    void setStateIfMounted(f) {
    if (mounted) setState(f);
    }
     void creerRapportMedicale() async {
          setStateIfMounted(() {
              _isLoading = true;
            });
          String result ="";
          User currentuser = await AuthContext().getUserDetails();
          if(file!=null){
          result = await DoctorApiMethods().updateRapportMedicale(
            File(file.path),
            descriptionController.text, 
            currentuser.id,
            widget.rapport.id
            );
          }else{
            result = await DoctorApiMethods().updateWithoutFileRapport(
            descriptionController.text, 
            currentuser.id,
            widget.rapport.id
            );
          }
           setStateIfMounted(() {
              _isLoading = false;
          });
          if(result != "success"){
              showSnackBar("une erreur est survenue , veuillez réessayer !", context);
          }
          else{
              showSnackBar("Rapport medicale modifié avec success !", context);
          }
          
    }

  Client client = http.Client();
  
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.

  //
  TextEditingController descriptionController = TextEditingController();
  TextEditingController patientCtl = TextEditingController();
  TextEditingController file_name = TextEditingController();

  // Note: This is a GlobalKey<FormState>,
  // not a GlobalKey<MyCustomFormState>.
  final _formKey = GlobalKey<FormState>();
  DateTime dateRendezvous = DateTime.now();
  var file ;
  bool? disponible; 
  String? patient_full_name = "";

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    descriptionController.dispose();
    patientCtl.dispose();
    file_name.dispose();
  }


//  choisir le fichier pdf qui contient les analyses/bilans : 

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
        title: Text("Modifier le rapport"),
        backgroundColor: AdminColorSix,
        
      ),
      body:SingleChildScrollView(
      child: RefreshIndicator(onRefresh: () async{
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
          const SizedBox(height: 20),
          SizedBox( // <-- SEE HERE
            width: 400,
            height: 80,
            child:TextFormField(
            controller: descriptionController,
            decoration: InputDecoration(labelText: 'Description de rapport : ' , border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)) ),
            maxLines: 1,
            validator: (value) {
              if (value!.isEmpty) {
                return 'ce champ ne peut pas être vide';
              }
              return null;
            },
          ),),


               
              MaterialButton(
                onPressed: () {
                  _pickFile(); 
                },
                child: Text(
                  "Choisir le rapport pdf",
                  style: TextStyle(color: Colors.white),
                ),
                color: AdminColorSix,
              ),
              SizedBox( // <-- SEE HERE
              width: 400,
              height: 100,
              child: TextFormField(
                        enabled: false,
                        controller: file_name,
                        decoration: InputDecoration(labelText: 'fichier choisit : ' , border: OutlineInputBorder(borderRadius: BorderRadius.circular(2))),
                        maxLines: 3,
            ),),

            Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: AdminColorSix),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                        creerRapportMedicale();
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