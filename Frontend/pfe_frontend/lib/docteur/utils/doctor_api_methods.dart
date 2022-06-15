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
import 'package:shared_preferences/shared_preferences.dart';

class DoctorApiMethods{

    // ***************************************************Partie reservation et consultation ************************************************//

        Future<List<Reservation>> getDoctorTodayReservationList(int id) async {
            List response ;
            List<Reservation> reservationsList = [];
            Client client = http.Client();
            SharedPreferences s_prefs = await SharedPreferences.getInstance();
            String token = s_prefs.getStringList("authTokens")![0];
            String apiUrl = "";
            if (kIsWeb) { apiUrl = serverUrl ;}
            else if(Platform.isAndroid) { apiUrl = mobileServerUrl ; }
            response = json.decode((await client.get(Uri.parse("${apiUrl}/api/reservations/doctor/$id/") ,  headers: {'Authorization': 'Bearer $token',} )).body);
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
            SharedPreferences s_prefs = await SharedPreferences.getInstance();
            String token = s_prefs.getStringList("authTokens")![0];
            String apiUrl = "";
            if (kIsWeb) { apiUrl = serverUrl ;}
            else if(Platform.isAndroid) { apiUrl = mobileServerUrl ; }
            response = json.decode((await client.get(Uri.parse("${apiUrl}/api/reservations/doctor/$id/") ,  headers: {'Authorization': 'Bearer $token',})).body);
                response.forEach((element) {
                  reservationsList.add(Reservation.fromJson(element));
            });
          return reservationsList ;
        }

    // Consultations //

