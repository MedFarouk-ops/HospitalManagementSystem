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
import 'package:shared_preferences/shared_preferences.dart';



class RadioApiMethods{

  //************************************** Creer Radio ****************************************//
  
    Future<String> creerRadio(File pdfFile , String description , String nomLaboratoire , int radiologue_id  ,int patient_id , int docteur_id , ) async {

        String result = "not set";
        SharedPreferences s_prefs = await SharedPreferences.getInstance();
        String token = s_prefs.getStringList("authTokens")![0];
        String apiServerUrl = "";
          if (kIsWeb) {apiServerUrl = serverUrl ; }
          else if(Platform.isAndroid) { apiServerUrl = mobileServerUrl ; }
            String resultat = "error occured ..." ;
            // open a bytestream
            var stream = new http.ByteStream(DelegatingStream.typed(pdfFile.openRead()));
            // get file length
            var length = await pdfFile.length();
            // string to uri
            var uri = Uri.parse("$apiServerUrl/api/radios/create/");
            // create multipart request
            var request = new http.MultipartRequest("POST", uri);
            // multipart that takes file
            var multipartFile = new http.MultipartFile("imageradio", stream, length,
                filename: basename(pdfFile.path));
            // add file to multipart
            request.files.add(multipartFile);
            ImageRadioData rdData = ImageRadioData(description, nomLaboratoire, radiologue_id, docteur_id, patient_id);

            request.fields["data"] = jsonEncode(rdData);
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

    //******************** Recuperer la liste de images radio selon :  radiologue id / docteur id / patient id ********************************//

     Future<List<RadioData>> getRadiosByDoctorId(int id) async {
      List response ;
      List<RadioData> radios = []; 
      Client client = http.Client();
      String apiUrl = "";
      SharedPreferences s_prefs = await SharedPreferences.getInstance();
      String token = s_prefs.getStringList("authTokens")![0];
      if (kIsWeb) { apiUrl = serverUrl ;}
      else if(Platform.isAndroid) { apiUrl = mobileServerUrl ; }
      response = json.decode((await client.get(Uri.parse("${apiUrl}/api/radios/doctor/$id/") , headers: {'Authorization': 'Bearer $token',})).body);
                response.forEach((element) {
                  radios.add(RadioData.fromJson(element));
      });
      return radios;
    }

     Future<List<RadioData>> getRadiosByPatientId(int id) async {
      List response ;
      List<RadioData> radios = []; 
      Client client = http.Client();
      String apiUrl = "";
      SharedPreferences s_prefs = await SharedPreferences.getInstance();
      String token = s_prefs.getStringList("authTokens")![0];
      if (kIsWeb) { apiUrl = serverUrl ;}
      else if(Platform.isAndroid) { apiUrl = mobileServerUrl ; }
      response = json.decode((await client.get(Uri.parse("${apiUrl}/api/radios/patient/$id/") , headers: {'Authorization': 'Bearer $token',})).body);
                response.forEach((element) {
                  radios.add(RadioData.fromJson(element));
      });
      return radios;
    }

    Future<List<RadioData>> getRadiosByRadiologueId(int id) async {
      List response ;
      List<RadioData> radios = []; 
      Client client = http.Client();
      String apiUrl = "";
      SharedPreferences s_prefs = await SharedPreferences.getInstance();
      String token = s_prefs.getStringList("authTokens")![0];
      if (kIsWeb) { apiUrl = serverUrl ;}
      else if(Platform.isAndroid) { apiUrl = mobileServerUrl ; }
      response = json.decode((await client.get(Uri.parse("${apiUrl}/api/radios/radiologue/$id/") , headers: {'Authorization': 'Bearer $token',})).body);
                response.forEach((element) {
                  radios.add(RadioData.fromJson(element));
      });
      return radios;
    }

}