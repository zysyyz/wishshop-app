import 'dart:async';
import 'package:dio/dio.dart';
import 'package:wishshop_app/models/collection.dart';

import '../../models/models.dart';

class CollectionsService {
  final Dio _http;

  var _storeId;
  var _categoryId;

  CollectionsService(this._http);

  void setStoreId(id) {
    this._storeId = id;
  }

  void setCollectionId(id) {
    this._categoryId = id;
  }

  Future<Result<Collection>> list({page = 1, perPage = 20}) async {
    final response = await _http.get(
      '/stores/$_storeId/collections',
      queryParameters: {
        'page': page,
        'per_page': perPage,
        'include': ['items']
      },
    );

    Result<Collection> result = Result<Collection>.fromJson(
      response.data,
      (json) => Collection.fromJson(json)
    );
    return result;
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
