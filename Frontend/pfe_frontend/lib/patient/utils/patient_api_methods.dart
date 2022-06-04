import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart';
import 'dart:io' show Platform;

import 'package:http/http.dart' as http;
import 'package:pfe_frontend/accueil/models/reservation.dart';
import 'package:pfe_frontend/admin/utils/dimensions.dart';
import 'package:pfe_frontend/docteur/models/doctor_api_models.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PatientApiMethod{

        /***************************************** Reservation ************************************************/
        
        Future<List<Reservation>> getPatientTodayReservationList(int id) async {
            List response ;
            List<Reservation> reservationsList = [];
            Client  client = http.Client();
            String apiUrl = "";
            SharedPreferences s_prefs = await SharedPreferences.getInstance();
            String token = s_prefs.getStringList("authTokens")![0];
            if (kIsWeb) { apiUrl = serverUrl ;}
            else if(Platform.isAndroid) { apiUrl = mobileServerUrl ; }
            response = json.decode((await client.get(Uri.parse("${apiUrl}/api/reservations/patient/$id/") , headers: {'Authorization': 'Bearer $token',})).body);
                response.forEach((element) {
                if(Reservation.fromJson(element).dateRendezvous == DateTime.now().toString().substring(0,10) ){
                  reservationsList.add(Reservation.fromJson(element));
                }
            });
          return reservationsList ;
        }

         Future<List<Reservation>> getPatientReservationList(int id) async {
            List response ;
            List<Reservation> reservationsList = [];
            Client client = http.Client();
            String apiUrl = "";
            SharedPreferences s_prefs = await SharedPreferences.getInstance();
            String token = s_prefs.getStringList("authTokens")![0];
            if (kIsWeb) { apiUrl = serverUrl ;}
            else if(Platform.isAndroid) { apiUrl = mobileServerUrl ; }
            response = json.decode((await client.get(Uri.parse("${apiUrl}/api/reservations/patient/$id/") , headers: {'Authorization': 'Bearer $token',} )).body);
                response.forEach((element) {
                  reservationsList.add(Reservation.fromJson(element));
            });
          return reservationsList ;
        }
        //************************************************** Consultations ***************************************************************** */

          Future<List<Consultation>> getPatientConsList(int id) async {
            List response ;
            List<Consultation> consList = [];
            Client client = http.Client();
            SharedPreferences s_prefs = await SharedPreferences.getInstance();
            String token = s_prefs.getStringList("authTokens")![0];
            // si l'application est lancée dans le web ( navigateur ) : 
            if (kIsWeb) {
              response = json.decode((await client.get(Uri.parse("${serverUrl}/api/consultations/patient/$id") , headers: {'Authorization': 'Bearer $token',})).body);
              response.forEach((element) {
                consList.add(Consultation.fromJson(element));
              });
            }
            // si l'application est lancée sur mobile ( android )
            else if(Platform.isAndroid) {
              response = json.decode((await client.get(Uri.parse("${mobileServerUrl}/api/consultations/patient/$id") , headers: {'Authorization': 'Bearer $token',})).body);
              response.forEach((element) {
                consList.add(Consultation.fromJson(element));
              });        
          }
          return consList ;
        } 
        /*********************************************************************************************************************************** */

        Future<List<Ordonnance>> getPatientOrdonnanceList(int id) async {
            List response ;
            List<Ordonnance> ordonnancesList = [];
            Client client = http.Client();
            SharedPreferences s_prefs = await SharedPreferences.getInstance();
            String token = s_prefs.getStringList("authTokens")![0];
            // si l'application est lancée dans le web ( navigateur ) : 
            if (kIsWeb) {
              response = json.decode((await client.get(Uri.parse("${serverUrl}/api/ordonnances/patient/$id") , headers: {'Authorization': 'Bearer $token',})).body);
              response.forEach((element) {
                ordonnancesList.add(Ordonnance.fromJson(element));
              });
            }
            // si l'application est lancée sur mobile ( android )
            else if(Platform.isAndroid) {
              response = json.decode((await client.get(Uri.parse("${mobileServerUrl}/api/ordonnances/patient/$id") ,headers: {'Authorization': 'Bearer $token',})).body);
              response.forEach((element) {
                ordonnancesList.add(Ordonnance.fromJson(element));
              });        
          }
          return ordonnancesList ;
        }




}