class Address {
  final int id;
  int storeId = 1;
  int userId = 0;
  int position = 0;
  String fullName = '';
  String firstName = '';
  String lastName = '';
  String email = '';
  String phoneNumber = '';
  String country = '';
  String province = '';
  String city = '';
  String district = '';
  String line1 = '';
  String line2 = '';
  String postalCode = '';
  String createdAt = '';
  String updatedAt = '';

  Address({
    this.id,
    this.storeId,
    this.userId,
    this.position,
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
    this.createdAt,
    this.updatedAt,
  });

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      id              : json['id'],
      storeId         : int.parse(json['store_id'].toString()),
      userId          : json['user_id'],
      position        : json['position'],
      fullName        : json['full_name'] ?? '',
      firstName       : json['first_name'] ?? '',
      lastName        : json['last_name'] ?? '',
      email           : json['email'] ?? '',
      phoneNumber     : json['phone_number'] ?? '',
      country         : json['country'] ?? '',
      province        : json['province'] ?? '',
      city            : json['city'] ?? '',
      district          : json['district'] ?? '',
      line1           : json['line1'] ?? '',
      line2           : json['line2'] ?? '',
      postalCode      : json['postal_code'] ?? '',
      createdAt       : json['created_at'],
      updatedAt       : json['updated_at'],
    );
  }

  Map<String, dynamic> toJson() =>
    {
      'id'            : id,
      'store_id'      : storeId,
      'position'      : position,
      'full_name'     : fullName,
      'first_name'    : firstName,
      'last_name'     : lastName,
      'email'         : email,
      'phone_number'  : phoneNumber,
      'country'       : country,
      'province'      : province,
      'city'          : city,
      'district'        : district,
      'line1'         : line1,
      'line2'         : line2,
      'postal_code'   : postalCode,
      'created_at'    : createdAt,
      'updated_at'    : updatedAt,
    };
}
