import '../../models/models.dart';

class AddressState {
  List<Address> list = [];
  Map<String, Address> map = Map();

  AddressState({
    this.list,
    this.map
  });

  static AddressState fromJson(dynamic json) {
    if (json == null) {
      return new AddressState();
    }
    return AddressState(
      list: [],
      map: Map(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'list': list,
      'map': map,
    };
  }
}
