import 'package:redux/redux.dart' as redux;
import '../../models/models.dart';
import '../actions/category_actions.dart';
import '../states/category_state.dart';

final categoryReducer = redux.combineReducers<CategoryState>([
  redux.TypedReducer<CategoryState, ReceiveCategoryListAction>(_receiveCategoryList),
  redux.TypedReducer<CategoryState, ReceiveCategoryAction>(_receiveCategory),
]);

CategoryState _receiveCategoryList(CategoryState state, ReceiveCategoryListAction action) {
  List<Category> listByFilterZeroParentId = action.categories.where((c) => c.parentId == 0).toList();
  
  state.listByFilter = new Map();
  state.listByFilter.putIfAbsent("all", () => action.categories);
  state.listByFilter.putIfAbsent("parentId=0", () => listByFilterZeroParentId);

  for (var i = 0; i < listByFilterZeroParentId.length; i++) {
    int id = listByFilterZeroParentId[i].id;
    List<Category> listByFilterLevel2ParentId = action.categories.where((c) => c.parentId == id).toList();
    state.listByFilter.putIfAbsent("parentId=$id", () => listByFilterLevel2ParentId);

    for (var j = 0; j < listByFilterLevel2ParentId.length; j++) {
      int id = listByFilterLevel2ParentId[j].id;
      var listByFilterLevel3ParentId = action.categories.where((c) => c.parentId == id).toList();
      state.listByFilter.putIfAbsent("parentId=$id", () => listByFilterLevel3ParentId);
    }
  }
  return state;
}

CategoryState _receiveCategory(CategoryState state, ReceiveCategoryAction action) {
  return state;
}

