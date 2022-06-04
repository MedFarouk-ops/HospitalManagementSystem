import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart' ;
import 'dart:io' show Platform;



import 'package:flutter/foundation.dart';
import 'package:pfe_frontend/accueil/models/reservation.dart';
import 'package:pfe_frontend/admin/utils/dimensions.dart';
import 'package:pfe_frontend/authentication/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';


class ApiMethods {
      

      Future<List<User>> getDoctors() async {
        List response ;
        List<User> doctorList = [];
        Client client = http.Client();
        SharedPreferences s_prefs = await SharedPreferences.getInstance();
        String token = s_prefs.getStringList("authTokens")![0];
        // si l'application est lancée dans le web ( navigateur ) : 
        if (kIsWeb) {
          response = json.decode((await client.get(Uri.parse("${serverUrl}/adminapp/doctors/") , headers: {
        'Authorization': 'Bearer $token',
        } )).body);
          response.forEach((element) {
            doctorList.add(User.fromJson(element));
          });
        }
        // si l'application est lancée sur mobile ( android )
        else if(Platform.isAndroid) {
          response = json.decode((await client.get(Uri.parse("${mobileServerUrl}/adminapp/doctors/") , headers: {'Authorization': 'Bearer $token',} )).body);
          response.forEach((element) {
            doctorList.add(User.fromJson(element));
          });        
      }
      return doctorList ;
    }


    Future<List<User>> getPatients() async {

        List response ;
        List<User> patientList = [];
        Client client = http.Client();
        SharedPreferences s_prefs = await SharedPreferences.getInstance();
        String token = s_prefs.getStringList("authTokens")![0];
        // si l'application est lancée dans le web ( navigateur ) : 
       if (kIsWeb) {
        response = json.decode((await client.get(Uri.parse("${serverUrl}/adminapp/patients/") , headers: {
        'Authorization': 'Bearer $token',
        } )).body);
        response.forEach((element) {
        patientList.add(User.fromJson(element));
          });
        }
        // si l'application est lancée sur mobile ( android )

        else if(Platform.isAndroid) {
          response = json.decode((await client.get(Uri.parse("${mobileServerUrl}/adminapp/patients/") , headers: {
        'Authorization': 'Bearer $token',
        })).body);
          response.forEach((element) {
            patientList.add(User.fromJson(element));
          });
        }
          return patientList ;
        }

        /******************************************************************************************************************* */


         Future<String> createReservation({
            required DateTime dateRendezvous,required String starttime,
            required String endtime , required int patient_id,
            required int docteur_id,
          }) async { 
            String res = "some error occured";
            late http.Response response;
            print('creation en cours ......');
            SharedPreferences s_prefs = await SharedPreferences.getInstance();
            String token = s_prefs.getStringList("authTokens")![0];

            if (kIsWeb) {
                response = await http.post(Uri.parse("$serverUrl/api/reservations/create/") , body: {
                "date" : dateRendezvous.toString().substring(0,10),
                "startTime" :starttime,
                "endTime" :endtime, 
                "description" :  ' no description for now',
                "patient" : patient_id.toString(),
                "docteur" : docteur_id.toString() , 
                "disponible" : "True"
              } , headers: {'Authorization': 'Bearer $token',} ); 

            } else if(Platform.isAndroid) {
            response = await http.post(Uri.parse("$mobileServerUrl/api/reservations/create/") , body: {
                "date" : dateRendezvous.toString().substring(0,10),
                "startTime" :starttime,
                "endTime" :endtime, 
                "description" :  ' no description for now',
                "patient" : patient_id.toString(),
                "docteur" : docteur_id.toString() , 
                "disponible" : "True"
              } ,   headers: {'Authorization': 'Bearer $token',}); 
          } 
        
          if (response.statusCode == 200) {
          // If the server did return a 201 CREATED response,
              res = "success" ; 
              return res;
          } 
          else { 
            print("erreur .............");
            return res;
          }
        }
        /******************************************************************************************************************* */

        Future<List<Reservation>> getReservationList() async {
            List response ;
            List<Reservation> reservationsList = [];
            Client client = http.Client();
            SharedPreferences s_prefs = await SharedPreferences.getInstance();
            String token = s_prefs.getStringList("authTokens")![0];

            // si l'application est lancée dans le web ( navigateur ) : 
            if (kIsWeb) {
              response = json.decode((await client.get(Uri.parse("${serverUrl}/api/reservations/") ,  headers: {'Authorization': 'Bearer $token',})).body);
              response.forEach((element) {
                print(Reservation.fromJson(element).dateRendezvous);
                reservationsList.add(Reservation.fromJson(element));
              });
            }
            // si l'application est lancée sur mobile ( android )
            else if(Platform.isAndroid) {
              response = json.decode((await client.get(Uri.parse("${mobileServerUrl}/api/reservations/") ,  headers: {'Authorization': 'Bearer $token',})).body);
              response.forEach((element) {
                print(Reservation.fromJson(element).dateRendezvous);
                reservationsList.add(Reservation.fromJson(element));
              });        
          }
          return reservationsList ;
        }

       /******************************************************************************************************************* */
      
      Future<User> getUserById(int id) async {
        List response ;
        List<User> users = [];
        Client client = http.Client();
        SharedPreferences s_prefs = await SharedPreferences.getInstance();
        String token = s_prefs.getStringList("authTokens")![0];

         // si l'application est lancée dans le web ( navigateur ) : 
          if (kIsWeb) {
          users.add(User.fromJson(json.decode((await client.get(Uri.parse("${serverUrl}/adminapp/users/$id") , headers: {'Authorization': 'Bearer $token',})).body)));
          }
          // si l'application est lancée sur mobile ( android )
          else if(Platform.isAndroid) {
              users.add(User.fromJson(json.decode((await client.get(Uri.parse("${mobileServerUrl}/adminapp/users/$id") , headers: {'Authorization': 'Bearer $token',})).body)));
          }
          return users[0];
      }


} 