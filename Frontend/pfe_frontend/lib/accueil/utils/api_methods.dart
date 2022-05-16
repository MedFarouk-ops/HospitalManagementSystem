import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http/http.dart' ;
import 'dart:io' show Platform;



import 'package:flutter/foundation.dart';
import 'package:pfe_frontend/admin/utils/dimensions.dart';
import 'package:pfe_frontend/authentication/models/user.dart';

class ApiMethods {

      // static Future<HttpRequest> postFormData(String url, Map<String, String> data,
      //     {bool? withCredentials,
      //     String? responseType,
      //     Map<String, String>? requestHeaders,
      //     void onProgress(ProgressEvent e)?}) {
      //   var parts = [];
      //   data.forEach((key, value) {
      //     parts.add('${Uri.encodeQueryComponent(key)}='
      //         '${Uri.encodeQueryComponent(value)}');
      //   });
      //   var formData = parts.join('&');

      //   if (requestHeaders == null) {
      //     requestHeaders = <String, String>{};
      //   }
      //   requestHeaders.putIfAbsent('Content-Type',
      //       () => 'application/x-www-form-urlencoded; charset=UTF-8');

      //   return HttpRequest.request(url,
      //       method: 'POST',
      //       withCredentials: withCredentials,
      //       responseType: responseType,
      //       requestHeaders: requestHeaders,
      //       sendData: formData,
      //       onProgress: onProgress);
      // }


      Future<List<User>> getDoctors() async {
        List response ;
        List<User> doctorList = [];
        Client client = http.Client();
        // si l'application est lancée dans le web ( navigateur ) : 
        if (kIsWeb) {
          response = json.decode((await client.get(Uri.parse("${serverUrl}/adminapp/doctors/"))).body);
          response.forEach((element) {
            doctorList.add(User.fromJson(element));
          });
        }
        // si l'application est lancée sur mobile ( android )
        else if(Platform.isAndroid) {
          response = json.decode((await client.get(Uri.parse("${mobileServerUrl}/adminapp/doctors/"))).body);
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
        // si l'application est lancée dans le web ( navigateur ) : 
       if (kIsWeb) {
        response = json.decode((await client.get(Uri.parse("${serverUrl}/adminapp/patients/"))).body);
        response.forEach((element) {
        patientList.add(User.fromJson(element));
          });
        }
        // si l'application est lancée sur mobile ( android )

        else if(Platform.isAndroid) {
          response = json.decode((await client.get(Uri.parse("${mobileServerUrl}/adminapp/patients/"))).body);
          response.forEach((element) {
            patientList.add(User.fromJson(element));
          });
        }
          return patientList ;
        }
} 