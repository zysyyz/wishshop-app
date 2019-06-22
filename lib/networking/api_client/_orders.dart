import 'dart:async';
import 'package:dio/dio.dart';
import '../../exports.dart';
import './_order_line_items.dart';

class OrdersService {
  final Dio _http;

  var _storeId;
  var _orderNumber;

  OrderLineItemsService _orderLineItemsService;

  OrdersService(this._http) {
    this._orderLineItemsService = new OrderLineItemsService(_http);
  }

  void setStoreId(id) {
    this._storeId = id;
  }

  void setOrderNumber(number) {
    this._orderNumber = number;
  }

  Future<Result<Order>> list({
    page = 1,
    perPage = 20,
    categoryId,
  }) async {
    final response = await _http.get(
      '/stores/$_storeId/orders',
      queryParameters: {
        'page': page,
        'per_page': perPage,
        'category_id': categoryId,
      },
    );

    Result<Order> result = Result<Order>.fromJson(
      response.data,
      (json) => Order.fromJson(json)
    );
    return result;
  }

  Future<Order> get() async {
    final response = await _http.get(
      '/stores/$_storeId/orders/$_orderNumber',
      queryParameters: {
        'include': [],
      },
    );

    var d = Order.fromJson(response.data['data']);
    return d;
  }

  OrderLineItemsService get lineItems {
    _orderLineItemsService.setStoreId(_storeId);
    _orderLineItemsService.setOrderNumber(_orderNumber);
    _orderLineItemsService.setOrderLineItemId(0);
    return _orderLineItemsService;
  }

  OrderLineItemsService lineItem(id) {
    _orderLineItemsService.setStoreId(_storeId);
    _orderLineItemsService.setOrderNumber(_orderNumber);
    _orderLineItemsService.setOrderLineItemId(id);
    return _orderLineItemsService;
  }
}
