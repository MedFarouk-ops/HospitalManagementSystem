import 'dart:convert';
import 'dart:io';
import 'dart:io' show Platform;

import 'package:flutter/foundation.dart';
import 'package:pfe_frontend/admin/utils/dimensions.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:async/async.dart';
import 'package:path/path.dart';
import 'package:pfe_frontend/docteur/models/doctor_api_models.dart';




class AnalysteApiMethods{

    //***************************************************** Creer Bilan ******************************************************* */

    Future<String> creerBilan(File pdfFile , String description , String nomLaboratoire ,int type, int analyste_id  ,int patient_id , int docteur_id , ) async {
        
        String result = "not set";

        String apiServerUrl = "";
          if (kIsWeb) {apiServerUrl = serverUrl ; }
          else if(Platform.isAndroid) { apiServerUrl = mobileServerUrl ; }
            String resultat = "error occured ..." ;
            // open a bytestream
            var stream = new http.ByteStream(DelegatingStream.typed(pdfFile.openRead()));
            // get file length
            var length = await pdfFile.length();
            // string to uri
            var uri = Uri.parse("$apiServerUrl/api/analyses/create/");
            // create multipart request
            var request = new http.MultipartRequest("POST", uri);
            // multipart that takes file
            var multipartFile = new http.MultipartFile("analysedata", stream, length,
                filename: basename(pdfFile.path));
            // add file to multipart
            request.files.add(multipartFile);

            AnalyseData anlData = AnalyseData(description, nomLaboratoire, type, analyste_id, docteur_id, patient_id);

            request.fields["data"] = jsonEncode(anlData);
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



    //******************** Recuperer la liste de bilan selon le type / analyste id / docteur id / patient id ********************************//

    Future<List<Analyse>> getAnalysesByType(int type) async {
      List response ;
      List<Analyse> analyses = []; 
      Client client = http.Client();
      String apiUrl = "";
      if (kIsWeb) { apiUrl = serverUrl ;}
      else if(Platform.isAndroid) { apiUrl = mobileServerUrl ; }
      response = json.decode((await client.get(Uri.parse("${apiUrl}/api/analyses/type/$type/"))).body);
                response.forEach((element) {
                  analyses.add(Analyse.fromJson(element));
      });
      return analyses;
    }

     Future<List<Analyse>> getAnalysesByDoctorId(int id) async {
      List response ;
      List<Analyse> analyses = []; 
      Client client = http.Client();
      String apiUrl = "";
      if (kIsWeb) { apiUrl = serverUrl ;}
      else if(Platform.isAndroid) { apiUrl = mobileServerUrl ; }
      response = json.decode((await client.get(Uri.parse("${apiUrl}/api/analyses/doctor/$id/"))).body);
                response.forEach((element) {
                  analyses.add(Analyse.fromJson(element));
      });
      return analyses;
    }

     Future<List<Analyse>> getAnalysesByPatientId(int id) async {
      List response ;
      List<Analyse> analyses = []; 
      Client client = http.Client();
      String apiUrl = "";
      if (kIsWeb) { apiUrl = serverUrl ;}
      else if(Platform.isAndroid) { apiUrl = mobileServerUrl ; }
      response = json.decode((await client.get(Uri.parse("${apiUrl}/api/analyses/patient/$id/"))).body);
                response.forEach((element) {
                  analyses.add(Analyse.fromJson(element));
      });
      return analyses;
    }

    Future<List<Analyse>> getAnalysesByAnalysteId(int id) async {
      List response ;
      List<Analyse> analyses = []; 
      Client client = http.Client();
      String apiUrl = "";
      if (kIsWeb) { apiUrl = serverUrl ;}
      else if(Platform.isAndroid) { apiUrl = mobileServerUrl ; }
      response = json.decode((await client.get(Uri.parse("${apiUrl}/api/analyses/analyste/$id/"))).body);
                response.forEach((element) {
                  analyses.add(Analyse.fromJson(element));
      });
      return analyses;
    }

    //********************************************** Recuperer la liste de tout les bilans ***********************************************//




}