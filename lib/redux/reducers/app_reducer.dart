import '../states/app_state.dart';
import './address_reducer.dart';
import './auth_reducer.dart';
import './category_reducer.dart';
import './collection_reducer.dart';
import './favorite_reducer.dart';
import './order_reducer.dart';
import './product_reducer.dart';
import './user_reducer.dart';

AppState appReducer(AppState state, action) {
  return AppState(
    addressState: addressReducer(state.addressState, action),
    authState: authReducer(state.authState, action),
    categoryState: categoryReducer(state.categoryState, action),
    collectionState: collectionReducer(state.collectionState, action),
    favoriteState: favoriteReducer(state.favoriteState, action),
    orderState: orderReducer(state.orderState, action),
    productState: productReducer(state.productState, action),
    // user: userReducer(state.user, action),
  );
}
