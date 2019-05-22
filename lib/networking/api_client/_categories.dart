import 'dart:async';
import '../../models/models.dart';

class CategoriesService {
  final _http;

  var _categoryId;

  CategoriesService(this._http);

  void setCategoryId(id) {
    this._categoryId = id;
  }

  Future<List<Category>> list({page = 1, perPage = 20, parentId}) async {
    final response = await _http.get(
      '/categories',
      queryParameters: {
        'page': page, 
        'per_page': perPage,
        'parent_id': parentId ?? '',
      },
    );
    Iterable l = response.data['data'] as List;

    var _items = l.map((item) => Category.fromJson(item)).toList();
    return _items;
  }

  Future<Category> get() async {
    final response = await _http.get('/categories/$_categoryId');

    var d = Category.fromJson(response.data['data']);
    return d;
  }
}
