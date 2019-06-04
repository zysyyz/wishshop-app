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
      List<Collection> collections = await sharedApiClient.defaultStore.collections.list(perPage: 999);
      store.dispatch(new ReceiveCollectionListAction(collections));
      action.completer.complete();
    } catch (error) {
      action.completer.completeError(error);
    }
  };
}

Redux.Middleware<AppState> _createGetCollectionMiddleware() {
  return (Redux.Store store, action, Redux.NextDispatcher next) async {
    if (!(action is GetCollectionAction)) return;

    try {
      Collection collection = await sharedApiClient.defaultStore.collection(action.collectionId).get();
      store.dispatch(new ReceiveCollectionAction(collection));
    } catch (error) {
      action.completer.completeError(error);
    }
  };
}
