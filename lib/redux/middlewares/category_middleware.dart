import 'package:redux/redux.dart' as Redux;
import '../../models/models.dart';
import '../../networking/networking.dart';
import '../actions/app_actions.dart';
import '../states/app_state.dart';

List<Redux.Middleware<AppState>> createCategoryMiddleware() {
  return [
    new Redux.TypedMiddleware<AppState, GetCategoryListAction>(_createGetCategoryListMiddleware()),
    new Redux.TypedMiddleware<AppState, GetCategoryAction>(_createGetCategoryMiddleware()),
  ];
}

Redux.Middleware<AppState> _createGetCategoryListMiddleware() {
  return (Redux.Store store, action, Redux.NextDispatcher next) async {
    if (!(action is GetCategoryListAction)) return;

    try {
      List<Category> categories = await sharedApiClient.defaultStore.categories.list(perPage: 999);
      store.dispatch(new ReceiveCategoryListAction(categories));
      action.completer.complete();
    } catch (error) {
      action.completer.completeError(error);
    }
  };
}

Redux.Middleware<AppState> _createGetCategoryMiddleware() {
  return (Redux.Store store, action, Redux.NextDispatcher next) async {
    if (!(action is GetCategoryAction)) return;

    try {
      Category category = await sharedApiClient.defaultStore.category(action.categoryId).get();
      store.dispatch(new ReceiveCategoryAction(category));
    } catch (error) {
      action.completer.completeError(error);
    }
  };
}
