import 'package:redux/redux.dart' as redux;
import '../../models/models.dart';
import '../actions/category_actions.dart';
import '../states/category_state.dart';

final categoryReducer = redux.combineReducers<CategoryState>([
  redux.TypedReducer<CategoryState, ReceiveCategoryListAction>(_receiveCategoryList),
  redux.TypedReducer<CategoryState, ReceiveCategoryAction>(_receiveCategory),
]);

CategoryState _receiveCategoryList(CategoryState state, ReceiveCategoryListAction action) {
  List<Category> categories = action.result.items;
  // 排除无图片链接的第三级分类
  categories = categories.where((c) => !(c.level == 2 && (c.imageUrl == null || c.imageUrl.isEmpty))).toList();

  List<Category> listByFilterZeroParentId = categories.where((c) => c.parentId == 0).toList();

  state.listByFilter = new Map();
  state.listByFilter.update(
    "all",
    (v) => categories,
    ifAbsent: () => categories
  );
  state.listByFilter.update(
    "parentId=0",
    (v) => listByFilterZeroParentId,
    ifAbsent: () => listByFilterZeroParentId
  );

  for (var i = 0; i < listByFilterZeroParentId.length; i++) {
    int id = listByFilterZeroParentId[i].id;
    List<Category> listByFilterLevel2ParentId = categories.where((c) => c.parentId == id).toList();
    state.listByFilter.update(
      "parentId=$id",
      (v) => listByFilterLevel2ParentId,
      ifAbsent: () => listByFilterLevel2ParentId,
    );

    for (var j = 0; j < listByFilterLevel2ParentId.length; j++) {
      int id = listByFilterLevel2ParentId[j].id;
      var listByFilterLevel3ParentId = categories.where((c) => c.parentId == id).toList();
      state.listByFilter.update(
        "parentId=$id",
        (v) => listByFilterLevel3ParentId,
        ifAbsent: () => listByFilterLevel3ParentId,
      );
    }
  }
  return state;
}

CategoryState _receiveCategory(CategoryState state, ReceiveCategoryAction action) {
  return state;
}

