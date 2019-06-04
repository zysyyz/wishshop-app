import 'dart:async';
import '../../models/models.dart';

class CategoriesService {
  final _http;

  var _storeId;
  var _categoryId;

  CategoriesService(this._http);

  void setStoreId(id) {
    this._storeId = id;
  }

  void setCategoryId(id) {
    this._categoryId = id;
  }

  Future<List<Category>> list({page = 1, perPage = 20, parentId = ''}) async {
    final response = await _http.get(
      '/stores/$_storeId/categories',
      queryParameters: {
        'page': page,
        'per_page': perPage,
        'parent_id': parentId,
      },
    );
    Iterable l = response.data['items'] as List;

    var _items = l.map((item) => Category.fromJson(item)).toList();
    return _items;
  }

  Future<Category> get() async {
    final response = await _http.get('/stores/$_storeId/categories/$_categoryId');

    var d = Category.fromJson(response.data['data']);
    return d;
  }
}
