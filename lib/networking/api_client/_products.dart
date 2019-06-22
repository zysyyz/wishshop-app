import 'dart:async';
import 'package:dio/dio.dart';
import '../../exports.dart';
import './_reviews.dart';

class ProductsService {
  final Dio _http;

  var _storeId;
  var _productId;

  ReviewsService     _reviewsService;

  ProductsService(this._http) {
    this._reviewsService = new ReviewsService(_http);
  }

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
        'include': ['contents', 'modifiers.options'],
      },
    );

    var d = Product.fromJson(response.data['data']);
    return d;
  }

  ReviewsService get reviews {
    _reviewsService.setStoreId(_storeId);
    _reviewsService.setProductId(_productId);
    _reviewsService.setReviewId(0);
    return _reviewsService;
  }

  ReviewsService review(id) {
    _reviewsService.setStoreId(_storeId);
    _reviewsService.setProductId(_productId);
    _reviewsService.setReviewId(id);
    return _reviewsService;
  }
}
