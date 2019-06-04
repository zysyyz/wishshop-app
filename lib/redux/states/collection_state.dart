import '../../models/models.dart';

class CollectionState {
  Map<String, List<Collection>> listByFilter = Map();
  Map<String, Collection> mapById = Map();

  CollectionState({
    this.listByFilter,
    this.mapById,
  }) {
    if (listByFilter == null) listByFilter = new Map();
    if (mapById == null) mapById = new Map();
  }

  static CollectionState fromJson(dynamic json) {
    if (json == null) {
      return new CollectionState();
    }

    Map<String, List<Collection>> listByFilter = Map();
    if (json['listByFilter'] != null) {
      Map<String, dynamic> map = json['listByFilter'] as Map;
      for (var key in map.keys) {
        Iterable l = json['listByFilter'][key] as List;
        List<Collection> collections = l.map((item) => Collection.fromJson(item)).toList();

        listByFilter.putIfAbsent(key, () => collections);
      }
    }

    return CollectionState(
      listByFilter  : listByFilter,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'listByFilter' : listByFilter,
    };
  }
}
