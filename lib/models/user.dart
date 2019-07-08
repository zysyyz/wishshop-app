import './jwt_token.dart';

class User {
  final int id;
  String email;
  String username;
  String name;
  bool useGravatar;
  String avatarUrl;
  int age;
  String gender;
  String birthday;
  String company;
  String website;
  String bio;
  bool siteAdmin = false;
  JwtToken jwtToken;
  String deletedAt;
  String createdAt;
  String updatedAt;

  User({
    this.id,
    this.email,
    this.username,
    this.name,
    this.useGravatar,
    this.avatarUrl,
    this.age,
    this.gender,
    this.birthday,
    this.company,
    this.website,
    this.bio,
    this.siteAdmin,
    this.jwtToken,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    JwtToken jwtToken;
    if (json['jwtToken'] != null) {
      jwtToken = JwtToken.fromJson(json['jwtToken']);
    }
    return User(
      id              : json['id'],
      email           : json['email'],
      username        : json['username'],
      name            : json['name'],
      useGravatar     : json['useGravatar'],
      avatarUrl       : json['avatarUrl'],
      age             : json['age'],
      gender          : json['gender'],
      birthday        : json['birthday'],
      company         : json['company'],
      website         : json['website'],
      bio             : json['bio'],
      jwtToken        : jwtToken,
      deletedAt       : json['deletedAt'],
      createdAt       : json['createdAt'],
      updatedAt       : json['updatedAt'],
    );
  }

  Map<String, dynamic> toJson() =>
    {
      'id'            : id,
      'email'         : email,
      'username'      : username,
      'name'          : name,
      'useGravatar'  : useGravatar,
      'avatarUrl'    : avatarUrl,
      'age'           : age,
      'gender'        : gender,
      'birthday'      : birthday,
      'company'       : company,
      'website'       : website,
      'bio'           : bio,
      'jwtToken'     : jwtToken != null ? jwtToken.toJson() : null,
      'deletedAt'    : deletedAt,
      'createdAt'    : createdAt,
      'updatedAt'    : updatedAt,
    };
}
