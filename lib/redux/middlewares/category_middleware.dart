import 'package:redux/redux.dart';
import '../../models/models.dart';
import '../../networking/networking.dart';
import '../actions/app_actions.dart';
import '../states/app_state.dart';

List<Middleware<AppState>> createCategoryMiddleware() {
  return [
    new TypedMiddleware<AppState, GetCategoryListAction>(_createGetCategoryListMiddleware()),
    new TypedMiddleware<AppState, GetCategoryAction>(_createGetCategoryMiddleware()),
  ];
}

Middleware<AppState> _createGetCategoryListMiddleware() {
  return (Store store, action, NextDispatcher next) async {
    if (!(action is GetCategoryListAction)) return;

    try {
      List<Category> categories = await sharedApiClient.categories.list(perPage: 999);
      store.dispatch(new GetCategoryListSuccessAction(categories));
      action.completer.complete();
    } catch (error) {
      print(error.toString());
      store.dispatch(new GetCategoryListFailureAction());
      action.completer.completeError(error);
    }
  };
}

Middleware<AppState> _createGetCategoryMiddleware() {
  return (Store store, action, NextDispatcher next) async {
    if (!(action is GetCategoryAction)) return;

    try {
      Category category = await sharedApiClient.category(action.categoryId).get();
      store.dispatch(new GetCategorySuccessAction(category));
    } catch (error) {
      store.dispatch(new GetCategoryFailureAction());
    }
  };
}
