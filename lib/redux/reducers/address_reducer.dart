import 'package:redux/redux.dart' as redux;
import '../../models/models.dart';
import '../actions/address_actions.dart';
import '../states/address_state.dart';

final addressReducer = redux.combineReducers<AddressState>([
  redux.TypedReducer<AddressState, ReceiveAddressListAction>(_receiveAddressList),
  redux.TypedReducer<AddressState, ReceiveAddressAction>(_receiveAddress),
]);

AddressState _receiveAddressList(AddressState state, ReceiveAddressListAction action) {
  state.list = action.addresses;
  return state;
}

AddressState _receiveAddress(AddressState state, ReceiveAddressAction action) {
  if (state.map == null) {
    state.map = new Map();
  }
  state.map.update(
    "${action.address.id}",
    (v) => action.address,
    ifAbsent: () => action.address,
  );
  return state;
}

