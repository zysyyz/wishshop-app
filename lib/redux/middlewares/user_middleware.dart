import 'package:redux/redux.dart' as Redux;
import '../../models/models.dart';
import '../../networking/networking.dart';
import '../actions/app_actions.dart';
import '../states/app_state.dart';

List<Redux.Middleware<AppState>> createUserMiddleware() {
  final getUser  = _createGetUserMiddleware();
  return [
    new Redux.TypedMiddleware<AppState, GetUserAction>(getUser),
  ];
}

Redux.Middleware<AppState> _createGetUserMiddleware() {
  return (Redux.Store store, action, Redux.NextDispatcher next) async {
    if (!(action is GetUserAction)) return;

    try {
      User user = await sharedApiClient.user(action.userId).get();
      store.dispatch(new GetUserSuccessAction(user));
    } catch (error) {
      store.dispatch(new GetUserFailureAction());
    }
  };
}
