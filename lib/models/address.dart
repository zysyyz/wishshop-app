class Address {
  final int id;
  int storeId;
  int userId;
  String fullName;
  String firstName;
  String lastName;
  String email;
  String phoneNumber;
  String country;
  String province;
  String city;
  String district;
  String line1;
  String line2;
  String postalCode;
  bool asDefault;
  String createdAt;
  String updatedAt;

  Address({
    this.id,
    this.storeId,
    this.userId,
    this.fullName,
    this.firstName,
    this.lastName,
    this.email,
    this.phoneNumber,
    this.country,
    this.province,
    this.city,
    this.district,
    this.line1,
    this.line2,
    this.postalCode,
    this.asDefault,
    this.createdAt,
    this.updatedAt,
  });

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      id              : json['id'],
      storeId         : int.parse(json['storeId'].toString()),
      userId          : json['userId'],
      fullName        : json['fullName'] ?? '',
      firstName       : json['firstName'] ?? '',
      lastName        : json['lastName'] ?? '',
      email           : json['email'] ?? '',
      phoneNumber     : json['phoneNumber'] ?? '',
      country         : json['country'] ?? '',
      province        : json['province'] ?? '',
      city            : json['city'] ?? '',
      district        : json['district'] ?? '',
      line1           : json['line1'] ?? '',
      line2           : json['line2'] ?? '',
      postalCode      : json['postalCode'] ?? '',
      asDefault       : json['asDefault'],
      createdAt       : json['createdAt'],
      updatedAt       : json['updatedAt'],
    );
  }

  Map<String, dynamic> toJson() =>
    {
      'id'            : id,
      'storeId'      : storeId,
      'fullName'     : fullName,
      'firstName'    : firstName,
      'lastName'     : lastName,
      'email'         : email,
      'phoneNumber'  : phoneNumber,
      'country'       : country,
      'province'      : province,
      'city'          : city,
      'district'      : district,
      'line1'         : line1,
      'line2'         : line2,
      'postalCode'   : postalCode,
      'asDefault'    : asDefault,
      'createdAt'    : createdAt,
      'updatedAt'    : updatedAt,
    };
}
