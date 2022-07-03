import 'dart:convert';

import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pfe_frontend/admin/utils/dimensions.dart';
import 'package:pfe_frontend/authentication/models/token.dart';
import 'package:pfe_frontend/authentication/models/user.dart';
import 'package:pfe_frontend/authentication/models/user.dart' as userModel;
import 'package:pfe_frontend/authentication/screens/auth_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io' show Platform;
import 'package:jwt_decode/jwt_decode.dart';
import 'package:flutter/foundation.dart' show kIsWeb;


class AuthContext {

    List<String> authTokens = [];

    User user = User(id:0 ,email: "", first_name: "", last_name: "", address: "",specialite: "", mobilenumber: "0", age: "", genre: "", role: "", username: "");

    // final loading = useState(true);
    
//******************************************************S*I*G*N******I*N******U*S*E*R********************************************************************** */

    Future<User> SignIn({required String email , required String password}) async {
     // initialisation de stockage local : 
                      SharedPreferences s_prefs = await SharedPreferences.getInstance();
                      late http.Response response;
                      print('********************************************************');
                      // si l'application est lancée dans le web ( navigateur ) : 
                      if (kIsWeb) {
                          response = await http.post(
                          Uri.parse('${serverUrl}/auth/token/'),
                          headers: <String, String>{
                            'Content-Type': 'application/json; charset=UTF-8',
                          },
                          body: jsonEncode(<String, String>{
                            'email': email,
                            'password' : password
                          }),
                        );
                      } 
                      // si l'application est lancée sur mobile ( android )
                      
                      else if(Platform.isAndroid) {
                      try {
                        response = await http.post(
                        Uri.parse('${mobileServerUrl}/auth/token/'),
                        headers: <String, String>{
                          'Content-Type': 'application/json; charset=UTF-8',
                        },
                        body: jsonEncode(<String, String>{
                          'email': email,
                          'password' : password
                        }),
                      );}
                      catch (error) {
                          print("Exception has occured");
                      }
                    } 
                    if (response.statusCode == 200) {
                    // If the server did return a 200 response,
                    // then parse the JSON.
                    print("loggeeddd onnn");
                    Token token =  Token.fromJson(jsonDecode(response.body));
                    Map<String, dynamic> payload = Jwt.parseJwt(token.accessToken);
                    // make user from token data :   
                    user = User(
                      id : payload['user_id'],
                      email: payload['email'] ,
                      first_name: payload['nom'],
                      last_name: payload['prenom'], 
                      address: payload['address'], 
                      mobilenumber: payload['mobilenumber'] ,specialite: payload['specialite'],
                      age: payload['age'], 
                      genre: payload['genre'], 
                      role: payload['role'], 
                      username: payload['username'],);
                    // print user data to check everythink work correctly : 
                    authTokens.add(token.accessToken);
                    authTokens.add(token.refreshToken);
                    print(user.username);
                    print(user.address);
                    print(user.age);
                    print(user.email);
                    print(user.first_name);
                    print(user.last_name);
                    print(user.genre);
                    print(user.role);
                    print("----------------------------------------------------------------");
                    // save token to local storage :
                    s_prefs.setStringList("authTokens", authTokens);
                        return user;
                    } 
                    else {
                        return user;
                    }
    }

//*******************************************************R*E*G*I*S*T*E*R***********U*S*E*R********************************************************************** */

    // sign up user 

    Future<User> signUpUser({
      required String email,required String password,
      required String username,required String first_name,
      required String last_name,required String address, required String mobilenumber,
      required String age,required String role,
      required String genre,
    }) async { 
      String res = "some error occured";
      late http.Response response;
      print('registering ......');

      if (kIsWeb) {
          response = await http.post(
          Uri.parse('${serverUrl}/auth/register/'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(<String, String>{
            'email': email,
            'username' : username , 
            'first_name' : first_name , 
            'last_name' : last_name,
            'address' : address , 
            'mobilenumber' : mobilenumber , 
            'age' : age , 
            'role' : role ,
            'genre' : genre , 
            'password' : password
          }),
        );
      } else if(Platform.isAndroid) {
      response = await http.post(
        Uri.parse('${mobileServerUrl}/auth/register/'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'email': email,
          'username' : username , 
          'first_name' : first_name , 
          'last_name' : last_name,
          'address' : address , 
          'mobilenumber' : mobilenumber , 
          'age' : age , 
          'role' : role ,
          'genre' : genre , 
          'password' : password
        }),
      );
    } 
  
    if (response.statusCode == 201) {
    // If the server did return a 201 CREATED response,
      print("user registred successfully ");
      User? authuser = await AuthContext().SignIn(
                email: email,
                password: password,
                );
      return authuser;
      } else {
        return user;
    }
   }

//********************************************************G*E*T******U*S*E*R******D*E*T*A*I*L*S********************************************************************** */


