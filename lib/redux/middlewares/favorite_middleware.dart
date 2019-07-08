import 'package:redux/redux.dart' as redux;
import '../../models/models.dart';
import '../../networking/networking.dart';
import '../actions/app_actions.dart';
import '../states/app_state.dart';

List<redux.Middleware<AppState>> createFavoriteMiddleware() {
  return [
    new redux.TypedMiddleware<AppState, GetFavoriteListAction>(_createGetFavoriteListMiddleware()),
    new redux.TypedMiddleware<AppState, CreateFavoriteAction>(_createCreateFavoriteMiddleware()),
    new redux.TypedMiddleware<AppState, DeleteFavoriteAction>(_createDeleteFavoriteMiddleware()),
  ];
}

redux.Middleware<AppState> _createGetFavoriteListMiddleware() {
  return (redux.Store store, action, redux.NextDispatcher next) async {
    if (!(action is GetFavoriteListAction)) return;

    try {
      next(action);
      Result<Favorite> result = await sharedApiClient.defaultStore.favorites.list(
        page: action.page ?? 1,
      );
      store.dispatch(new ReceiveFavoriteListAction(result));
      action.completer.complete(result);
    } catch (error) {
      action.completer.completeError(error);
    }
  };
}

redux.Middleware<AppState> _createCreateFavoriteMiddleware() {
  return (redux.Store<AppState> store, action, redux.NextDispatcher next) async {
    if (!(action is CreateFavoriteAction)) return;

    try {
      next(action);
      Favorite favorite = await sharedApiClient.defaultStore.favorites.create(
        targetType: action.targetType,
        targetId: action.targetId,
      );
      // 更新商品的收藏状态
      if (action.targetType == 'product') {
        Product product = store.state.productState.get(action.targetId);
        product.favoriteId = favorite.id;
        product.favoritedAt = favorite.updatedAt;
        store.dispatch(new ReceiveProductAction(product));
      }
      store.dispatch(new CreateFavoriteSuccessAction(favorite));
      action.completer.complete(true);
    } catch (error) {
      action.completer.completeError(error);
    }
  };
}

redux.Middleware<AppState> _createDeleteFavoriteMiddleware() {
  return (redux.Store store, action, redux.NextDispatcher next) async {
    if (!(action is DeleteFavoriteAction)) return;

    try {
      next(action);
      await sharedApiClient.defaultStore.favorite(action.favoriteId).delete();
      // 更新商品的收藏状态
      if (action.targetType == 'product') {
        Product product = store.state.productState.get(action.targetId);
        product.favoriteId = null;
        product.favoritedAt = null;
        store.dispatch(new ReceiveProductAction(product));
      }
      store.dispatch(new DeleteFavoriteSuccessAction(action.favoriteId));
      action.completer.complete(true);
    } catch (error) {
      action.completer.completeError(error);
    }
  };
}
