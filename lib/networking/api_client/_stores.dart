import 'dart:async';
import 'package:dio/dio.dart';
import '../../models/models.dart';
import './_addresses.dart';
import './_categories.dart';
import './_collections.dart';
import './_products.dart';

class StoresService {
  final Dio _http;

  var _storeId;

  AddressesService  _addressesService;
  CategoriesService   _categoriesService;
  CollectionsService  _collectionsService;
  ProductsService     _productsService;

  StoresService(this._http) {
    this._categoriesService = new CategoriesService(_http);
    this._collectionsService = new CollectionsService(_http);
    this._productsService = new ProductsService(_http);
    this._addressesService  = new AddressesService(_http);
  }

  void setStoreId(id) {
    this._storeId = id;
  }

  Future<List<Store>> list({page = 1, perPage = 20}) async {
    final response = await _http.get(
      '/stores',
      queryParameters: {
        'page': page,
        'per_page': perPage,
      },
    );
    Iterable l = response.data['items'] as List;

    var _items = l.map((item) => Store.fromJson(item)).toList();
    return _items;
  }

  Future<Store> get() async {
    final response = await _http.get('/stores/$_storeId');

    var d = Store.fromJson(response.data['data']);
    return d;
  }

  AddressesService get addresses {
    _addressesService.setStoreId(_storeId);
    _addressesService.setAddressId(0);
    return _addressesService;
  }

  AddressesService address(id) {
    _addressesService.setStoreId(_storeId);
    _addressesService.setAddressId(id);
    return _addressesService;
  }

  CategoriesService get categories {
    _categoriesService.setStoreId(_storeId);
    _categoriesService.setCategoryId(0);
    return _categoriesService;
  }

  CategoriesService category(id) {
    _categoriesService.setStoreId(_storeId);
    _categoriesService.setCategoryId(id);
    return _categoriesService;
  }

  CollectionsService get collections {
    _collectionsService.setStoreId(_storeId);
    _collectionsService.setCollectionId(0);
    return _collectionsService;
  }

  CollectionsService collection(id) {
    _collectionsService.setStoreId(_storeId);
    _collectionsService.setCollectionId(id);
    return _collectionsService;
  }


  ProductsService get products {
    _productsService.setStoreId(_storeId);
    _productsService.setProductId(0);
    return _productsService;
  }

  ProductsService product(id) {
    _productsService.setStoreId(_storeId);
    _productsService.setProductId(id);
    return _productsService;
  }
}
