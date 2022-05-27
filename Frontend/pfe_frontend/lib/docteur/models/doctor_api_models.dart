import 'package:flutter/material.dart';
import 'package:pfe_frontend/authentication/models/user.dart';

class OrdonnanceData {
  String description; 
  int patient_id;
  int docteur_id;
  OrdonnanceData(this.description, this.docteur_id , this.patient_id);
  Map toJson() {
    return {'description' : description,
            'patient' : patient_id,
            'docteur' : docteur_id,};
  }
}

class Ordonnance{
  final int id;
  final String description;
  final String donnees;
  final int patient_id;
  final int docteur_id;
  final String updated;
  final String created;

  const Ordonnance({
    required this.id,
    required this.description , 
    required this.donnees,
    required this.patient_id,
    required this.docteur_id,
    required this.created,
    required this.updated,
  }); 

  Map<String , dynamic> toJson() => {
            'description' : description,
            'donnees' : donnees,
            'patient' : patient_id,
            'docteur' : docteur_id,
  };

 factory Ordonnance.fromJson(Map<String, dynamic> json) {
    return Ordonnance(
      id : json['id'],
      description : json['description'],
      donnees : json['donnee'],
      patient_id : json['patient'],
      docteur_id : json['docteur'],
      created : json['created'],
      updated : json['updated'],
    );
  }

}


class RadioData{
  final int id;
  final String description;
  final String donnees;
  final int patient_id;
  final int docteur_id;
  final String updated;
  final String created;

  const RadioData({
    required this.id,
    required this.description , 
    required this.donnees,
    required this.patient_id,
    required this.docteur_id,
    required this.created,
    required this.updated,
  });

  Map<String , dynamic> toJson() => {
            'description' : description,
            'donnees' : donnees,
            'patient' : patient_id,
            'docteur' : docteur_id,
  };

 factory RadioData.fromJson(Map<String, dynamic> json) {
    return RadioData(
      id : json['id'],
      description : json['description'],
      donnees : json['donnee'],
      patient_id : json['patient'],
      docteur_id : json['docteur'],
      created : json['created'],
      updated : json['updated'],
    );
  }
  
}


class Analyse{
  final int id;
  final String description;
  final String donnees;
  final int patient_id;
  final int docteur_id;
  final String updated;
  final String created;

  const Analyse({
    required this.id,
    required this.description , 
    required this.donnees,
    required this.patient_id,
    required this.docteur_id,
    required this.created,
    required this.updated,
  });

  Map<String , dynamic> toJson() => {
            'description' : description,
            'donnees' : donnees,
            'patient' : patient_id,
            'docteur' : docteur_id,
  };

 factory Analyse.fromJson(Map<String, dynamic> json) {
    return Analyse(
      id : json['id'],
      description : json['description'],
      donnees : json['donnee'],
      patient_id : json['patient'],
      docteur_id : json['docteur'],
      created : json['created'],
      updated : json['updated'],
    );
  }
}



class Consultation{

  final int id;
  final String description;
  final int ordonnance_id;
  final int patient_id;
  final int docteur_id;
  final String updated;
  final String created;

  const Consultation({
    required this.id,
    required this.description , 
    required this.patient_id,
    required this.docteur_id,
    required this.ordonnance_id,
    required this.created,
    required this.updated,
  });

  Map<String , dynamic> toJson() => {
            'description' : description,
            'patient' : patient_id,
            'docteur' : docteur_id,
            "ordonnance" : ordonnance_id,
  };
  
 factory Consultation.fromJson(Map<String, dynamic> json) {
    return Consultation(
      id : json['id'],
      description : json['description'],
      ordonnance_id: json['ordonnance'],
      patient_id : json['patient'],
      docteur_id : json['docteur'],
      created : json['created'],
      updated : json['updated'],
    );
  }

}