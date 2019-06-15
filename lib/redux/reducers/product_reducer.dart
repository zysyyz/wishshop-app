import 'package:redux/redux.dart' as redux;
import '../../models/models.dart';
import '../actions/product_actions.dart';
import '../states/product_state.dart';

final productReducer = redux.combineReducers<ProductState>([
  redux.TypedReducer<ProductState, ReceiveProductListAction>(_receiveProductList),
  redux.TypedReducer<ProductState, ReceiveProductAction>(_receiveProduct),
]);

ProductState _receiveProductList(ProductState state, ReceiveProductListAction action) {
  String filter = "categoryId=${action.categoryId}";
  if (state.listByFilter == null) {
    state.listByFilter = new Map();
  }

  List<Product> products = state.listByFilter[filter] ?? [];
  if (action.result.pagination.currentPage == 1) {
    products = action.result.items;
  } else {
    products = []
      ..addAll(products)
      ..addAll(action.result.items);
  }

  state.listByFilter.update(
    filter,
    (v) => products,
    ifAbsent: () => products
  );
  return state;
}

ProductState _receiveProduct(ProductState state, ReceiveProductAction action) {
  if (state.map == null) {
    state.map = new Map();
  }
  state.map.update(
    "${action.product.id}",
    (v) => action.product,
    ifAbsent: () => action.product
  );
  return state;
}

