import '../states/app_state.dart';
import './address_reducer.dart';
import './auth_reducer.dart';
import './category_reducer.dart';
import './collection_reducer.dart';
import './product_reducer.dart';
import './user_reducer.dart';

AppState appReducer(AppState state, action) {
  return AppState(
    address: addressReducer(state.address, action),
    auth: authReducer(state.auth, action),
    category: categoryReducer(state.category, action),
    collectionState: collectionReducer(state.collectionState, action),
    productState: productReducer(state.productState, action),
    // user: userReducer(state.user, action),
  );
}
