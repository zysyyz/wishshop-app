import 'package:redux/redux.dart' as redux;
import '../../models/models.dart';
import '../actions/address_actions.dart';
import '../states/address_state.dart';

final addressReducer = redux.combineReducers<AddressState>([
  redux.TypedReducer<AddressState, ReceiveAddressListAction>(_receiveAddressList),
  redux.TypedReducer<AddressState, ReceiveAddressAction>(_receiveAddress),
  redux.TypedReducer<AddressState, UpdateAddressSuccessAction>(_updateAddressSuccess),
  redux.TypedReducer<AddressState, DeleteAddressSuccessAction>(_deleteAddressSuccess),
]);

AddressState _receiveAddressList(AddressState state, ReceiveAddressListAction action) {
  List<Address> addresses = state.list ?? [];
  if (action.result.pagination.currentPage == 1) {
    addresses = action.result.items;
  } else {
    addresses = []
      ..addAll(addresses)
      ..addAll(action.result.items);
  }
  state.list = addresses;
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

AddressState _updateAddressSuccess(AddressState state, UpdateAddressSuccessAction action) {
  state.list.removeWhere((v) => v.id == action.address.id);
  state.list.insert(0, action.address);
  if (state.map != null) {
    state.map.update(
      "${action.address.id}",
      (v) => action.address,
      ifAbsent: () => action.address,
    );
  }
  return state;
}

AddressState _deleteAddressSuccess(AddressState state, DeleteAddressSuccessAction action) {
  state.list.removeWhere((v) => v.id == action.addressId);
  if (state.map != null) {
    state.map.remove("${action.addressId}");
  }
  return state;
}
