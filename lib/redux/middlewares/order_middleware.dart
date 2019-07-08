import 'package:redux/redux.dart' as redux;
import '../../models/models.dart';
import '../../networking/networking.dart';
import '../actions/app_actions.dart';
import '../states/app_state.dart';

List<redux.Middleware<AppState>> createOrderMiddleware() {
  return [
    new redux.TypedMiddleware<AppState, GetOrderListAction>(_createGetOrderListMiddleware()),
    new redux.TypedMiddleware<AppState, GetOrderAction>(_createGetOrderMiddleware()),
    new redux.TypedMiddleware<AppState, CreateOrderLineItemAction>(_createCreateOrderLineItemMiddleware()),
    new redux.TypedMiddleware<AppState, UpdateOrderLineItemAction>(_createUpdateOrderLineItemMiddleware()),
    new redux.TypedMiddleware<AppState, DeleteOrderLineItemAction>(_createDeleteOrderLineItemMiddleware()),
  ];
}

redux.Middleware<AppState> _createGetOrderListMiddleware() {
  return (redux.Store store, action, redux.NextDispatcher next) async {
    if (!(action is GetOrderListAction)) return;

    try {
      Result<Order> result = await sharedApiClient.defaultStore.orders.list(
        page: action.page ?? 1,
      );
      store.dispatch(new ReceiveOrderListAction(result));
      action.completer.complete(result);
    } catch (error) {
      action.completer.completeError(error);
    }
  };
}

redux.Middleware<AppState> _createGetOrderMiddleware() {
  return (redux.Store store, action, redux.NextDispatcher next) async {
    if (!(action is GetOrderAction)) return;

    try {
      Order order = await sharedApiClient.defaultStore.order(action.orderId).get();
      store.dispatch(new ReceiveOrderAction(order));
    } catch (error) {
      action.completer.completeError(error);
    }
  };
}

redux.Middleware<AppState> _createCreateOrderLineItemMiddleware() {
  return (redux.Store store, action, redux.NextDispatcher next) async {
    if (!(action is CreateOrderLineItemAction)) return;

    try {
      Product product = action.product;
      num quantity = action.quantity ?? 1;

      OrderLineItem lineItem = new OrderLineItem(
        storeId: 1,
        label: product.name,
        price: product.price,
        originalPrice: product.originalPrice,
        quantity: quantity,
        subtotal: product.price * quantity,
        total: product.price * quantity,
      );

      store.dispatch(new CreateOrderLineItemSuccessAction(lineItem));
    } catch (error) {
      action.completer.completeError(error);
    }
  };
}

redux.Middleware<AppState> _createUpdateOrderLineItemMiddleware() {
  return (redux.Store store, action, redux.NextDispatcher next) async {
    if (!(action is UpdateOrderLineItemAction)) return;

    try {

      Product product = action.product;
      num quantity = action.quantity ?? 1;

      OrderLineItem lineItem = new OrderLineItem(
        storeId: 1,
        label: product.name,
        price: product.price,
        originalPrice: product.originalPrice,
        quantity: quantity,
        subtotal: product.price * quantity,
        total: product.price * quantity,
      );

      store.dispatch(new UpdateOrderLineItemSuccessAction(lineItem));
    } catch (error) {
      action.completer.completeError(error);
    }
  };
}

redux.Middleware<AppState> _createDeleteOrderLineItemMiddleware() {
  return (redux.Store store, action, redux.NextDispatcher next) async {
    if (!(action is DeleteOrderLineItemAction)) return;

    try {
      store.dispatch(new DeleteOrderLineItemAction(
        number: action.number,
      ));
    } catch (error) {
      action.completer.completeError(error);
    }
  };
}
