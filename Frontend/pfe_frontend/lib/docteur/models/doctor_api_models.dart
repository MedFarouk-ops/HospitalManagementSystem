import 'package:flutter/material.dart';
import 'package:pfe_frontend/authentication/models/user.dart';

// Class utilisée dans les methodes api de creation des object qui contient des fichier attachée // 

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


class RapportData {
  String description; 
  int docteur_id;
  RapportData(this.description, this.docteur_id );
  Map toJson() {
    return {'description' : description,
            'docteur' : docteur_id,};
  }
}

class AnalyseData { 
  String description; 
  String nomLaboratoire  ;
  int type  ;
  int analyste_id; 
  int patient_id ;
  int docteur_id ;
  AnalyseData(this.description, this.nomLaboratoire, this.type, this.analyste_id , this.docteur_id , this.patient_id);
  Map toJson() {
    return {'description' : description,
            'nomLaboratoire' : nomLaboratoire,
            "type" : type,
            "analyste" : analyste_id,
            'patient' : patient_id,
            'docteur' : docteur_id,};
  }
}




class ImageRadioData { 
  String description; 
  String nomLaboratoire  ;
  int radiologue_id; 
  int patient_id ;
  int docteur_id ;
  ImageRadioData(this.description, this.nomLaboratoire, this.radiologue_id , this.docteur_id , this.patient_id);
  Map toJson() {
    return {'description' : description,
            'nomLaboratoire' : nomLaboratoire,
            "radiologue" : radiologue_id,
            'patient' : patient_id,
            'docteur' : docteur_id,};
  }
}

// *************************************************************************** */

//******* classes utilisée pour la récupération de données a partir de l'api ********/

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

    // description 
    // nomLaboratoire 
    // donnee 
    // type  
    // analyste 
    // patient 
    // docteur 
    // updated 
    // created 

class Analyse{
  final int id;
  final String description;
  final String nomLaboratoire;
  final String donnees;
  final type;
  final int analyste_id;
  final int patient_id;
  final int docteur_id;
  final String updated;
  final String created;

  const Analyse({
    required this.id,
    required this.description , 
    required this.nomLaboratoire,
    required this.donnees,
    required this.type,
    required this.analyste_id,
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
      nomLaboratoire: json['nomLaboratoire'],
      donnees : json['donnee'],
      type: json['type'],
      analyste_id: json['analyste'],
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
      description : json['consDescription'],
      ordonnance_id: json['ordonnance'],
      patient_id : json['patient'],
      docteur_id : json['docteur'],
      created : json['created'],
      updated : json['updated'],
    );
  }

}



class RapportMedical{

  final int id;
  final String description;
  final String donnees;
  final int patient_id;
  final int docteur_id;
  final String updated;
  final String created;

  const RapportMedical({
    required this.id,
    required this.description , 
    required this.patient_id,
    required this.docteur_id,
    required this.donnees,
    required this.created,
    required this.updated,
  });

  Map<String , dynamic> toJson() => {
            'description' : description,
            'donnees' : donnees,
            'patient' : patient_id,
            'docteur' : docteur_id,
  };
  
 factory RapportMedical.fromJson(Map<String, dynamic> json) {
    return RapportMedical(
      id : json['id'],
      description : json['descriptionRapport'],
      donnees : json['donnee'],
      patient_id : json['patient'],
      docteur_id : json['docteur'],
      created : json['created'],
      updated : json['updated'],
    );
  }

}