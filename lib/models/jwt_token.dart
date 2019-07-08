class JwtToken {
  String accessToken;
  int expiresIn;

  JwtToken({
    this.accessToken,
    this.expiresIn,
  });

  factory JwtToken.fromJson(Map<String, dynamic> json) {
    return JwtToken(
      accessToken: json['accessToken'],
      expiresIn  : json['expiresIn'],
    );
  }

  Map<String, dynamic> toJson() =>
    {
      'accessToken': accessToken,
      'expiresIn'  : expiresIn
    };
}
