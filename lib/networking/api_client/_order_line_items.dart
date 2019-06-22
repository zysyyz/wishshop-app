import 'dart:async';
import 'package:dio/dio.dart';
import 'package:wishshop_app/models/order_line_item.dart';
import '../../exports.dart';

class OrderLineItemsService {
  final Dio _http;

  var _storeId;
  var _orderNumber;
  var _orderLineItemId;

  OrderLineItemsService(this._http);

  void setStoreId(id) {
    this._storeId = id;
  }

  void setOrderNumber(number) {
    this._orderNumber = number;
  }

  void setOrderLineItemId(id) {
    this._orderLineItemId = id;
  }

  Future<Result<Product>> list({
    page = 1,
    perPage = 20,
    categoryId,
  }) async {
    final response = await _http.get(
      '/stores/$_storeId/orders/$_orderNumber/items',
      queryParameters: {
        'page': page,
        'per_page': perPage,
      },
    );

    Result<Product> result = Result<Product>.fromJson(
      response.data,
      (json) => Product.fromJson(json)
    );
    return result;
  }

  Future<OrderLineItem> create({ label }) async {
    final response = await _http.post('/stores/$_storeId/orders/$_orderNumber/items', data: {
      'label': label,
    });

    var d = OrderLineItem.fromJson(response.data['data']);
    return d;
  }

  Future<OrderLineItem> update({ label }) async {
    final response = await _http.patch('/stores/$_storeId/orders/$_orderNumber/items/$_orderLineItemId', data: {
      'label': label,
    });

    var d = OrderLineItem.fromJson(response.data['data']);
    return d;
  }

  Future<bool> delete() async {
    final response = await _http.delete('/stores/$_storeId/orders/$_orderNumber/items/$_orderLineItemId');
    return response.statusCode == 204 || response.statusCode == 200;
  }
}
