import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/animation/animation_controller.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/ticker_provider.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:pfe_frontend/authentication/models/user.dart';
import 'package:pfe_frontend/authentication/utils/colors.dart';
import 'package:pfe_frontend/docteur/utils/constant.dart';

class CreerConsultation extends StatefulWidget {
  // final  List<User> patientslist ;
  const CreerConsultation({Key? key ,
  // required this.patientslist
  }) : super(key: key);

  @override
  State<CreerConsultation> createState() => _CreerConsultationState();
}

class _CreerConsultationState extends State<CreerConsultation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  
  TextEditingController description_cons = TextEditingController();
  TextEditingController description_ord = TextEditingController();
  int patient_id = 0;
  int docteur_id = 0;
  int ordonnance_id = 0 ;
  bool _isLoading = false ;
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
  }
  //  _setIds(){
  //   patient_id = widget.patientslist[widget.patientslist.indexWhere((p) => p.first_name + " " + p.last_name == patient_full_name)].getUserId();
  // }
  

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
          DropdownSearch<String>(
                 items: [],
                // widget.patientslist.map((patient) => patient.first_name +" " + patient.last_name ).toList(),
                dropdownSearchDecoration: InputDecoration(
                  labelText: "Selectionner un Patient",
                  contentPadding: EdgeInsets.fromLTRB(12, 12, 0, 0),
                  border: OutlineInputBorder(),
                ),
                selectedItem: "-",
                onChanged:(String? data) {
                    setState(() {
                    patient_full_name = data;
                    }
                  );
                },
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
          const SizedBox(height: 30),
        
          TextFormField(
            controller: description_cons,
            decoration: InputDecoration(labelText: 'Description : '),
            validator: (value) {
              if (value!.isEmpty) {
                return 'ce champ ne peut pas être vide';
              }
              return null;
            },
          ),
          const SizedBox(height: 30),
          Text("Ajouter une ordonnance ",maxLines: 20, style: TextStyle(fontSize: 16.0 ,fontWeight:FontWeight.bold,color: Colors.black) , ),
        
          TextFormField(
            controller: description_cons,
            decoration: InputDecoration(labelText: 'Description : '),
            validator: (value) {
              if (value!.isEmpty) {
                return 'ce champ ne peut pas être vide';
              }
              return null;
            },
          ),
          const SizedBox(height: 30),
        
          TextFormField(
            controller: description_cons,
            decoration: InputDecoration(labelText: 'Image : '),
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
                    // creer consultation //
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