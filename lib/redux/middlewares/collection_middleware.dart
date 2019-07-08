import 'package:redux/redux.dart' as redux;
import '../../models/models.dart';
import '../../networking/networking.dart';
import '../actions/app_actions.dart';
import '../states/app_state.dart';

List<redux.Middleware<AppState>> createCollectionMiddleware() {
  return [
    new redux.TypedMiddleware<AppState, GetCollectionListAction>(_createGetCollectionListMiddleware()),
    new redux.TypedMiddleware<AppState, GetCollectionAction>(_createGetCollectionMiddleware()),
  ];
}

redux.Middleware<AppState> _createGetCollectionListMiddleware() {
  return (redux.Store store, action, redux.NextDispatcher next) async {
    if (!(action is GetCollectionListAction)) return;

    try {
      next(action);
      Result<Collection> result = await sharedApiClient.defaultStore.collections.list(
        page: action.page ?? 1,
      );
      store.dispatch(new ReceiveCollectionListAction(result.items));
      action.completer.complete(result);
    } catch (error) {
      action.completer.completeError(error);
    }
  };
}

redux.Middleware<AppState> _createGetCollectionMiddleware() {
  return (redux.Store store, action, redux.NextDispatcher next) async {
    if (!(action is GetCollectionAction)) return;

    try {
      next(action);
      Collection collection = await sharedApiClient.defaultStore.collection(action.collectionId).get();
      store.dispatch(new ReceiveCollectionAction(collection));
    } catch (error) {
      action.completer.completeError(error);
    }
  };
}
