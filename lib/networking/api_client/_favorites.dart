import 'dart:async';
import 'package:dio/dio.dart';
import '../../models/models.dart';

class FavoritesService {
  final Dio _http;

  var _storeId;
  var _favoriteId;

  FavoritesService(this._http);

  void setStoreId(id) {
    this._storeId = id;
  }

  void setFavoriteId(id) {
    this._favoriteId = id;
  }

  Future<Result<Favorite>> list({page = 1, perPage = 20}) async {
    final response = await _http.get(
      '/stores/$_storeId/favorites',
      queryParameters: {
        'page': '$page',
        'per_page': '$perPage',
        'include': ['product']
      },
    );

    Result<Favorite> result = Result<Favorite>.fromJson(
      response.data,
      (json) => Favorite.fromJson(json)
    );
    return result;
  }

  Future<Favorite> create({
    targetType,
    targetId,
  }) async {
    final response = await _http.post('/stores/$_storeId/favorites', data: {
      'target_type': '$targetType',
      'target_id': '$targetId',
    });

    var d = Favorite.fromJson(response.data['data']);
    return d;
  }

  Future<bool> delete() async {
    final response = await _http.delete('/stores/$_storeId/favorites/$_favoriteId');
    return response.statusCode == 204 || response.statusCode == 200;
  }
}
