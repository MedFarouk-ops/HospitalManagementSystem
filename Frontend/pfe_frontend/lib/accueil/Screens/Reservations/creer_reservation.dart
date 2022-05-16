import 'dart:convert';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:pfe_frontend/accueil/utils/api_methods.dart';
import 'dart:io' show Platform;
import 'package:pfe_frontend/admin/utils/dimensions.dart';
import 'package:pfe_frontend/authentication/models/user.dart';

class CreateReservation extends StatefulWidget {
  
  final  List<User> patientslist ;
  final  List<User> docteurslist ;
  const CreateReservation({ Key? key , required this.docteurslist , required this.patientslist}) : super(key: key);

  @override
  State<CreateReservation> createState() => _CreateReservationState();
}

class _CreateReservationState extends State<CreateReservation> {

  Client client = http.Client();
  

   // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  TextEditingController dateCtl = TextEditingController();
  TextEditingController starttimeCtl = TextEditingController();
  TextEditingController endtimeCtl = TextEditingController();
  TextEditingController patientCtl = TextEditingController();
  TextEditingController docteurCtl = TextEditingController();
  // Note: This is a GlobalKey<FormState>,
  // not a GlobalKey<MyCustomFormState>.
  final _formKey = GlobalKey<FormState>();
  DateTime? dateRendezvous;
  TimeOfDay? startTime;
  TimeOfDay? endTime ;
  int? patient_id;
  int? docteur_id;
  bool? disponible; 


  @override
  Widget build(BuildContext context) {
    String _formattedate;

    // Build a Form widget using the _formKey created above.
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        
      ),
      body: RefreshIndicator(onRefresh: () async{
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
          Text("Creer une nouvelle reservations : ",maxLines: 20, style: TextStyle(fontSize: 16.0 ,fontWeight:FontWeight.bold,color: Colors.black) , ),
          const SizedBox(height: 30),
            
          TextFormField(
            controller: dateCtl,
            decoration: InputDecoration(labelText: 'Date Rendez vous : '),
            onTap: () async {
              FocusScope.of(context).requestFocus(new FocusNode());
              DateTime? picked = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2020),
                  lastDate: DateTime(2030));
              _formattedate =  new DateFormat.yMMMMEEEEd().format(picked ?? DateTime.now()) ; 
              dateCtl.text = _formattedate.toString();
              if(picked != null && picked != dateRendezvous){
                setState(() {
                  dateRendezvous = picked;
                });
              }
            },
            validator: (value) {
              if (value!.isEmpty) {
                return 'ce champ ne peut pas être vide';
              }
              return null;
            },
          ),

          TextFormField(
              controller: starttimeCtl,  // add this line.
              decoration: InputDecoration(
                labelText: 'Heure de début :',
              ),
              onTap: () async {
                TimeOfDay time = TimeOfDay.now();
                FocusScope.of(context).requestFocus(new FocusNode());
                TimeOfDay? picked = await showTimePicker(context: context, initialTime: startTime ?? time);
                if (picked != null && picked != startTime) {
                  final hours = picked.hour.toString().padLeft(2, '0');
                  final minutes = picked.minute.toString().padLeft(2, '0');
                  starttimeCtl.text = '$hours:$minutes';  // add this line.
                  setState(() {
                    startTime = picked;
                  });
                }
              },
              validator: (value) {
                if (value!.isEmpty) {
                  return 'ce champ ne peut pas être vide';
                }
                return null;
              },
            ),

          TextFormField(
              controller: endtimeCtl,  // add this line.
              decoration: InputDecoration(
                labelText: 'Heure de fin :',
              ),
              onTap: () async {
                TimeOfDay time = TimeOfDay.now();
                FocusScope.of(context).requestFocus(new FocusNode());
                TimeOfDay? picked = await showTimePicker(context: context, initialTime: startTime ?? time);
                if (picked != null && picked != startTime) {
                  final hours = picked.hour.toString().padLeft(2, '0');
                  final minutes = picked.minute.toString().padLeft(2, '0');
                  endtimeCtl.text = '$hours:$minutes';  // add this line.
                  setState(() {
                    startTime = picked;
                  });
                }
              },
              validator: (value) {
                if (value!.isEmpty) {
                  return 'ce champ ne peut pas être vide';
                }
                return null;
              },
            ),

            Divider(),
            
            DropdownSearch<String>(
                items: widget.patientslist.map((patient) => patient.first_name +" " + patient.last_name ).toList(),
                dropdownSearchDecoration: InputDecoration(
                  labelText: "Selectionner un Patient",
                  contentPadding: EdgeInsets.fromLTRB(12, 12, 0, 0),
                  border: OutlineInputBorder(),
                ),
                onChanged: print,
                selectedItem: "-",
                popupProps: PopupProps.bottomSheet(
                  searchFieldProps: TextFieldProps(
                    padding: EdgeInsets.fromLTRB(8, 8, 8, 0),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.fromLTRB(12, 12, 8, 0),
                      labelText: "Rechercher ...",
                    ),
                  ),
                  title: Container(
                    height: 50,
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColorDark,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        'Selectionner le patient : ',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  bottomSheetProps: BottomSheetProps(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(24),
                        topRight: Radius.circular(24),
                      ),
                    ),
                  ),
                  showSearchBox: true,
                ),
              ),
              Divider(),
               DropdownSearch<String>(
                items:  widget.docteurslist.map((docteur) => docteur.first_name +" " + docteur.last_name ).toList(),
                dropdownSearchDecoration: InputDecoration(
                  labelText: "Selectionner un Docteur",
                  contentPadding: EdgeInsets.fromLTRB(12, 12, 0, 0),
                  border: OutlineInputBorder(),
                ),
                onChanged: print,
                selectedItem: "-",
                popupProps: PopupProps.bottomSheet(
                  searchFieldProps: TextFieldProps(
                    padding: EdgeInsets.fromLTRB(8, 8, 8, 0),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.fromLTRB(12, 12, 8, 0),
                      labelText: "Rechercher ...",
                    ),
                  ),
                  title: Container(
                    height: 50,
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColorDark,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        'Selectionner le patient : ',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  bottomSheetProps: BottomSheetProps(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(24),
                        topRight: Radius.circular(24),
                      ),
                    ),
                  ),
                  showSearchBox: true,
                ),
              ),
              Divider(),





            Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Processing Data')),
                          );
                        }
                      },
                    child: const Text('Enregistrer'),
                    ),
                  ),
            ],
            
        ),
      )],),));
    }
}