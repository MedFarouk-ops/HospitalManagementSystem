import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart' ;
import 'dart:io' show Platform;
import 'package:path/path.dart';
import 'package:async/async.dart';
import 'dart:io';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:pfe_frontend/accueil/models/reservation.dart';
import 'package:pfe_frontend/admin/utils/dimensions.dart';
import 'package:pfe_frontend/docteur/models/doctor_api_models.dart';

class DoctorApiMethods{


    // ***************************************************Partie reservation et consultation ************************************************//

        Future<List<Reservation>> getDoctorTodayReservationList(int id) async {
            List response ;
            List<Reservation> reservationsList = [];
            Client client = http.Client();
            String apiUrl = "";
            if (kIsWeb) { apiUrl = serverUrl ;}
            else if(Platform.isAndroid) { apiUrl = mobileServerUrl ; }
            response = json.decode((await client.get(Uri.parse("${apiUrl}/api/reservations/doctor/$id/"))).body);
                response.forEach((element) {
                if(Reservation.fromJson(element).dateRendezvous == DateTime.now().toString().substring(0,10) ){
                  reservationsList.add(Reservation.fromJson(element));
                }
            });
          return reservationsList ;
        }

         Future<List<Reservation>> getDoctorReservationList(int id) async {
            List response ;
            List<Reservation> reservationsList = [];
            Client client = http.Client();
            String apiUrl = "";
            if (kIsWeb) { apiUrl = serverUrl ;}
            else if(Platform.isAndroid) { apiUrl = mobileServerUrl ; }
            response = json.decode((await client.get(Uri.parse("${apiUrl}/api/reservations/doctor/$id/"))).body);
                response.forEach((element) {
                  reservationsList.add(Reservation.fromJson(element));
            });
          return reservationsList ;
        }


    
    // ************************************************* Partie Ordonnances *******************************************************/
    
      Future<String> creerOrdonnance(File imageFile , String descr ,int patient_id , int docteur_id , ) async {
        
        String apiServerUrl = "";
          if (kIsWeb) {apiServerUrl = serverUrl ; }
          else if(Platform.isAndroid) { apiServerUrl = mobileServerUrl ; }
            String resultat = "error occured ..." ;
            // open a bytestream
            var stream = new http.ByteStream(DelegatingStream.typed(imageFile.openRead()));
            // get file length
            var length = await imageFile.length();
            // string to uri
            var uri = Uri.parse("$apiServerUrl/api/ordonnances/create/");
            // create multipart request
            var request = new http.MultipartRequest("POST", uri);
            // multipart that takes file
            var multipartFile = new http.MultipartFile('file', stream, length,
                filename: basename(imageFile.path));
            // add file to multipart
            request.files.add(multipartFile);
            request.fields["data"] = "{'description': $descr , 'patient': $patient_id , 'docteur' : $docteur_id }";
            // send
            var response = await request.send();
            print(response.statusCode);
            //******************************************************************************** */ 
            if(response.statusCode == 200){ resultat ="success" ;}
            else { resultat = "some error occured"; }

            //******************************************************************************** */

            // listen for response
            response.stream.transform(utf8.decoder).listen((value) {
              print(value);
            });
          return resultat;
        }

 
        Future<List<Ordonnance>> getOrdonnanceList() async {
            List response ;
            List<Ordonnance> ordonnancesList = [];
            Client client = http.Client();
            // si l'application est lancée dans le web ( navigateur ) : 
            if (kIsWeb) {
              response = json.decode((await client.get(Uri.parse("${serverUrl}/api/ordonnances/"))).body);
              response.forEach((element) {
                ordonnancesList.add(Ordonnance.fromJson(element));
              });
            }
            // si l'application est lancée sur mobile ( android )
            else if(Platform.isAndroid) {
              response = json.decode((await client.get(Uri.parse("${mobileServerUrl}/api/ordonnances/"))).body);
              response.forEach((element) {
                ordonnancesList.add(Ordonnance.fromJson(element));
              });        
          }
          return ordonnancesList ;
        }


      Future<Ordonnance> getOrdonnanceById(int id) async {
        List response ;
        List<Ordonnance> ordonnances = [];
        Client client = http.Client();
        // si l'application est lancée dans le web ( navigateur ) : 
        if (kIsWeb) {
          response = json.decode((await client.get(Uri.parse("${serverUrl}/api/ordonnances/$id"))).body);
          response.forEach((element) {
          ordonnances.add(Ordonnance.fromJson(element));
            });
          }
          // si l'application est lancée sur mobile ( android )
          else if(Platform.isAndroid) {
            response = json.decode((await client.get(Uri.parse("${mobileServerUrl}/api/ordonnances/$id"))).body);
            response.forEach((element) {
              ordonnances.add(Ordonnance.fromJson(element));
            });
          }
          return ordonnances[0];
      }
    
    // ************************************************* Partie Analyses *******************************************************/
    
      
        Future<List<Analyse>> getAnalysesList() async {
            List response ;
            List<Analyse> analyseList = [];
            Client client = http.Client();
            // si l'application est lancée dans le web ( navigateur ) : 
            if (kIsWeb) {
              response = json.decode((await client.get(Uri.parse("${serverUrl}/api/analyses/"))).body);
              response.forEach((element) {
                analyseList.add(Analyse.fromJson(element));
              });
            }
            // si l'application est lancée sur mobile ( android )
            else if(Platform.isAndroid) {
              response = json.decode((await client.get(Uri.parse("${mobileServerUrl}/api/analyses/"))).body);
              response.forEach((element) {
                analyseList.add(Analyse.fromJson(element));
              });        
          }
          return analyseList ;
        }


    
      Future<Analyse> getAnalyseById(int id) async {
        List response ;
        List<Analyse> analyses = [];
        Client client = http.Client();
        // si l'application est lancée dans le web ( navigateur ) : 
        if (kIsWeb) {
          response = json.decode((await client.get(Uri.parse("${serverUrl}/api/analyses/$id"))).body);
          response.forEach((element) {
          analyses.add(Analyse.fromJson(element));
            });
          }
          // si l'application est lancée sur mobile ( android )

          else if(Platform.isAndroid) {
            response = json.decode((await client.get(Uri.parse("${mobileServerUrl}/api/analyses/$id"))).body);
            response.forEach((element) {
              analyses.add(Analyse.fromJson(element));
            });
          }
          return analyses[0];
      }

    
    
    // ************************************************* Partie Radios *******************************************************/
    

        Future<List<RadioData>> getRadioList() async {
            List response ; 
            List<RadioData> radioList = [];
            Client client = http.Client();
            String apiUrl = "";
            if (kIsWeb) { apiUrl = serverUrl ; }
            else if(Platform.isAndroid) { apiUrl = mobileServerUrl ; }
            if(apiUrl != ""){
              response = json.decode((await client.get(Uri.parse("${apiUrl}/api/radios/"))).body);
              response.forEach((element) {
                  radioList.add(RadioData.fromJson(element));
              });
            }
          return radioList ;
        }



    
      Future<RadioData> getRadioById(int id) async {
        List response ; 
        List<RadioData> radios = [];
        Client client = http.Client();
        String apiUrl = "";
        if (kIsWeb) {apiUrl = serverUrl ; }
        else if(Platform.isAndroid) { apiUrl = mobileServerUrl ; }
        if(apiUrl != ""){
              response = json.decode((await client.get(Uri.parse("${apiUrl}/api/radios/$id"))).body);
              response.forEach((element) {
              radios.add(RadioData.fromJson(element));
        });
        }
          return radios[0];
      }


}