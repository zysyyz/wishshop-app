import 'dart:async';
import '../../exports.dart';

class GetAddressListAction {
  final Completer<Result<Address>> completer = new Completer();
  int page;

  GetAddressListAction({this.page});
}
class ReceiveAddressListAction {
  Result<Address> result;

  ReceiveAddressListAction(this.result);
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

class UpdateAddressAction {
  final Address address;

  UpdateAddressAction(this.address);
}
class UpdateAddressSuccessAction {
  final Address address;

  UpdateAddressSuccessAction(this.address);
}

class DeleteAddressAction {
  final Address address;

  DeleteAddressAction(this.address);
}
class DeleteAddressSuccessAction {
  final int addressId;

  DeleteAddressSuccessAction(this.addressId);
}
