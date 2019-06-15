import 'dart:async';
import 'package:dio/dio.dart';
import '../../models/models.dart';

class ProductsService {
  final Dio _http;

  var _storeId;
  var _productId;

  ProductsService(this._http);

  void setStoreId(id) {
    this._storeId = id;
  }

  void setProductId(id) {
    this._productId = id;
  }

  Future<Result<Product>> list({
    page = 1,
    perPage = 20,
    categoryId,
  }) async {
    final response = await _http.get(
      '/stores/$_storeId/products',
      queryParameters: {
        'page': page,
        'per_page': perPage,
        'category_id': categoryId,
      },
    );

    Result<Product> result = Result<Product>.fromJson(
      response.data,
      (json) => Product.fromJson(json)
    );
    return result;
  }

  Future<Product> get() async {
    final response = await _http.get(
      '/stores/$_storeId/products/$_productId',
      queryParameters: {
        'include': ['contents'],
      },
    );

    var d = Product.fromJson(response.data['data']);
    return d;
  }
}
