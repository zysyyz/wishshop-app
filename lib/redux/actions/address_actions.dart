import 'dart:async';
import '../../exports.dart';

class GetAddressListAction {
  final Completer<Result<Address>> completer = new Completer();
  int page;

  GetAddressListAction({this.page});
}
class ReceiveAddressListAction {
  final List<Address> addresses;

  ReceiveAddressListAction(this.addresses);
}

class GetAddressAction {
  final Completer completer = new Completer();
  final int addressId;

  GetAddressAction(this.addressId);
}
class ReceiveAddressAction {
  final Completer completer = new Completer();
  final Address address;

  ReceiveAddressAction(this.address);
}
