import 'dart:async';
import 'package:dio/dio.dart';
import '../../models/models.dart';

class CategoriesService {
  final Dio _http;

  var _storeId;
  var _categoryId;

  CategoriesService(this._http);

  void setStoreId(id) {
    this._storeId = id;
  }

  void setCategoryId(id) {
    this._categoryId = id;
  }

  Future<Result<Category>> list({page = 1, perPage = 20, parentId = ''}) async {
    final response = await _http.get(
      '/stores/$_storeId/categories',
      queryParameters: {
        'page': page,
        'per_page': perPage,
        'parent_id': parentId,
      },
    );

    Result<Category> result = Result<Category>.fromJson(
      response.data,
      (json) => Category.fromJson(json)
    );
    return result;
  }

  Future<Category> get() async {
    final response = await _http.get('/stores/$_storeId/categories/$_categoryId');

    var d = Category.fromJson(response.data['data']);
    return d;
  }
}
