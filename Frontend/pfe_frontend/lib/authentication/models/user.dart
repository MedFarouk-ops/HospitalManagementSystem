
import 'package:pfe_frontend/authentication/models/token.dart';

class User{
  final int id;
  final String username;
  final String email;
  final String first_name ;
  final String last_name;
  final String address;
  final String mobilenumber;
  final String specialite;
  final String age; 
  final genre ; 
  final role ; 

  const User({
    required this.id,
    required this.email , 
    required this.first_name,
    required this.last_name,
    required this.address,
    required this.mobilenumber,
    required this.specialite,
    required this.age,
    required this.genre,
    required this.role,    
    required this.username,
  });

  Map<String , dynamic> toJson() => {
            'id':id,
            'username' : username,
            'email' : email,
            'first_name' : first_name,
            'last_name' : last_name,
            'mobilenumber' : mobilenumber,
            'address' : address,
            'age' : age,
            'genre' : genre,
            'role' : role,
  };

 factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id : json['id'],
      username: json['username'],
      first_name : json['first_name'],
      last_name : json['last_name'],
      address : json['address'],
      mobilenumber : json['mobilenumber'],
      age : json['age'],
      genre : json['genre'],
      specialite: json['specialite'],
      role : json['role'],
      email: json['email'],
    );
  }

  int getUserId(){
    return this.id;
  }
 
}