  // get current logged in user details :

  Future<userModel.User> getUserDetails() async {
    SharedPreferences s_prefs = await SharedPreferences.getInstance();
    s_prefs = await SharedPreferences.getInstance();
    List<String>? authtokens = s_prefs.getStringList("authTokens");
    Map<String, dynamic> payload = Jwt.parseJwt(authtokens![0]); 
    User currentUser = User(id:0 ,email: "", first_name: "", last_name: "", address: "", mobilenumber: "0",specialite: "", age: "", genre: "", role: "", username: "");
    try{
      currentUser  = User(
        role: payload["role"], 
        id: payload['user_id'],
        email: payload['email'] ,
        first_name: payload['nom'],
        last_name: payload['prenom'], 
        address: payload['address'], 
        mobilenumber: payload['mobilenumber'] ,
        specialite: payload['specialite'],
        age: payload['age'], 
        genre: payload['genre'], 
        username: payload['username'],
        );
    }on Exception catch (_) {
      print('error occured');
    }

    return currentUser;
  }

//******************************************************L*O*G*O*U*T******U*S*E*R*******F*U*N*C*T*I*O*N***************************************************************** */

// logout user function :
  logoutUser(context) async {
    SharedPreferences s_prefs = await SharedPreferences.getInstance();
    s_prefs.remove("authTokens");
    s_prefs.setBool("isAuthenticated", false);
    s_prefs.setBool("use_fingerprint", false);
    Navigator.of(context)
                  .pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => AuthScreen()
                      )
                  );
  }



//**********************************************************C*R*E*A*T*E*****U*S*E*R********A*D*M*I*N********************************************************************* */

  // create user function for admin dashborad : 

  Future<String> createUser({
      required String email,required String password,
      required String username,required String first_name,
      required String last_name,required String address,
      required String age,required String role,
      required String genre,
    }) async { 
      String res = "some error occured";
      late http.Response response;
      print('registering ......');

      if (kIsWeb) {
          response = await http.post(
          Uri.parse('${serverUrl}/auth/register/'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(<String, String>{
            'email': email,
            'username' : username , 
            'first_name' : first_name , 
            'last_name' : last_name,
            'address' : address , 
            'age' : age , 
            'role' : role ,
            'genre' : genre , 
            'password' : password
          }),
        );
      } else if(Platform.isAndroid) {
      response = await http.post(
        Uri.parse('${mobileServerUrl}/auth/register/'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'email': email,
          'username' : username , 
          'first_name' : first_name , 
          'last_name' : last_name,
          'address' : address , 
          'age' : age , 
          'role' : role ,
          'genre' : genre , 
          'password' : password
        }),
      );
    } 
  
    if (response.statusCode == 201) {
    // If the server did return a 201 CREATED response,
        res = "success" ; 
        return res;
    } 
    else {
       return res;
    }
   }

//***************************************************R*E*F*R*E*S*H*******T*O*K*E*N******************************************************************* */

    updateToken(context) async {
      print("update token called ");
            SharedPreferences s_prefs = await SharedPreferences.getInstance();

            late http.Response response;
              if (kIsWeb) {
                    response = await http.post(
                    Uri.parse('${serverUrl}/auth/token/refresh'),
                    headers: <String, String>{
                            'Content-Type': 'application/json; charset=UTF-8',
                    },
                    body: jsonEncode(<String, String>{
                            'refresh': authTokens[1],
                    }),
                    );
                    } 
                    // si l'application est lancée sur mobile ( android )
                    else if(Platform.isAndroid) {
                    response = await http.post(
                    Uri.parse('${mobileServerUrl}/auth/token/refresh'),
                      headers: <String, String>{
                          'Content-Type': 'application/json; charset=UTF-8',
                      },
                      body: jsonEncode(<String, String>{
                          'refresh': authTokens[1],
                        }),
                    );
                    }

                    Token newtoken =  Token.fromJson(jsonDecode(response.body));
                    
                    if (response.statusCode == 200) {
                      authTokens[0] = newtoken.accessToken; 
                      s_prefs.setStringList("authTokgens", authTokens);
                    }else{
                      logoutUser(context);
                    }
                }

//*************************************************************************************************************************************** */
                // Refresh token every 5 minute //
                

}