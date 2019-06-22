import '../../models/models.dart';

class OrderState {
  Order cartOrder = new Order();
  Map<String, Order> map = Map();
  // Map<String, List<Order>> listByFilter = Map();

  OrderState({
    this.cartOrder,
    this.map,
    // this.listByFilter,
  }) {
    // if (cartOrder == null) cartOrder = new Order();
    if (map == null) map = new Map();
    // if (listByFilter == null) listByFilter = new Map();
  }

  Order get(id) {
    return map['$id'];
  }

  // List<Order> list(String filter) {
  //   return listByFilter[filter] ?? [];
  // }

  static OrderState fromJson(dynamic json) {
    if (json == null) {
      return new OrderState();
    }

    // Map<String, List<Order>> listByFilter = Map();
    // if (json['listByFilter'] != null) {
    //   Map<String, dynamic> map = json['listByFilter'] as Map;
    //   for (var key in map.keys) {
    //     Iterable l = json['listByFilter'][key] as List;
    //     List<Order> orders = l.map((item) => Order.fromJson(item)).toList();

    //     listByFilter.putIfAbsent(key, () => orders);
    //   }
    // }

    Map<String, Order> map = new Map();

    return OrderState(
      cartOrder: new Order(),
      map: map,
      // listByFilter: listByFilter,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'map': map,
      // 'listByFilter': listByFilter,
    };
  }
}
