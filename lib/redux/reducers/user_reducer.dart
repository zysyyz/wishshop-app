import 'package:redux/redux.dart';
import '../actions/user_actions.dart';
import '../states/user_state.dart';

final userReducer = combineReducers<UserState>([
  TypedReducer<UserState, GetUserSuccessAction>(_getUserSuccess),
  TypedReducer<UserState, GetUserFailureAction>(_getUserFailure),
]);

UserState _getUserSuccess(UserState state, GetUserSuccessAction action) {
  return state;
}

UserState _getUserFailure(UserState state, GetUserFailureAction action) {
  return state;
}
