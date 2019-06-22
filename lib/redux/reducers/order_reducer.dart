import 'package:redux/redux.dart' as redux;
import '../../models/models.dart';
import '../actions/order_actions.dart';
import '../states/order_state.dart';

final orderReducer = redux.combineReducers<OrderState>([
  redux.TypedReducer<OrderState, ReceiveOrderListAction>(_receiveOrderList),
  redux.TypedReducer<OrderState, ReceiveOrderAction>(_receiveOrder),
  redux.TypedReducer<OrderState, UpdateOrderSuccessAction>(_updateOrderSuccess),
  redux.TypedReducer<OrderState, DeleteOrderSuccessAction>(_deleteOrderSuccess),
  redux.TypedReducer<OrderState, CreateOrderLineItemSuccessAction>(_createOrderLineItemSuccess),
  redux.TypedReducer<OrderState, UpdateOrderLineItemSuccessAction>(_updateOrderLineItemSuccess),
  redux.TypedReducer<OrderState, DeleteOrderLineItemSuccessAction>(_deleteOrderLineItemSuccess),
]);

OrderState _receiveOrderList(OrderState state, ReceiveOrderListAction action) {
  String filter = 'all';
  // List<Order> orders = state.list(filter) ?? [];
  // if (action.result.pagination.currentPage == 1) {
  //   orders = action.result.items;
  // } else {
  //   orders = []
  //     ..addAll(orders)
  //     ..addAll(action.result.items);
  // }
  // state.listByFilter.update(
  //   'all',
  //   (_) => orders,
  //   ifAbsent: () => orders,
  // );
  return state;
}

OrderState _receiveOrder(OrderState state, ReceiveOrderAction action) {
  if (state.map == null) {
    state.map = new Map();
  }
  state.map.update(
    "${action.order.id}",
    (v) => action.order,
    ifAbsent: () => action.order,
  );
  return state;
}

OrderState _updateOrderSuccess(OrderState state, UpdateOrderSuccessAction action) {
  if (state.map != null) {
    state.map.update(
      "${action.order.id}",
      (v) => action.order,
      ifAbsent: () => action.order,
    );
  }
  return state;
}

OrderState _deleteOrderSuccess(OrderState state, DeleteOrderSuccessAction action) {
  if (state.map != null) {
    state.map.remove("${action.orderId}");
  }
  return state;
}

OrderState _createOrderLineItemSuccess(OrderState state, CreateOrderLineItemSuccessAction action) {
  Order cartOrder = state.cartOrder;
  if (cartOrder.items == null) {
    cartOrder.items = [];
  }
  cartOrder.items.add(action.lineItem);

  num subtotal = 0;
  num total = 0;
  num numberOfItems = 0;

  for (var i = 0; i < cartOrder.items.length; i++) {
    OrderLineItem lineItem = cartOrder.items[i];

    subtotal += lineItem.quantity * lineItem.price;
    total += lineItem.quantity * lineItem.price;
    numberOfItems += lineItem.quantity;
  }

  cartOrder.subtotal = subtotal;
  cartOrder.total = total;
  cartOrder.numberOfItems = numberOfItems;

  state.cartOrder = cartOrder;

  return state;
}

OrderState _updateOrderLineItemSuccess(OrderState state, UpdateOrderLineItemSuccessAction action) {
  if (state.cartOrder.items == null) {
    state.cartOrder.items = [];
  }
  state.cartOrder.items.add(action.lineItem);
  return state;
}

OrderState _deleteOrderLineItemSuccess(OrderState state, DeleteOrderLineItemSuccessAction action) {
  state.cartOrder.items.removeWhere((v) => v.id == action.lineItemId);
  return state;
}
