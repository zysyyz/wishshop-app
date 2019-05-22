import './jwt_token.dart';

class User {
  final int id;
  String uniqueId;
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
    this.uniqueId,
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
    if (json['jwt_token'] != null) {
      jwtToken = JwtToken.fromJson(json['jwt_token']);
    }
    return User(
      id              : json['id'],
      uniqueId        : json['unique_id'],
      email           : json['email'],
      username        : json['username'],
      name            : json['name'],
      useGravatar     : json['use_gravatar'],
      avatarUrl       : json['avatar_url'],
      age             : json['age'],
      gender          : json['gender'],
      birthday        : json['birthday'],
      company         : json['company'],
      website         : json['website'],
      bio             : json['bio'],
      siteAdmin       : json['site_admin'],
      jwtToken        : jwtToken,
      deletedAt       : json['deleted_at'],
      createdAt       : json['created_at'],
      updatedAt       : json['updated_at'],
    );
  }

  Map<String, dynamic> toJson() =>
    {
      'id'            : id,
      'unique_id'     : uniqueId,
      'email'         : email,
      'username'      : username,
      'name'          : name,
      'use_gravatar'  : useGravatar,
      'avatar_url'    : avatarUrl,
      'age'           : age,
      'gender'        : gender,
      'birthday'      : birthday,
      'company'       : company,
      'website'       : website,
      'bio'           : bio,
      'site_admin'    : siteAdmin,
      'jwt_token'     : jwtToken != null ? jwtToken.toJson() : null,
      'deleted_at'    : deletedAt,
      'created_at'    : createdAt,
      'updated_at'    : updatedAt,
    };
}
