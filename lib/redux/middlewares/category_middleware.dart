import 'package:redux/redux.dart' as redux;
import '../../models/models.dart';
import '../../networking/networking.dart';
import '../actions/app_actions.dart';
import '../states/app_state.dart';

List<redux.Middleware<AppState>> createCategoryMiddleware() {
  return [
    new redux.TypedMiddleware<AppState, GetCategoryListAction>(_createGetCategoryListMiddleware()),
    new redux.TypedMiddleware<AppState, GetCategoryAction>(_createGetCategoryMiddleware()),
  ];
}

redux.Middleware<AppState> _createGetCategoryListMiddleware() {
  return (redux.Store store, action, redux.NextDispatcher next) async {
    if (!(action is GetCategoryListAction)) return;

    try {
      Result<Category> result= await sharedApiClient.defaultStore.categories.list(perPage: 999);
      store.dispatch(new ReceiveCategoryListAction(result));
      action.completer.complete();
    } catch (error) {
      action.completer.completeError(error);
    }
  };
}

redux.Middleware<AppState> _createGetCategoryMiddleware() {
  return (redux.Store store, action, redux.NextDispatcher next) async {
    if (!(action is GetCategoryAction)) return;

    try {
      Category category = await sharedApiClient.defaultStore.category(action.categoryId).get();
      store.dispatch(new ReceiveCategoryAction(category));
    } catch (error) {
      action.completer.completeError(error);
    }
  };
}
