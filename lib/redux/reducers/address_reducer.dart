import 'package:redux/redux.dart' as redux;
import '../../models/models.dart';
import '../actions/address_actions.dart';
import '../states/address_state.dart';

final addressReducer = redux.combineReducers<AddressState>([
  redux.TypedReducer<AddressState, ReceiveAddressListAction>(_receiveAddressList),
  redux.TypedReducer<AddressState, ReceiveAddressAction>(_receiveAddress),
]);

AddressState _receiveAddressList(AddressState state, ReceiveAddressListAction action) {
  List<Address> listByFilterZeroParentId = action.addresses;

  state.addresses = listByFilterZeroParentId;
  return state;
}

AddressState _receiveAddress(AddressState state, ReceiveAddressAction action) {
  if (state.mapById == null) {
    state.mapById = new Map();
  }
  state.mapById.putIfAbsent("${action.address.id}", () => action.address);
  return state;
}

