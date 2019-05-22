import 'package:redux/redux.dart';
import '../../models/models.dart';
import '../../networking/networking.dart';
import '../actions/user_actions.dart';
import '../states/app_state.dart';

List<Middleware<AppState>> createUserMiddleware() {
  final getUser  = _createGetUserMiddleware();
  return [
    new TypedMiddleware<AppState, GetUserAction>(getUser),
  ];
}

Middleware<AppState> _createGetUserMiddleware() {
  return (Store store, action, NextDispatcher next) async {
    if (!(action is GetUserAction)) return;

    try {
      User user = await sharedApiClient.user(action.userId).get();
      store.dispatch(new GetUserSuccessAction(user));
    } catch (error) {
      store.dispatch(new GetUserFailureAction());
    }
  };
}
