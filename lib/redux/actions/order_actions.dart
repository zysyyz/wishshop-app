import 'dart:async';
import '../../exports.dart';

class GetOrderListAction {
  final Completer<Result<Order>> completer = new Completer();
  int page;

  GetOrderListAction({this.page});
}
class ReceiveOrderListAction {
  Result<Order> result;

  ReceiveOrderListAction(this.result);
}

class GetOrderAction {
  final Completer<Order> completer = new Completer();
  final String number;

  GetOrderAction(this.number);
}
class ReceiveOrderAction {
  final Order order;

  ReceiveOrderAction(this.order);
}

class CreateOrderAction {
  final Order order;

  CreateOrderAction(this.order);
}
class CreateOrderSuccessAction {
  final Order order;

  CreateOrderSuccessAction(this.order);
}

class UpdateOrderAction {
  final String number;

  UpdateOrderAction({this.number});
}
class UpdateOrderSuccessAction {
  final Order order;

  UpdateOrderSuccessAction(this.order);
}

class DeleteOrderAction {
  final Order order;

  DeleteOrderAction(this.order);
}
class DeleteOrderSuccessAction {
  final int orderId;

  DeleteOrderSuccessAction(this.orderId);
}

class CreateOrderLineItemAction {
  final Completer<OrderLineItem> completer = new Completer();
  final String number;
  final Product product;
  final num quantity;

  CreateOrderLineItemAction({
    this.number,
    this.product,
    this.quantity,
  });
}
class CreateOrderLineItemSuccessAction {
  final OrderLineItem lineItem;

  CreateOrderLineItemSuccessAction(this.lineItem);
}

class UpdateOrderLineItemAction {
  final Completer<OrderLineItem> completer = new Completer();
  final String number;
  final String lineItemId;
  final num quantity;

  UpdateOrderLineItemAction({
    this.number,
    this.lineItemId,
    this.quantity,
  });
}
class UpdateOrderLineItemSuccessAction {
  final OrderLineItem lineItem;

  UpdateOrderLineItemSuccessAction(this.lineItem);
}

class DeleteOrderLineItemAction {
  final Completer<bool> completer = new Completer();
  final String number;
  final String lineItemId;

  DeleteOrderLineItemAction({
    this.number,
    this.lineItemId,
  });
}
class DeleteOrderLineItemSuccessAction {
  final String number;
  final String lineItemId;

  DeleteOrderLineItemSuccessAction({
    this.number,
    this.lineItemId
  });
}
