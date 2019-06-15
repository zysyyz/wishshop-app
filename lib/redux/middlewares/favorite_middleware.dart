import 'package:redux/redux.dart' as Redux;
import '../../models/models.dart';
import '../../networking/networking.dart';
import '../actions/app_actions.dart';
import '../states/app_state.dart';

List<Redux.Middleware<AppState>> createFavoriteMiddleware() {
  return [
    new Redux.TypedMiddleware<AppState, GetFavoriteListAction>(_createGetFavoriteListMiddleware()),
    new Redux.TypedMiddleware<AppState, CreateFavoriteAction>(_createCreateFavoriteMiddleware()),
    new Redux.TypedMiddleware<AppState, DeleteFavoriteAction>(_createDeleteFavoriteMiddleware()),
  ];
}

Redux.Middleware<AppState> _createGetFavoriteListMiddleware() {
  return (Redux.Store store, action, Redux.NextDispatcher next) async {
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

Redux.Middleware<AppState> _createCreateFavoriteMiddleware() {
  return (Redux.Store<AppState> store, action, Redux.NextDispatcher next) async {
    if (!(action is CreateFavoriteAction)) return;

    try {
      next(action);
      Favorite favorite = await sharedApiClient.defaultStore.favorites.create(
        targetType: action.targetType,
        targetId: action.targetId,
      );
      print(favorite);
      // 更新商品的收藏状态
      if (action.targetType == 'product') {
        Product product = store.state.productState.get(action.targetId);
        product.favoriteId = favorite.id;
        product.favoritedAt = favorite.updatedAt;
        print(product);
        store.dispatch(new ReceiveProductAction(product));
      }
      store.dispatch(new CreateFavoriteSuccessAction(favorite));
      action.completer.complete(true);
    } catch (error) {
      action.completer.completeError(error);
    }
  };
}

Redux.Middleware<AppState> _createDeleteFavoriteMiddleware() {
  return (Redux.Store store, action, Redux.NextDispatcher next) async {
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
