import 'package:redux/redux.dart' as Redux;
import '../../models/models.dart';
import '../../networking/networking.dart';
import '../actions/app_actions.dart';
import '../states/app_state.dart';

List<Redux.Middleware<AppState>> createAddressMiddleware() {
  return [
    new Redux.TypedMiddleware<AppState, GetAddressListAction>(_createGetAddressListMiddleware()),
    new Redux.TypedMiddleware<AppState, GetAddressAction>(_createGetAddressMiddleware()),
  ];
}

Redux.Middleware<AppState> _createGetAddressListMiddleware() {
  return (Redux.Store store, action, Redux.NextDispatcher next) async {
    if (!(action is GetAddressListAction)) return;

    try {
      List<Address> addresses = await sharedApiClient.defaultStore.addresses.list(perPage: 999);
      store.dispatch(new ReceiveAddressListAction(addresses));
      action.completer.complete();
    } catch (error) {
      action.completer.completeError(error);
    }
  };
}

Redux.Middleware<AppState> _createGetAddressMiddleware() {
  return (Redux.Store store, action, Redux.NextDispatcher next) async {
    if (!(action is GetAddressAction)) return;

    try {
      Address address = await sharedApiClient.defaultStore.address(action.addressId).get();
      store.dispatch(new ReceiveAddressAction(address));
    } catch (error) {
      action.completer.completeError(error);
    }
  };
}