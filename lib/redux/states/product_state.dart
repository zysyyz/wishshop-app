import '../../models/models.dart';

class ProductState {
  Map<String, List<Product>> listByFilter = Map();
  Map<String, Product> mapById = Map();

  ProductState({
    this.listByFilter,
    this.mapById,
  }) {
    if (listByFilter == null) listByFilter = new Map();
    if (mapById == null) mapById = new Map();
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

    Map<String, Product> mapById = new Map();

    return ProductState(
      listByFilter  : listByFilter,
      mapById  : mapById,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'listByFilter' : listByFilter,
      'mapById': mapById,
    };
  }
}
