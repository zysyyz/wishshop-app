import '../../models/models.dart';

class ProductState {
  Map<String, Product> map = Map();
  Map<String, List<Product>> listByFilter = Map();

  ProductState({
    this.map,
    this.listByFilter,
  }) {
    if (map == null) map = new Map();
    if (listByFilter == null) listByFilter = new Map();
  }

  Product get(id) {
    return map['$id'];
  }

  List<Product> list(String filter) {
    return listByFilter[filter] ?? [];
  }

  static ProductState fromJson(dynamic json) {
    if (json == null) {
      return new ProductState();
    }

    Map<String, List<Product>> listByFilter = Map();
    if (json['listByFilter'] != null) {
      Map<String, dynamic> map = json['listByFilter'] as Map;
      for (var key in map.keys) {
        Iterable l = json['listByFilter'][key] as List;
        List<Product> products = l.map((item) => Product.fromJson(item)).toList();

        listByFilter.putIfAbsent(key, () => products);
      }
    }

    Map<String, Product> map = new Map();

    return ProductState(
      map: map,
      listByFilter: listByFilter,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'map': map,
      'listByFilter': listByFilter,
    };
  }
}
