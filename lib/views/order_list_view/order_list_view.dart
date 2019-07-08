import 'package:flutter/material.dart';
import 'package:redux/redux.dart' as redux;
import 'package:flutter_redux/flutter_redux.dart';
import '../../exports.dart';

class OrderListView extends StatefulWidget {
  String userId;

  OrderListView({this.userId});

  @override
  State<StatefulWidget> createState() => _OrderListViewState();
}

class _OrderListViewState extends State<OrderListView> {
  Widget _build(BuildContext context, _ViewModel vm) {
    List<Order> items = vm.items;

    if (items.length == 0) {
      items.add(new Order());
      items.add(new Order());
      items.add(new Order());
      items.add(new Order());
      items.add(new Order());
      items.add(new Order());
      items.add(new Order());
      items.add(new Order());
    }

    return PullToRefreshLayout(
      initialCount: items.length,
      onLoadData: vm.fetchItems,
      child: ListView.builder(
        padding: EdgeInsets.only(top: 5, bottom: 5),
        shrinkWrap: true,
        itemCount: items.length,
        itemBuilder: (context, index) {
          return OrderListItem(items[index]);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      converter: (store) => _ViewModel.fromStore(store,
        userId: widget.userId,
      ),
      builder: (BuildContext context, _ViewModel vm) {
        return _build(context, vm);
      },
    );
  }
}

class _ViewModel {
  final List<Order> items;
  final Future<Result<Order>> Function(int page) fetchItems;

  _ViewModel({
    this.items,
    this.fetchItems,
  });

  static _ViewModel fromStore(redux.Store<AppState> store, {
    userId: String,
  }) {
    final orderState = store.state.orderState;

    String filter = 'all';

    return _ViewModel(
      items: orderState.listByFilter[filter] ?? [],
      fetchItems: (page) {
        var action = new GetOrderListAction(
          page: page,
        );

        store.dispatch(action);

        return action.completer.future;
      }
    );
  }
}
