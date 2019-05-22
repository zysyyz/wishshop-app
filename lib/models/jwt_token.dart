class JwtToken {
  String accessToken;
  int expiresIn;

  JwtToken({
    this.accessToken,
    this.expiresIn,
  });

  factory JwtToken.fromJson(Map<String, dynamic> json) {
    return JwtToken(
      accessToken: json['access_token'],
      expiresIn  : json['expires_in'],
    );
  }

  Map<String, dynamic> toJson() =>
    {
      'access_token': accessToken,
      'expires_in'  : expiresIn
    };
}
