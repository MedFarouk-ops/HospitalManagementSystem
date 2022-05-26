import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/animation/animation_controller.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/ticker_provider.dart';
import 'package:pfe_frontend/authentication/models/user.dart';
import 'package:pfe_frontend/authentication/utils/colors.dart';
import 'package:pfe_frontend/docteur/screens/partie_consultations/cree_consultation.dart';

class SelectionPatientManuelle extends StatefulWidget {
  final List<User> patientList;
  const SelectionPatientManuelle({Key? key , required this.patientList}) : super(key: key);

  @override
  State<SelectionPatientManuelle> createState() => _SelectionPatientManuelleState();
}

class _SelectionPatientManuelleState extends State<SelectionPatientManuelle>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  List<User> _foundUsers = [];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
    print(widget.patientList.length);
  }

  _navigateToCreerConsultation(User usr1){
     Navigator.of(context)
    .push(
      MaterialPageRoute(
        builder: (context) =>  CreerConsultation(patient: usr1,)
        )
    );
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
      results = widget.patientList;
    } else {
      results = widget.patientList
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
        title: const Text('rechercher et sélectionner un patient' , style: TextStyle(fontSize: 15),),
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
              child: widget.patientList.isNotEmpty
                  ? ListView.builder(
                      itemCount: _foundUsers.length,
                      itemBuilder: (context, index) => Card(
                        key: ValueKey(_foundUsers[index].id),
                        color: Colors.amberAccent,
                        elevation: 4,
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        child: ListTile(
                          leading: Text(
                            (index+1).toString(),
                            style: const TextStyle(fontSize: 24),
                          ), 
                          title: Text(_foundUsers[index].first_name +" "+ _foundUsers[index].last_name),
                          subtitle: Text(
                              '${_foundUsers[index].age.toString()} years old'),
                          onTap: () {
                            _navigateToCreerConsultation(_foundUsers[index]);
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