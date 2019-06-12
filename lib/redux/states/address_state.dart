import '../../models/models.dart';

class AddressState {
  List<Address> addresses = [];
  Map<String, Address> mapById = Map();

  AddressState({ this.addresses, this.mapById });

  static AddressState fromJson(dynamic json) {
    if (json == null) {
      return new AddressState();
    }
    return AddressState(
      addresses  : [],
      mapById  : Map(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'addresses' : addresses,
      'mapById': mapById,
    };
  }
}
