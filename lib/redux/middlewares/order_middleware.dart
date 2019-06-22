import 'package:redux/redux.dart' as Redux;
import '../../models/models.dart';
import '../../networking/networking.dart';
import '../actions/app_actions.dart';
import '../states/app_state.dart';

List<Redux.Middleware<AppState>> createOrderMiddleware() {
  return [
    new Redux.TypedMiddleware<AppState, GetOrderListAction>(_createGetOrderListMiddleware()),
    new Redux.TypedMiddleware<AppState, GetOrderAction>(_createGetOrderMiddleware()),
    new Redux.TypedMiddleware<AppState, CreateOrderLineItemAction>(_createCreateOrderLineItemMiddleware()),
    new Redux.TypedMiddleware<AppState, UpdateOrderLineItemAction>(_createUpdateOrderLineItemMiddleware()),
    new Redux.TypedMiddleware<AppState, DeleteOrderLineItemAction>(_createDeleteOrderLineItemMiddleware()),
  ];
}

Redux.Middleware<AppState> _createGetOrderListMiddleware() {
  return (Redux.Store store, action, Redux.NextDispatcher next) async {
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

Redux.Middleware<AppState> _createGetOrderMiddleware() {
  return (Redux.Store store, action, Redux.NextDispatcher next) async {
    if (!(action is GetOrderAction)) return;

    try {
      Order order = await sharedApiClient.defaultStore.order(action.orderId).get();
      store.dispatch(new ReceiveOrderAction(order));
    } catch (error) {
      action.completer.completeError(error);
    }
  };
}

Redux.Middleware<AppState> _createCreateOrderLineItemMiddleware() {
  return (Redux.Store store, action, Redux.NextDispatcher next) async {
    if (!(action is CreateOrderLineItemAction)) return;

    try {
      Product product = action.product;
      num quantity = action.quantity ?? 1;

      print(product);
      print(quantity);

      OrderLineItem lineItem = new OrderLineItem(
        storeId: 1,
        label: product.name,
        price: product.price,
        originalPrice: product.originalPrice,
        quantity: quantity,
        subtotal: product.price * quantity,
        total: product.price * quantity,
      );

      print(lineItem.toJson());
      store.dispatch(new CreateOrderLineItemSuccessAction(lineItem));
    } catch (error) {
      action.completer.completeError(error);
    }
  };
}

Redux.Middleware<AppState> _createUpdateOrderLineItemMiddleware() {
  return (Redux.Store store, action, Redux.NextDispatcher next) async {
    if (!(action is UpdateOrderLineItemAction)) return;

    try {

      Product product = action.product;
      num quantity = action.quantity ?? 1;

      print(product);
      print(quantity);

      OrderLineItem lineItem = new OrderLineItem(
        storeId: 1,
        label: product.name,
        price: product.price,
        originalPrice: product.originalPrice,
        quantity: quantity,
        subtotal: product.price * quantity,
        total: product.price * quantity,
      );

      print(lineItem.toJson());

      store.dispatch(new UpdateOrderLineItemSuccessAction(lineItem));
    } catch (error) {
      print('>>>>>>>');
      print(error);
      action.completer.completeError(error);
    }
  };
}

Redux.Middleware<AppState> _createDeleteOrderLineItemMiddleware() {
  return (Redux.Store store, action, Redux.NextDispatcher next) async {
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
