import 'package:redux/redux.dart' as redux;
import '../../models/models.dart';
import '../../networking/networking.dart';
import '../actions/app_actions.dart';
import '../states/app_state.dart';

List<redux.Middleware<AppState>> createAddressMiddleware() {
  return [
    new redux.TypedMiddleware<AppState, GetAddressListAction>(_createGetAddressListMiddleware()),
    new redux.TypedMiddleware<AppState, GetAddressAction>(_createGetAddressMiddleware()),
  ];
}

redux.Middleware<AppState> _createGetAddressListMiddleware() {
  return (redux.Store store, action, redux.NextDispatcher next) async {
    if (!(action is GetAddressListAction)) return;

    try {
      Result<Address> result = await sharedApiClient.defaultStore.addresses.list(
        page: action.page ?? 1,
      );
      store.dispatch(new ReceiveAddressListAction(result));
      action.completer.complete(result);
    } catch (error) {
      action.completer.completeError(error);
    }
  };
}

redux.Middleware<AppState> _createGetAddressMiddleware() {
  return (redux.Store store, action, redux.NextDispatcher next) async {
    if (!(action is GetAddressAction)) return;

    try {
      Address address = await sharedApiClient.defaultStore.address(action.addressId).get();
      store.dispatch(new ReceiveAddressAction(address));
    } catch (error) {
      action.completer.completeError(error);
    }
  };
}
