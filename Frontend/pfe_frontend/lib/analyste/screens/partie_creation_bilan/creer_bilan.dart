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
import 'package:pfe_frontend/authentication/models/user.dart';
import 'package:pfe_frontend/authentication/utils/colors.dart';

class CreerBilan extends StatefulWidget {

  final int typeBilan ;
  final  List<User> patientslist ;
  final  List<User> docteurslist ;
  const CreerBilan({Key? key ,  required this.typeBilan , required this.docteurslist , required this.patientslist}) : super(key: key);

  @override
  State<CreerBilan> createState() => _CreerBilanState();
}

class _CreerBilanState extends State<CreerBilan>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
 bool _isLoading = false ;

    void setStateIfMounted(f) {
    if (mounted) setState(f);
    }
     void creerBilan() async {
          // setStateIfMounted(() {
          //     _isLoading = true;
          //   });
          // _setIds();
          // String result = await ApiMethods().createReservation(dateRendezvous: dateRendezvous,
          //                                starttime: starttimeCtl.text,
          //                                endtime: endtimeCtl.text,
          //                                patient_id: _patient_id,
          //                                docteur_id: _docteur_id,);
          //  setStateIfMounted(() {
          //     _isLoading = false;
          // });
          // if(result != "success"){
          //     showSnackBar("une erreur est survenue , veuillez réessayer !", context);
          // }
          // else{
          //     showSnackBar("reservation creer avec success !", context);
          // }
          
    }

  _setIds(){
    _patient_id = widget.patientslist[widget.patientslist.indexWhere((p) => p.first_name + " " + p.last_name == patient_full_name)].getUserId();
    _docteur_id = widget.docteurslist[widget.docteurslist.indexWhere((d) => d.first_name + " " + d.last_name == doctor_full_name)].getUserId();
  }


  Client client = http.Client();
  
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  TextEditingController descriptionController = TextEditingController();
  TextEditingController nomLaboratoireConroller = TextEditingController();
  TextEditingController patientCtl = TextEditingController();
  TextEditingController docteurCtl = TextEditingController();
  TextEditingController file_name = TextEditingController();

  // Note: This is a GlobalKey<FormState>,
  // not a GlobalKey<MyCustomFormState>.
  final _formKey = GlobalKey<FormState>();
  DateTime dateRendezvous = DateTime.now();
  int _patient_id = 0;
  int _docteur_id = 0;
  var file ;
  bool? disponible; 
  String? patient_full_name = "";
  String? doctor_full_name = "";

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    descriptionController.dispose();
    nomLaboratoireConroller.dispose();
    patientCtl.dispose();
    docteurCtl.dispose();
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
        title: Text("Ajouter un nouveau bilan"),
        backgroundColor: AdminColorSeven,
        
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
            controller: nomLaboratoireConroller,
            decoration: InputDecoration(labelText: 'nom de laboratoire : ' , border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)) ),
            maxLines: 1,
            validator: (value) {
              if (value!.isEmpty) {
                return 'ce champ ne peut pas être vide';
              }
              return null;
            },
          ),),
          SizedBox( // <-- SEE HERE
            width: 400,
            height: 80,
            child:TextFormField(
            controller: descriptionController,
            decoration: InputDecoration(labelText: 'Description de bilan : ' , border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)) ),
            maxLines: 1,
            validator: (value) {
              if (value!.isEmpty) {
                return 'ce champ ne peut pas être vide';
              }
              return null;
            },
          ),),


          

           SizedBox( // <-- SEE HERE
            width: 400,
            height: 80,
            child:DropdownSearch<String>(
                items: widget.patientslist.map((patient) => patient.first_name +" " + patient.last_name ).toList(),
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
              ),),
              SizedBox( // <-- SEE HERE
              width: 400,
              height: 80,
              child:DropdownSearch<String>(
                items:  widget.docteurslist.map((docteur) => docteur.first_name +" " + docteur.last_name ).toList(),
                dropdownSearchDecoration: InputDecoration(
                  labelText: "Selectionner un Docteur",
                  contentPadding: EdgeInsets.fromLTRB(12, 12, 0, 0),
                  border: OutlineInputBorder(),
                ),
                onChanged: (String? data) {
                    setState(() {
                    doctor_full_name = data;
                    }
                  );
                },
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
                        'Selectionner le docteur : ',
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
              ),),
              MaterialButton(
                onPressed: () {
                  _pickFile(); 
                },
                child: Text(
                  "Choisir le bilan pdf",
                  style: TextStyle(color: Colors.white),
                ),
                color: AdminColorSeven,
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
                  style: ElevatedButton.styleFrom(primary: AdminColorSeven),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                        print(_patient_id);
                        print(_docteur_id);

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