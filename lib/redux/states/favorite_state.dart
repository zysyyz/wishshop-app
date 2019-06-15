import '../../models/models.dart';

class FavoriteState {
  List<Favorite> list = [];
  Map<String, Favorite> map = Map();

  FavoriteState({
    this.list,
    this.map
  });

  static FavoriteState fromJson(dynamic json) {
    if (json == null) {
      return new FavoriteState();
    }
    return FavoriteState(
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
