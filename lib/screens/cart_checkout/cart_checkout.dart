import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:redux/redux.dart' as redux;
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../../exports.dart';

class CartCheckoutScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _CartCheckoutScreenState();
}

class _CartCheckoutScreenState extends State<CartCheckoutScreen> {
  Widget _buildBody(BuildContext context, _ViewModel vm) {
    List<OrderLineItem> lineItems = vm.cartOrder.items ?? [];

    return Container(
      height: MediaQuery.of(context).size.height,
      child: new StaggeredGridView.countBuilder(
        padding: EdgeInsets.only(top: 6, bottom: MediaQuery.of(context).viewInsets.bottom),
        crossAxisCount: 2,
        itemCount: lineItems.length,
        itemBuilder: (BuildContext context, int index) {
          OrderLineItem orderLineItem = lineItems[index];

          return CartListItem(orderLineItem);
        },
        staggeredTileBuilder: (index) {
          return new StaggeredTile.fit(2);
        },
      ),
    );
  }

  Widget _buildBottomNavigationBar(BuildContext context, _ViewModel vm) {
    final double additionalBottomPadding = math.max(MediaQuery.of(context).padding.bottom - 8.0, 0.0);
    return Container(
      color: Colors.white,
      padding: EdgeInsets.only(bottom: additionalBottomPadding),
      height: kBottomNavigationBarHeight + additionalBottomPadding,
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
              color: Theme.of(context).dividerColor,
              width: 0.0
            ),
            bottom: BorderSide(
              color: Theme.of(context).dividerColor,
              width: 0.0,
              style: additionalBottomPadding <= 0 ? BorderStyle.none : BorderStyle.solid,
            )
          )
        ),
        height: kBottomNavigationBarHeight,
        child: Row(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Container(
                padding: EdgeInsets.only(left: 16,),
                alignment: Alignment.centerLeft,
                child: Text(
                  '¥${vm.cartOrder.total}',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500
                  ),
                ),
              ),
            ),
            Container(
              alignment: Alignment.centerRight,
              child: SizedBox(
                width: 110,
                height: kBottomNavigationBarHeight,
                child: RaisedButton(
                  elevation: 0,
                  highlightElevation: 0,
                  child: Text(
                    '提交订单',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {

                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _build(BuildContext context, _ViewModel vm) {
    ThemeData theme = Theme.of(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        backgroundColor: theme.scaffoldBackgroundColor,
        title: Text('订单确认'),
        bottom: PreferredSize(
          child: Container(),
          preferredSize: Size.fromHeight(0),
        ),
      ),
      body: _buildBody(context, vm),
      bottomNavigationBar: _buildBottomNavigationBar(context, vm),
    );
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      converter: _ViewModel.fromStore,
      builder: (BuildContext context, _ViewModel vm) {
        return _build(context, vm);
      },
    );
  }
}

class _ViewModel {
  final Order cartOrder;

  _ViewModel({
    this.cartOrder,
  });

  static _ViewModel fromStore(redux.Store<AppState> store) {
    final orderState = store.state.orderState;
    return _ViewModel(
      cartOrder: orderState.cartOrder ?? new Order(),
    );
  }
}

