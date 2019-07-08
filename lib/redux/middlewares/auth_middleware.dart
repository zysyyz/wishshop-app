import 'package:redux/redux.dart' as redux;
import '../../models/models.dart';
import '../../networking/networking.dart';
import '../../redux/actions/app_actions.dart';
import '../../redux/states/app_state.dart';

List<redux.Middleware<AppState>> createAuthMiddleware() {
  return [
    new redux.TypedMiddleware<AppState, RegisterAction>(_createRegisterMiddleware()),
    new redux.TypedMiddleware<AppState, LoginAction>(_createLogInMiddleware()),
    new redux.TypedMiddleware<AppState, LogoutAction>(_createLogOutMiddleware()),
  ];
}

redux.Middleware<AppState> _createRegisterMiddleware() {
  return (redux.Store store, action, redux.NextDispatcher next) async {
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

redux.Middleware<AppState> _createLogInMiddleware() {
  return (redux.Store store, action, redux.NextDispatcher next) async {
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

redux.Middleware<AppState> _createLogOutMiddleware() {
  return (redux.Store store, action, redux.NextDispatcher next) async {
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
