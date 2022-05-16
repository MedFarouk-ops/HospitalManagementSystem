import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pfe_frontend/authentication/models/user.dart';

class CreateReservation extends StatefulWidget {
  const CreateReservation({ Key? key }) : super(key: key);

  @override
  State<CreateReservation> createState() => _CreateReservationState();
}

class _CreateReservationState extends State<CreateReservation> {
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
  var _patients = ["Food","Transport","Personal","Shopping","Medical","Rent","Movie","Salary"];
  var _docteurs = ["Food","Transport","Personal","Shopping","Medical","Rent","Movie","Salary"];


  @override
  Widget build(BuildContext context) {
    String _formattedate = new DateFormat.yMMMMEEEEd().format(dateRendezvous ?? DateTime.now());

    // Build a Form widget using the _formKey created above.
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
        Form( 
          key: _formKey,
          child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
      )],),);
    }
}