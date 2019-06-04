import 'package:redux/redux.dart' as Redux;
import '../../models/models.dart';
import '../../networking/networking.dart';
import '../../redux/actions/app_actions.dart';
import '../../redux/states/app_state.dart';

List<Redux.Middleware<AppState>> createAuthMiddleware() {
  return [
    new Redux.TypedMiddleware<AppState, RegisterAction>(_createRegisterMiddleware()),
    new Redux.TypedMiddleware<AppState, LoginAction>(_createLogInMiddleware()),
    new Redux.TypedMiddleware<AppState, LogoutAction>(_createLogOutMiddleware()),
  ];
}

Redux.Middleware<AppState> _createRegisterMiddleware() {
  return (Redux.Store store, action, Redux.NextDispatcher next) async {
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

Redux.Middleware<AppState> _createLogInMiddleware() {
  return (Redux.Store store, action, Redux.NextDispatcher next) async {
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

Redux.Middleware<AppState> _createLogOutMiddleware() {
  return (Redux.Store store, action, Redux.NextDispatcher next) async {
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
