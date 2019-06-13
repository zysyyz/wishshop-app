import 'dart:async';
import 'package:dio/dio.dart';

import '../../models/models.dart';

class AddressesService {
  final Dio _http;

  var _storeId;
  var _addressId;

  AddressesService(this._http);

  void setStoreId(id) {
    this._storeId = id;
  }

  void setAddressId(id) {
    this._addressId = id;
  }

  Future<Result<Address>> list({page = 1, perPage = 10}) async {
    final response = await _http.get(
      '/stores/$_storeId/addresses',
      queryParameters: {
        'page': page,
        'per_page': perPage,
      },
    );

    Result<Address> result = Result<Address>.fromJson(
      response.data,
      (json) => Address.fromJson(json)
    );
    return result;
  }

  Future<Address> get() async {
    final response = await _http.get('/stores/$_storeId/addresses/$_addressId');

    var d = Address.fromJson(response.data['data']);
    return d;
  }

  Future<Address> patch({ fullName, phoneNumber, province, city, district, line1 }) async {
    final response = await _http.patch('/stores/$_storeId/addresses/$_addressId', data: {
      'full_name': fullName,
      'phone_number': phoneNumber,
      'province': province,
      'city': city,
      'district': district,
      'line1': line1,
    });

    var d = Address.fromJson(response.data['data']);
    return d;
  }

  Future<Address> create({ fullName, phoneNumber, province, city, district, line1 }) async {
    final response = await _http.post('/stores/$_storeId/addresses', data: {
      'full_name': fullName,
      'phone_number': phoneNumber,
      'province': province,
      'city': city,
      'district': district,
      'line1': line1,
    });

    var d = Address.fromJson(response.data['data']);
    return d;
  }

  Future<bool> delete() async {
    final response = await _http.delete('/stores/$_storeId/addresses/$_addressId');
    return response.statusCode == 204 || response.statusCode == 200;
  }
}
