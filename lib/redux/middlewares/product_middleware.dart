import 'package:redux/redux.dart' as Redux;
import '../../models/models.dart';
import '../../networking/networking.dart';
import '../actions/app_actions.dart';
import '../states/app_state.dart';

List<Redux.Middleware<AppState>> createProductMiddleware() {
  return [
    new Redux.TypedMiddleware<AppState, GetProductListAction>(_createGetProductListMiddleware()),
    new Redux.TypedMiddleware<AppState, GetProductAction>(_createGetProductMiddleware()),
  ];
}

Redux.Middleware<AppState> _createGetProductListMiddleware() {
  return (Redux.Store store, action, Redux.NextDispatcher next) async {
    if (!(action is GetProductListAction)) return;

    try {
      List<Product> products = await sharedApiClient.defaultStore.products.list(categoryId: action.categoryId);
      store.dispatch(new ReceiveProductListAction(
        products,
        categoryId: action.categoryId,
      ));
      action.completer.complete();
    } catch (error) {
      print(error);
      action.completer.completeError(error);
    }
  };
}

Redux.Middleware<AppState> _createGetProductMiddleware() {
  return (Redux.Store store, action, Redux.NextDispatcher next) async {
    if (!(action is GetProductAction)) return;

    try {
      print('>>>>0');
      Product product = await sharedApiClient.defaultStore.product(action.productId).get();
      print('>>>>1');
      store.dispatch(new ReceiveProductAction(product));
      print('>>>>2');
    } catch (error) {
      print(error);
      action.completer.completeError(error);
    }
  };
}
