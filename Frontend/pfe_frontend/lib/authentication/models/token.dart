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

  factory Token.fromJson(Map<String, dynamic> json) {
    return Token(
      accessToken: json['access'],
      refreshToken : json['refresh'],
    );
  }
}
