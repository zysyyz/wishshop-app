import 'dart:async';
import '../../models/models.dart';

class GetAddressListAction {
  final Completer completer = new Completer();
  GetAddressListAction();
}
class ReceiveAddressListAction {
  final List<Address> addresses;

  ReceiveAddressListAction(this.addresses);
}

class GetAddressAction {
  final Completer completer = new Completer();
  final int categoryId;

  GetAddressAction(this.categoryId);
}
class ReceiveAddressAction {
  final Completer completer = new Completer();
  final Address address;

  ReceiveAddressAction(this.address);
}
