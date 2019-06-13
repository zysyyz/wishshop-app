import 'package:redux/redux.dart' as Redux;
import '../../models/models.dart';
import '../../networking/networking.dart';
import '../actions/app_actions.dart';
import '../states/app_state.dart';

List<Redux.Middleware<AppState>> createCollectionMiddleware() {
  return [
    new Redux.TypedMiddleware<AppState, GetCollectionListAction>(_createGetCollectionListMiddleware()),
    new Redux.TypedMiddleware<AppState, GetCollectionAction>(_createGetCollectionMiddleware()),
  ];
}

Redux.Middleware<AppState> _createGetCollectionListMiddleware() {
  return (Redux.Store store, action, Redux.NextDispatcher next) async {
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

Redux.Middleware<AppState> _createGetCollectionMiddleware() {
  return (Redux.Store store, action, Redux.NextDispatcher next) async {
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
