import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:redux/redux.dart' as redux;
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import '../../exports.dart';

class CartScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _CartScreen();
}

class _CartScreen extends State<CartScreen> {

  bool _isSelectAll = false;

  Widget _buildBody(BuildContext context, _ViewModel vm) {
    List<Product> products = vm.listByFilter['categoryId=2'] ?? [];

    if (products.length == 0) {
      return ListEmptyIndicator();
      // return ListLoadIndicator();
    }

    return Container(
      height: MediaQuery.of(context).size.height,
      child: new StaggeredGridView.countBuilder(
        padding: EdgeInsets.only(top: 6, bottom: MediaQuery.of(context).viewInsets.bottom),
        crossAxisCount: 2,
        itemCount: products.length,
        itemBuilder: (BuildContext context, int index) {
          Product product = products[index];

          return CartListItem(
            product: product,
          );
        },
        staggeredTileBuilder: (index) {
          return new StaggeredTile.fit(2);
        },
      ),
    );
  }

  Widget _buildBottomNavigationBar(BuildContext context) {
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
            Row(
              children: <Widget>[
                Checkbox(
                  activeColor: Colors.green,
                  value: _isSelectAll,
                  onChanged: (value) {
                    setState(() {
                      _isSelectAll = value;
                    });
                  },
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _isSelectAll = !_isSelectAll;
                    });
                  },
                  child: Text(
                    "全选",
                    style: TextStyle(
                      fontWeight: FontWeight.w500
                    ),
                  ),
                )
              ]
            ),
            Expanded(
              flex: 1,
              child: Container(
                padding: EdgeInsets.only(right: 12),
                alignment: Alignment.centerRight,
                child: Text(
                  '¥0',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold
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
                    '下单',
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
      appBar: DefaultAppBar(
        backgroundColor: theme.scaffoldBackgroundColor,
        title: Text('购物车'),
        actions: <Widget>[
          IconButton(
            icon: Text('编辑'),
            onPressed: () {

            },
          ),
        ],
        bottom: PreferredSize(
          child: Container(),
          preferredSize: Size.fromHeight(0),
        ),
      ),
      body: _buildBody(context, vm),
      bottomNavigationBar: _buildBottomNavigationBar(context),
    );
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      converter: _ViewModel.fromStore,
      builder: (BuildContext context, _ViewModel vm) {
        return _build(context, vm);
      },
      onInit: (store) {
        store.dispatch(new GetProductListAction(categoryId: 2));
      },
    );
  }
}

class _ViewModel {
  final Map<String, List<Product>> listByFilter;

  _ViewModel({
    this.listByFilter,
  });

  static _ViewModel fromStore(redux.Store<AppState> store) {
    final productState = store.state.productState;
    return _ViewModel(
      listByFilter:productState.listByFilter,
    );
  }
}

