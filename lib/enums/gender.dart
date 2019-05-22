enum Gender {
  secrecy, male, female,
}

final _friendlyGenders = {
  Gender.secrecy: '保密',
  Gender.male   : '男',
  Gender.female : '女',
};

String toFriendlyGender(gender) {
  if (gender is String) {
    switch (gender) {
      case 'secrecy': gender = Gender.secrecy;  break;
      case 'male'   : gender = Gender.male;     break;
      case 'female' : gender = Gender.female;   break;
    }
  }
  return _friendlyGenders[gender];
}
