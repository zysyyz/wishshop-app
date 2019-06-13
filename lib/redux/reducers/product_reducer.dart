import 'package:redux/redux.dart' as redux;
import '../../models/models.dart';
import '../actions/product_actions.dart';
import '../states/product_state.dart';

final productReducer = redux.combineReducers<ProductState>([
  redux.TypedReducer<ProductState, ReceiveProductListAction>(_receiveProductList),
  redux.TypedReducer<ProductState, ReceiveProductAction>(_receiveProduct),
]);

ProductState _receiveProductList(ProductState state, ReceiveProductListAction action) {
  if (state.listByFilter == null) {
    state.listByFilter = new Map();
  }
  state.listByFilter.update(
    "categoryId=${action.categoryId}",
    (v) => action.products,
    ifAbsent: () => action.products
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

