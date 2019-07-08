import 'package:redux/redux.dart' as redux;
import '../../models/models.dart';
import '../../networking/networking.dart';
import '../actions/app_actions.dart';
import '../states/app_state.dart';

List<redux.Middleware<AppState>> createUserMiddleware() {
  final getUser  = _createGetUserMiddleware();
  return [
    new redux.TypedMiddleware<AppState, GetUserAction>(getUser),
  ];
}

redux.Middleware<AppState> _createGetUserMiddleware() {
  return (redux.Store store, action, redux.NextDispatcher next) async {
    if (!(action is GetUserAction)) return;

    try {
      User user = await sharedApiClient.user(action.userId).get();
      store.dispatch(new GetUserSuccessAction(user));
    } catch (error) {
      store.dispatch(new GetUserFailureAction());
    }
  };
}
