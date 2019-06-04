import 'package:redux/redux.dart' as redux;
import '../actions/user_actions.dart';
import '../states/user_state.dart';

final userReducer = redux.combineReducers<UserState>([
  redux.TypedReducer<UserState, GetUserSuccessAction>(_getUserSuccess),
  redux.TypedReducer<UserState, GetUserFailureAction>(_getUserFailure),
]);

UserState _getUserSuccess(UserState state, GetUserSuccessAction action) {
  return state;
}

UserState _getUserFailure(UserState state, GetUserFailureAction action) {
  return state;
}
