import 'package:redux/redux.dart';
import '../../models/models.dart';
import '../actions/category_actions.dart';
import '../states/category_state.dart';

final categoryReducer = combineReducers<CategoryState>([
  TypedReducer<CategoryState, GetCategoryListSuccessAction>(_getCategoryListSuccess),
  TypedReducer<CategoryState, GetCategoryListFailureAction>(_getCategoryListFailure),
  TypedReducer<CategoryState, GetCategorySuccessAction>(_getCategorySuccess),
  TypedReducer<CategoryState, GetCategoryFailureAction>(_getCategoryFailure),
]);

CategoryState _getCategoryListSuccess(CategoryState state, GetCategoryListSuccessAction action) {
  List<Category> listByFilterZeroParentId = action.categories.where((c) => c.parentId == 0).toList();
  
  state.listByFilter = new Map();
  state.listByFilter.putIfAbsent("all", () => action.categories);
  state.listByFilter.putIfAbsent("parentId=0", () => listByFilterZeroParentId);

  for (var i = 0; i < listByFilterZeroParentId.length; i++) {
    int id = listByFilterZeroParentId[i].id;
    var list = action.categories.where((c) => c.parentId == id).toList();
    state.listByFilter.putIfAbsent("parentId=$id", () => list);
  }
  return state;
}

CategoryState _getCategoryListFailure(CategoryState state, GetCategoryListFailureAction action) {
  return state;
}

CategoryState _getCategorySuccess(CategoryState state, GetCategorySuccessAction action) {
  return state;
}

CategoryState _getCategoryFailure(CategoryState state, GetCategoryFailureAction action) {
  return state;
}

