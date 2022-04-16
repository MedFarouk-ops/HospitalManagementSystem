class Token{
  final String accessToken ; 
  final String refreshToken ; 

  const Token({
    required this.accessToken , 
    required this.refreshToken,
  });

  Map<String , dynamic> toJson() => {
            'accessToken' : accessToken,
            'refreshToken' : refreshToken,
  };

}

class User{
  final String username;
  final String email;
  final String first_name ;
  final String last_name;
  final String address;
  final String age; 
  final genre ; 
  final role ; 
  final Token tokens ; 

  const User({
    required this.email , 
    required this.first_name,
    required this.last_name,
    required this.address,
    required this.age,
    required this.genre,
    required this.role,    
    required this.username,
    required this.tokens,
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
            'tokens' : tokens
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
      tokens: Token(
        accessToken: json['tokens']['access'].toString(),
        refreshToken: json['tokens']['refresh'].toString()),
      email: json['email'],
    );
  }
  
 
}