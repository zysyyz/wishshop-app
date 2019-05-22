import 'package:redux/redux.dart';
import '../../models/models.dart';
import '../../networking/networking.dart';
import '../../redux/actions/auth_actions.dart';
import '../../redux/states/app_state.dart';

List<Middleware<AppState>> createAuthMiddleware() {
  return [
    new TypedMiddleware<AppState, RegisterAction>(_createRegisterMiddleware()),
    new TypedMiddleware<AppState, LoginAction>(_createLogInMiddleware()),
    new TypedMiddleware<AppState, LogoutAction>(_createLogOutMiddleware()),
  ];
}

Middleware<AppState> _createRegisterMiddleware() {
  return (Store store, action, NextDispatcher next) async {
    if (!(action is RegisterAction)) return;

    try {
      User user = await sharedApiClient.account.register(
        action.name,
        action.email,
        action.password
      );
      store.dispatch(new RegisterSuccessAction(user));
      action.completer.complete();
    } catch (error) {
      store.dispatch(new RegisterFailureAction());
      action.completer.completeError(error);
    }
  };
}

Middleware<AppState> _createLogInMiddleware() {
  return (Store store, action, NextDispatcher next) async {
    if (!(action is LoginAction)) return;

    try {
      User user = await sharedApiClient.account.login(
        action.email,
        action.password
      );
      store.dispatch(new LoginSuccessAction(user));
      action.completer.complete();
    } catch (error) {
      store.dispatch(new LoginFailureAction());
      action.completer.completeError(error);
    }
  };
}

Middleware<AppState> _createLogOutMiddleware() {
  return (Store store, action, NextDispatcher next) async {
    if (!(action is LogoutAction)) return;

    try {
      store.dispatch(new LogoutSuccessAction());
      await sharedApiClient.account.logout();
      action.completer.complete();
    } catch (error) {
      store.dispatch(new LogoutFailureAction());
      action.completer.completeError(error);
    }
  };
}
