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
  state.listByFilter.putIfAbsent("categoryId=${action.categoryId}", () => action.products);
  return state;
}

ProductState _receiveProduct(ProductState state, ReceiveProductAction action) {
  if (state.mapById == null) {
    state.mapById = new Map();
  }
  state.mapById.putIfAbsent("${action.product.id}", () => action.product);
  return state;
}
