import 'package:flutter/material.dart';
import 'package:pfe_frontend/authentication/models/user.dart';

class Reservation{
  final int id;
  final DateTime dateRendezvous;
  final TimeOfDay startTime;
  final TimeOfDay endTime ;
  final int patient_id;
  final int docteur_id;
  final bool disponible; 

  const Reservation({
    required this.id,
    required this.dateRendezvous , 
    required this.startTime,
    required this.endTime,
    required this.patient_id,
    required this.docteur_id,
    required this.disponible,
  });

  Map<String , dynamic> toJson() => {
            'dateRendezvous' : dateRendezvous,
            'startTime' : startTime,
            'endTime' : endTime,
            'patient' : patient_id,
            'docteur' : docteur_id,
            'disponible' : disponible,
  };

 factory Reservation.fromJson(Map<String, dynamic> json) {
    return Reservation(
      id : json['id'],
      dateRendezvous: json['dateRendezvous'],
      startTime : json['startTime'],
      endTime : json['endTime'],
      patient_id : json['patient'],
      docteur_id : json['docteur'],
      disponible : json['disponible'],
    );
  }
 
}