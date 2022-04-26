
import 'package:pfe_frontend/authentication/models/token.dart';

class User{
  final String username;
  final String email;
  final String first_name ;
  final String last_name;
  final String address;
  final String age; 
  final genre ; 
  final role ; 

  const User({
    required this.email , 
    required this.first_name,
    required this.last_name,
    required this.address,
    required this.age,
    required this.genre,
    required this.role,    
    required this.username,
  });

  Map<String , dynamic> toJson() => {
            'username' : username,
            'email' : email,
            'first_name' : first_name,
            'last_name' : last_name,
            'address' : address,
            'age' : age,
            'genre' : genre,
            'role' : role,
  };

 factory User.fromJson(Map<String, dynamic> json) {
    return User(
      username: json['username'],
      first_name : json['first_name'],
      last_name : json['last_name'],
      address : json['address'],
      age : json['age'],
      genre : json['genre'],
      role : json['role'],
      email: json['email'],
    );
  }
 
}