import 'package:redux/redux.dart';
import '../actions/auth_actions.dart';
import '../states/auth_state.dart';

final authReducer = combineReducers<AuthState>([
  TypedReducer<AuthState, RegisterSuccessAction>(_registerSuccess),
  TypedReducer<AuthState, RegisterFailureAction>(_registerFailure),
  TypedReducer<AuthState, LoginSuccessAction>(_loginSuccess),
  TypedReducer<AuthState, LoginFailureAction>(_loginFailure),
  TypedReducer<AuthState, LogoutSuccessAction>(_logoutSuccess),
  TypedReducer<AuthState, LogoutFailureAction>(_logoutFailure),
]);

AuthState _registerSuccess(AuthState state, RegisterSuccessAction action) {
  state.user = action.user;
  return state;
}

AuthState _registerFailure(AuthState state, RegisterFailureAction action) {
  state.user = null;
  return state;
}

AuthState _loginSuccess(AuthState state, LoginSuccessAction action) {
  state.user = action.user;
  return state;
}

AuthState _loginFailure(AuthState state, LoginFailureAction action) {
  state.user = null;
  return state;
}

AuthState _logoutSuccess(AuthState state, LogoutSuccessAction action) {
  state.user = null;
  return state;
}

AuthState _logoutFailure(AuthState state, LogoutFailureAction action) {
  state.user = null;
  return state;
}