     Future<String> creerConsultation({
             required String description, required int ordonnance_id,required int patient_id,required int docteur_id,
          }) async { 
            SharedPreferences s_prefs = await SharedPreferences.getInstance();
            String token = s_prefs.getStringList("authTokens")![0];
            String res = "some error occured";
            late http.Response response;
            print('creation en cours ......');

            if (kIsWeb) {
                response = await http.post(Uri.parse("$serverUrl/api/consultations/create/") , body: 
                jsonEncode(<String, dynamic>{
                  "description": description,
                  "patient" :  patient_id , 
                  "docteur" :  docteur_id ,
                  "ordonnanceData" : ordonnance_id
              }) , headers: { 'Content-Type':  "application/json" , 'Authorization': 'Bearer $token'}
              ); 

            } else if(Platform.isAndroid) {
              print("ord id dddddd = " );
              print(ordonnance_id);

            response = await http.post(Uri.parse("$mobileServerUrl/api/consultations/create/") , body: 
              jsonEncode(<String, dynamic>{
                "description": description,
                "patient" :  patient_id , 
                "docteur" :  docteur_id ,
                "ordonnanceData" : ordonnance_id
              }) , headers: { 'Content-Type':  "application/json" , 'Authorization': 'Bearer $token' }
              ); 
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



        //***************************  Get doctor's consultation ******************************//

        Future<List<Consultation>> getDoctorConsList(int id) async {
            List response ;
            List<Consultation> consList = [];
            Client client = http.Client();
            SharedPreferences s_prefs = await SharedPreferences.getInstance();
            String token = s_prefs.getStringList("authTokens")![0];
            // si l'application est lancée dans le web ( navigateur ) : 
            if (kIsWeb) {
              response = json.decode((await client.get(Uri.parse("${serverUrl}/api/consultations/doctor/$id") ,  headers: {'Authorization': 'Bearer $token',} )).body);
              response.forEach((element) {
                consList.add(Consultation.fromJson(element));
              });
            }
            // si l'application est lancée sur mobile ( android )
            else if(Platform.isAndroid) {
              response = json.decode((await client.get(Uri.parse("${mobileServerUrl}/api/consultations/doctor/$id") ,  headers: {'Authorization': 'Bearer $token',})).body);
              response.forEach((element) {
                consList.add(Consultation.fromJson(element));
              });        
          }
          return consList ;
        } 




    
    // ************************************************* Partie Ordonnances *******************************************************/
    
      Future<Ordonnance> creerOrdonnance(File imageFile , String descr ,int patient_id , int docteur_id , ) async {
        Ordonnance ord = Ordonnance(id: 0, description: "", donnees: "", patient_id: 0, docteur_id: 0, created: "", updated: "") ; 
        String apiServerUrl = "";
        SharedPreferences s_prefs = await SharedPreferences.getInstance();
        String token = s_prefs.getStringList("authTokens")![0];
 

          if (kIsWeb) {apiServerUrl = serverUrl ; }
          else if(Platform.isAndroid) { apiServerUrl = mobileServerUrl ; }
            String resultat = "error occured ..." ;
            // open a bytestream
            var stream = new http.ByteStream(DelegatingStream.typed(imageFile.openRead()));
            // get file length
            var length = await imageFile.length();
            // string to uri
            var uri = Uri.parse("$apiServerUrl/api/ordonnances/create/" );
            // create multipart request
            var request = new http.MultipartRequest("POST", uri);
            // multipart that takes file
            var multipartFile = new http.MultipartFile("ordonnanceData", stream, length,
                filename: basename(imageFile.path));
            // add file to multipart
            request.files.add(multipartFile);

            OrdonnanceData ordData = OrdonnanceData(descr, docteur_id, patient_id);

            request.fields["data"] = jsonEncode(ordData);
            request.headers['authorization'] = 'Bearer $token';

            // send
            var response = await request.send();
            print(response.statusCode);
            //******************************************************************************** */ 
            if(response.statusCode == 200)
            {
              ord = Ordonnance.fromJson(jsonDecode(await response.stream.bytesToString()));
              resultat = "success" ;}
            else {
              resultat = "some error occured";
             }
            //******************************************************************************** */
            // listen for response
            // response.stream.transform(utf8.decoder).listen((value) {
            //   print(value);
            // });
          return ord;
        }

 
        Future<List<Ordonnance>> getOrdonnanceList() async {
            List response ;
            List<Ordonnance> ordonnancesList = [];
            Client client = http.Client();
            SharedPreferences s_prefs = await SharedPreferences.getInstance();
            String token = s_prefs.getStringList("authTokens")![0];
            // si l'application est lancée dans le web ( navigateur ) : 
            if (kIsWeb) {
              response = json.decode((await client.get(Uri.parse("${serverUrl}/api/ordonnances/") , headers: {'Authorization': 'Bearer $token',})).body);
              response.forEach((element) {
                ordonnancesList.add(Ordonnance.fromJson(element));
              });
            }
            // si l'application est lancée sur mobile ( android )
            else if(Platform.isAndroid) {
              response = json.decode((await client.get(Uri.parse("${mobileServerUrl}/api/ordonnances/") , headers: {'Authorization': 'Bearer $token',})).body);
              response.forEach((element) {
                ordonnancesList.add(Ordonnance.fromJson(element));
              });        
          }
          return ordonnancesList ;
        }


        Future<List<Ordonnance>> getDoctorOrdonnanceList(int id) async {
            List response ;
            List<Ordonnance> ordonnancesList = [];
            Client client = http.Client();
            SharedPreferences s_prefs = await SharedPreferences.getInstance();
            String token = s_prefs.getStringList("authTokens")![0];
            // si l'application est lancée dans le web ( navigateur ) : 
            if (kIsWeb) {
              response = json.decode((await client.get(Uri.parse("${serverUrl}/api/ordonnances/doctor/$id") , headers: {'Authorization': 'Bearer $token',})).body);
              response.forEach((element) {
                ordonnancesList.add(Ordonnance.fromJson(element));
              });
            }
            // si l'application est lancée sur mobile ( android )
            else if(Platform.isAndroid) {
              response = json.decode((await client.get(Uri.parse("${mobileServerUrl}/api/ordonnances/doctor/$id") ,  headers: {'Authorization': 'Bearer $token',})).body);
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
        SharedPreferences s_prefs = await SharedPreferences.getInstance();
        String token = s_prefs.getStringList("authTokens")![0];
        // si l'application est lancée dans le web ( navigateur ) : 
        if (kIsWeb) {
          ordonnances.add(Ordonnance.fromJson(json.decode((await client.get(Uri.parse("${serverUrl}/api/ordonnances/$id") ,headers: {'Authorization': 'Bearer $token',})).body)));
          }
          // si l'application est lancée sur mobile ( android )
          else if(Platform.isAndroid) {
            ordonnances.add(Ordonnance.fromJson(json.decode((await client.get(Uri.parse("${mobileServerUrl}/api/ordonnances/$id") , headers: {'Authorization': 'Bearer $token',})).body)));
          }
          return ordonnances[0];
      }
    
    // ************************************************* Partie Analyses *******************************************************/
    
      
        Future<List<Analyse>> getAnalysesList() async {
            List response ;
            List<Analyse> analyseList = [];
            Client client = http.Client();
            SharedPreferences s_prefs = await SharedPreferences.getInstance();
            String token = s_prefs.getStringList("authTokens")![0];
            // si l'application est lancée dans le web ( navigateur ) : 
            if (kIsWeb) {
              response = json.decode((await client.get(Uri.parse("${serverUrl}/api/analyses/") , headers: {'Authorization': 'Bearer $token',})).body);
              response.forEach((element) {
                analyseList.add(Analyse.fromJson(element));
              });
            }
            // si l'application est lancée sur mobile ( android )
            else if(Platform.isAndroid) {
              response = json.decode((await client.get(Uri.parse("${mobileServerUrl}/api/analyses/") , headers: {'Authorization': 'Bearer $token',})).body);
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
        SharedPreferences s_prefs = await SharedPreferences.getInstance();
        String token = s_prefs.getStringList("authTokens")![0];
        // si l'application est lancée dans le web ( navigateur ) : 
        if (kIsWeb) {
          response = json.decode((await client.get(Uri.parse("${serverUrl}/api/analyses/$id") , headers: {'Authorization': 'Bearer $token',})).body);
          response.forEach((element) {
          analyses.add(Analyse.fromJson(element));
            });
          }
          // si l'application est lancée sur mobile ( android )

          else if(Platform.isAndroid) {
            response = json.decode((await client.get(Uri.parse("${mobileServerUrl}/api/analyses/$id"), headers: {'Authorization': 'Bearer $token',})).body);
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
            SharedPreferences s_prefs = await SharedPreferences.getInstance();
            String token = s_prefs.getStringList("authTokens")![0];
            if (kIsWeb) { apiUrl = serverUrl ; }
            else if(Platform.isAndroid) { apiUrl = mobileServerUrl ; }
            if(apiUrl != ""){
              response = json.decode((await client.get(Uri.parse("${apiUrl}/api/radios/") ,  headers: {'Authorization': 'Bearer $token',})).body);
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
        SharedPreferences s_prefs = await SharedPreferences.getInstance();
        String token = s_prefs.getStringList("authTokens")![0];
        String apiUrl = "";
        if (kIsWeb) {apiUrl = serverUrl ; }
        else if(Platform.isAndroid) { apiUrl = mobileServerUrl ; }
        if(apiUrl != ""){
              response = json.decode((await client.get(Uri.parse("${apiUrl}/api/radios/$id") , headers: {'Authorization': 'Bearer $token',})).body);
              response.forEach((element) {
              radios.add(RadioData.fromJson(element));
        });
        }
          return radios[0];
      }

      /*************************************  Partie gestion de dossier medicale   ***********************************/

      Future<String> creerRapportMedicale(File imageFile , String descr ,int patient_id , int docteur_id , ) async {
        RapportMedical rap = RapportMedical(id: 0, description: "", patient_id: 0, docteur_id: 0, donnees: "", created: "", updated: "") ; 
        String apiServerUrl = "";
        SharedPreferences s_prefs = await SharedPreferences.getInstance();
        String token = s_prefs.getStringList("authTokens")![0];
 

          if (kIsWeb) {apiServerUrl = serverUrl ; }
          else if(Platform.isAndroid) { apiServerUrl = mobileServerUrl ; }
            String resultat = "error occured ..." ;
            // open a bytestream
            var stream = new http.ByteStream(DelegatingStream.typed(imageFile.openRead()));
            // get file length
            var length = await imageFile.length();
            // string to uri
            var uri = Uri.parse("$apiServerUrl/api/rapport-medicale/create/" );
            // create multipart request
            var request = new http.MultipartRequest("POST", uri);
            // multipart that takes file
            var multipartFile = new http.MultipartFile("rapportdata", stream, length,
                filename: basename(imageFile.path));
            // add file to multipart
            request.files.add(multipartFile);

            OrdonnanceData ordData = OrdonnanceData(descr, docteur_id, patient_id);

            request.fields["data"] = jsonEncode(ordData);
            request.headers['authorization'] = 'Bearer $token';

            // send
            var response = await request.send();
            print(response.statusCode);
            //******************************************************************************** */ 
            if(response.statusCode == 200)
            {
              rap = RapportMedical.fromJson(jsonDecode(await response.stream.bytesToString()));
              resultat = "success" ;}
            else {
              resultat = "some error occured";
             }
            //******************************************************************************** */
            // listen for response
            // response.stream.transform(utf8.decoder).listen((value) {
            //   print(value);
            // });
          return resultat;
        }

        // Future<String> updateRapportMedicale(int idRapport , String desc) async {


        // }
      
      Future<List<RapportMedical>> getDoctorRapportsList(int id) async {
            List response ;
            List<RapportMedical> rapList = [];
            Client client = http.Client();
            SharedPreferences s_prefs = await SharedPreferences.getInstance();
            String token = s_prefs.getStringList("authTokens")![0];
            // si l'application est lancée dans le web ( navigateur ) : 
            if (kIsWeb) {
              response = json.decode((await client.get(Uri.parse("${serverUrl}/api/rapport-medicale/doctor/$id") ,  headers: {'Authorization': 'Bearer $token',} )).body);
              response.forEach((element) {
                rapList.add(RapportMedical.fromJson(element));
              });
            }
            // si l'application est lancée sur mobile ( android )
            else if(Platform.isAndroid) {
              response = json.decode((await client.get(Uri.parse("${mobileServerUrl}/api/rapport-medicale/doctor/$id") ,  headers: {'Authorization': 'Bearer $token',})).body);
              response.forEach((element) {
                rapList.add(RapportMedical.fromJson(element));
              });        
          }
          return rapList ;
      }


      Future<List<RapportMedical>> getPatientRapportsList(int id) async {
            List response ;
            List<RapportMedical> rapList = [];
            Client client = http.Client();
            SharedPreferences s_prefs = await SharedPreferences.getInstance();
            String token = s_prefs.getStringList("authTokens")![0];
            // si l'application est lancée dans le web ( navigateur ) : 
            if (kIsWeb) {
              response = json.decode((await client.get(Uri.parse("${serverUrl}/api/rapport-medicale/patient/$id") ,  headers: {'Authorization': 'Bearer $token',} )).body);
              response.forEach((element) {
                rapList.add(RapportMedical.fromJson(element));
              });
            }
            // si l'application est lancée sur mobile ( android )
            else if(Platform.isAndroid) {
              response = json.decode((await client.get(Uri.parse("${mobileServerUrl}/api/rapport-medicale/patient/$id") ,  headers: {'Authorization': 'Bearer $token',})).body);
              response.forEach((element) {
                rapList.add(RapportMedical.fromJson(element));
              });        
          }
          return rapList ;
      }

      Future<String> updateRapportMedicale(File imageFile , String descr , int docteur_id , int id ) async {
        String apiServerUrl = "";
        SharedPreferences s_prefs = await SharedPreferences.getInstance();
        String token = s_prefs.getStringList("authTokens")![0];

          if (kIsWeb) {apiServerUrl = serverUrl ; }
          else if(Platform.isAndroid) { apiServerUrl = mobileServerUrl ; }
            String resultat = "error occured ..." ;
            // open a bytestream
            var stream = new http.ByteStream(DelegatingStream.typed(imageFile.openRead()));
            // get file length
            var length = await imageFile.length();
            // string to uri
            var uri = Uri.parse("$apiServerUrl/api/rapport-medicale/update/$id/" );
            // create multipart request
            var request = new http.MultipartRequest("PUT", uri);
            // multipart that takes file
            var multipartFile = new http.MultipartFile("rapportdata", stream, length,
                filename: basename(imageFile.path));
            // add file to multipart
            request.files.add(multipartFile);

            RapportData ordData = RapportData(descr, docteur_id);

            request.fields["data"] = jsonEncode(ordData);
            request.headers['authorization'] = 'Bearer $token';

            // send
            var response = await request.send();
            print(response.statusCode);
            //******************************************************************************** */ 
            if(response.statusCode == 200)
            {
              resultat = "success" ;}
            else {
              resultat = "some error occured";
             }
            //******************************************************************************** */
            // listen for response
            response.stream.transform(utf8.decoder).listen((value) {
              print(value);
            });
          return resultat;
        }

         Future<String> updateWithoutFileRapport(
            String descr , int docteur_id , int id ,
          ) async { 
            SharedPreferences s_prefs = await SharedPreferences.getInstance();
            String token = s_prefs.getStringList("authTokens")![0];
            String res = "some error occured";
            late http.Response response;
            print('creation en cours ......');

            if (kIsWeb) {
                response = await http.put(Uri.parse("$serverUrl/api/rapport-medicale/update/$id/") , body: 
                jsonEncode(<String, dynamic>{
                  "descriptionRapport": descr,
              }) , headers: { 'Content-Type':  "application/json" , 'Authorization': 'Bearer $token'}
              ); 

            } else if(Platform.isAndroid) {


            response = await http.put(Uri.parse("$mobileServerUrl/api/rapport-medicale/update/$id/") , body: 
              jsonEncode(<String, dynamic>{
                "descriptionRapport": descr,
              }) , headers: { 'Content-Type':  "application/json" , 'Authorization': 'Bearer $token' }
              ); 
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

}