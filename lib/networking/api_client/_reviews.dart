import 'dart:async';
import 'package:dio/dio.dart';

import '../../models/models.dart';

class ReviewsService {
  final Dio _http;

  var _storeId;
  var _productId;
  var _reviewId;

  ReviewsService(this._http);

  void setStoreId(id) {
    this._storeId = id;
  }

  void setProductId(id) {
    this._productId = id;
  }

  void setReviewId(id) {
    this._reviewId = id;
  }

  Future<Result<Review>> list({page = 1, perPage = 20}) async {
    final response = await _http.get(
      '/stores/$_storeId/products/$_productId/reviews',
      queryParameters: {
        'page': page,
        'per_page': perPage,
        'include': ['user'],
      },
    );

    Result<Review> result = Result<Review>.fromJson(
      response.data,
      (json) => Review.fromJson(json)
    );
    return result;
  }

  Future<Review> get() async {
    final response = await _http.get('/stores/$_storeId/reviews/$_reviewId');

    var d = Review.fromJson(response.data['data']);
    return d;
  }

  Future<Review> create({ content }) async {
    final response = await _http.post(
      '/stores/$_storeId/reviews',
      data: {
        'content': content,
      },
    );

    var d = Review.fromJson(response.data['data']);
    return d;
  }

  Future<Review> update({ content }) async {
    final response = await _http.patch(
      '/stores/$_storeId/reviews/$_reviewId',
      data: {
        'content': content,
      },
    );

    var d = Review.fromJson(response.data['data']);
    return d;
  }

  Future<bool> delete() async {
    final response = await _http.delete('/stores/$_storeId/reviews/$_reviewId');
    return response.statusCode == 204 || response.statusCode == 200;
  }
}
