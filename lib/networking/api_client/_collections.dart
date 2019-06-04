import 'dart:async';
import 'package:wishshop_app/models/collection.dart';

import '../../models/models.dart';

class CollectionsService {
  final _http;

  var _storeId;
  var _categoryId;

  CollectionsService(this._http);

  void setStoreId(id) {
    this._storeId = id;
  }

  void setCollectionId(id) {
    this._categoryId = id;
  }

  Future<List<Collection>> list({page = 1, perPage = 20}) async {
    final response = await _http.get(
      '/stores/$_storeId/collections',
      queryParameters: {
        'page': page, 
        'per_page': perPage,
        'include': ['items']
      },
    );
    Iterable l = response.data['items'] as List;

    var _items = l.map((item) => Collection.fromJson(item)).toList();
    return _items;
  }

  Future<Collection> get() async {
    final response = await _http.get(
      '/stores/$_storeId/collections/$_categoryId', 
      queryParameters: {
        'include': ['items']
      },
    );

    var d = Collection.fromJson(response.data['data']);
    return d;
  }
}
