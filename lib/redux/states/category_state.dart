import '../../models/models.dart';

class CategoryState {
  Map<String, List<Category>> listByFilter = Map();

  CategoryState({
    this.listByFilter,
  }) {
    if (listByFilter == null) listByFilter = new Map();
  }

  static CategoryState fromJson(dynamic json) {
    if (json == null) {
      return new CategoryState();
    }

    Map<String, List<Category>> listByFilter = Map();
    if (json['listByFilter'] != null) {
      Map<String, dynamic> map = json['listByFilter'] as Map;
      for (var key in map.keys) {
        Iterable l = json['listByFilter'][key] as List;
        List<Category> categories = l.map((item) => Category.fromJson(item)).toList();

        listByFilter.putIfAbsent(key, () => categories);
      }
    }

    return CategoryState(
      listByFilter  : listByFilter,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'listByFilter' : listByFilter,
    };
  }
}
