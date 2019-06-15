import 'package:redux/redux.dart' as redux;
import '../../models/models.dart';
import '../actions/favorite_actions.dart';
import '../states/favorite_state.dart';

final favoriteReducer = redux.combineReducers<FavoriteState>([
  redux.TypedReducer<FavoriteState, ReceiveFavoriteListAction>(_receiveFavoriteList),
  redux.TypedReducer<FavoriteState, CreateFavoriteSuccessAction>(_createFavoriteSuccess),
  redux.TypedReducer<FavoriteState, DeleteFavoriteSuccessAction>(_deleteFavoriteSuccess),
]);

FavoriteState _receiveFavoriteList(FavoriteState state, ReceiveFavoriteListAction action) {
  List<Favorite> favoritees = state.list ?? [];
  if (action.result.pagination.currentPage == 1) {
    favoritees = action.result.items;
  } else {
    favoritees = []
      ..addAll(favoritees)
      ..addAll(action.result.items);
  }
  state.list = favoritees;
  return state;
}

FavoriteState _createFavoriteSuccess(FavoriteState state, CreateFavoriteSuccessAction action) {
  return state;
}

FavoriteState _deleteFavoriteSuccess(FavoriteState state, DeleteFavoriteSuccessAction action) {
  state.list.removeWhere((v) => v.id == action.favoriteId);
  if (state.map != null) {
    state.map.remove("${action.favoriteId}");
  }
  return state;
}
