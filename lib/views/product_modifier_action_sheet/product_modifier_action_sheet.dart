import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:redux/redux.dart' as redux;
import 'package:flutter_redux/flutter_redux.dart';
import '../../exports.dart';
import './modifier_option_grid_item.dart';

class ProductInfo extends StatelessWidget {
  final Product product;

  ProductInfo(this.product);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.only(top: 20, bottom: 20, left: 16),
      child: Row(
        children: <Widget>[
          Container(
            height: 70,
            width: 70,
            decoration: new BoxDecoration(
              border: new Border.all(color: Theme.of(context).dividerColor, width: 1.0)
            ),
            padding: EdgeInsets.all(0),
            child: ClipRRect(
              borderRadius: new BorderRadius.all(Radius.circular(0.0)),
              child: CustomImage(
                product.imageUrl,
                fit: BoxFit.fitHeight,
              ),
            ),
          ),
          Padding(padding: EdgeInsets.only(left: 16),),
          Expanded(
            child: Container(
              height: 70,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Text(
                    product.name,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff333333),
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Padding(padding: EdgeInsets.only(top: 2),),
                  Expanded(flex: 1, child: Container(),),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Text(
                        '￥${product.price}',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: product.originalPrice == null || product.originalPrice <= 0 ? Color(0xff333333) : Colors.red,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 4, bottom: 2),
                        child: product.originalPrice == null || product.originalPrice <= 0 ? Container() : Text(
                          '￥${product.originalPrice}',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class ProductModifierActionSheet extends StatelessWidget {
  final Product product;

  const ProductModifierActionSheet({Key key, this.product}) : super(key: key);

  Widget _buildModifierItem(BuildContext context, Modifier modifier) {
    var optionViews = modifier.options
      .map((modifierOption) {
        return InkWell(
          onTap: () {

          },
          child: ModifierOptionGridItem(modifier, modifierOption),
        );
      }).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: 12, bottom: 12),
          child: Text(
            modifier?.title ?? 'n/a',
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: optionViews,
        )
      ],
    );
  }

  Widget _buildModifierPart(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: product.modifiers.map((modifier) {
          return Container(
            child: _buildModifierItem(context, modifier),
          );
        }).toList(),
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
        child: Row(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: SizedBox(
                width: double.infinity,
                height: kBottomNavigationBarHeight,
                child: RaisedButton(
                  color: Colors.white,
                  elevation: 0,
                  highlightElevation: 0,
                  child: Text(
                    '立即购买',
                  ),
                  onPressed: () {
                  },
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: SizedBox(
                width: 110,
                height: kBottomNavigationBarHeight,
                child: RaisedButton(
                  elevation: 0,
                  highlightElevation: 0,
                  child: Text(
                    '加入购物车',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                    vm.createOrderLineItem();
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
    return Container(
      constraints: BoxConstraints(
        maxHeight: (MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top) * 0.8,
        minHeight: (MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top) * 0.6,
      ),
      child: Column(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                bottom: BorderSide(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  width: 6.0,
                )
              )
            ),
            child: Column(
              children: <Widget>[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: Container(
                        child: ProductInfo(product),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 6),
                      child: IconButton(
                        icon: Image.asset('assets/images/ic_menu_close.png', width: 18, height: 18,),
                        onPressed: () {
                          Navigator
                          .of(context)
                          .pop();
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: SingleChildScrollView(
              child: Container(
                color: Colors.white,
                padding: EdgeInsets.all(16),
                child: Column(
                  children: <Widget>[
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(
                          width: 32,
                          height: 32,
                          child: OutlineButton(
                            padding: EdgeInsets.zero,
                            child: Image.asset(
                              'assets/images/ic_qty_minus.png',
                              color: Theme.of(context).buttonColor,
                              width: 14,
                            ),
                            color: Theme.of(context).buttonColor,
                            onPressed: () {

                            },
                          ),
                        ),
                        Container(
                          height: 33,
                          alignment: Alignment.center,
                          constraints: BoxConstraints(
                            minWidth: 48,
                          ),
                          decoration: BoxDecoration(
                            border: Border(
                              top: BorderSide(
                                color: Theme.of(context).buttonColor,
                                width: 1.0,
                              ),
                              bottom: BorderSide(
                                color: Theme.of(context).buttonColor,
                                width: 1.0,
                              )
                            ),
                          ),
                          child: Text(
                            '1',
                            style: TextStyle(
                              fontSize: 14,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 32,
                          height: 32,
                          child: OutlineButton(
                            padding: EdgeInsets.zero,
                            child: Image.asset(
                              'assets/images/ic_qty_plus.png',
                              color: Theme.of(context).buttonColor,
                              width: 14,
                            ),
                            color: Theme.of(context).buttonColor,
                            onPressed: () {

                            },
                          ),
                        ),
                      ],
                    ),
                    _buildModifierPart(context),
                  ],
                ),
              ),
            )
          ),
          _buildBottomNavigationBar(context, vm),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      converter: (store) {
        return _ViewModel.fromStore(store, product: product);
      },
      builder: (BuildContext context, _ViewModel vm) {
        return _build(context, vm);
      },
    );
  }
}

class _ViewModel {
  final Product product;
  final Future<OrderLineItem> Function() createOrderLineItem;
  final Future<OrderLineItem> Function() updateOrderLineItem;

  _ViewModel({
    this.product,
    this.createOrderLineItem,
    this.updateOrderLineItem,
  });

  static _ViewModel fromStore(redux.Store<AppState> store, {
    product: Product,
  }) {
    final productState = store.state.productState;
    Product _product = productState.get('${product.id}') ?? product;
    return _ViewModel(
      product: _product,
      createOrderLineItem: () {
        var action = new CreateOrderLineItemAction(
          number: 'cart',
          quantity: 1,
          product: _product,
        );

        store.dispatch(action);

        return action.completer.future;
      },
      updateOrderLineItem: () {
        var action = new UpdateOrderLineItemAction(
          number: 'cart',
        );
        store.dispatch(action);

        return action.completer.future;
      }
    );
  }
}
