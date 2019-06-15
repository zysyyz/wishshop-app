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
      next(action);
      Result<Product> result = await sharedApiClient.defaultStore.products.list(categoryId: action.categoryId);
      store.dispatch(new ReceiveProductListAction(
        categoryId: action.categoryId,
        result: result,
      ));
      action.completer.complete(result);
    } catch (error) {
      action.completer.completeError(error);
    }
  };
}

Redux.Middleware<AppState> _createGetProductMiddleware() {
  return (Redux.Store store, action, Redux.NextDispatcher next) async {
    if (!(action is GetProductAction)) return;

    try {
      Product product = await sharedApiClient.defaultStore.product(action.productId).get();
      store.dispatch(new ReceiveProductAction(product));
    } catch (error) {
      action.completer.completeError(error);
    }
  };
}
