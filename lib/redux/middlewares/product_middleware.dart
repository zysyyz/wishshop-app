import 'package:redux/redux.dart' as redux;
import '../../models/models.dart';
import '../../networking/networking.dart';
import '../actions/app_actions.dart';
import '../states/app_state.dart';

List<redux.Middleware<AppState>> createProductMiddleware() {
  return [
    new redux.TypedMiddleware<AppState, GetProductListAction>(_createGetProductListMiddleware()),
    new redux.TypedMiddleware<AppState, GetProductAction>(_createGetProductMiddleware()),
  ];
}

redux.Middleware<AppState> _createGetProductListMiddleware() {
  return (redux.Store store, action, redux.NextDispatcher next) async {
    if (!(action is GetProductListAction)) return;

    try {
      next(action);
      Result<Product> result = await sharedApiClient.defaultStore.products.list(
        page: action.page,
        categoryId: action.categoryId,
      );
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

redux.Middleware<AppState> _createGetProductMiddleware() {
  return (redux.Store store, action, redux.NextDispatcher next) async {
    if (!(action is GetProductAction)) return;

    try {
      Product product = await sharedApiClient.defaultStore.product(action.productId).get();
      store.dispatch(new ReceiveProductAction(product));
    } catch (error) {
      action.completer.completeError(error);
    }
  };
}
