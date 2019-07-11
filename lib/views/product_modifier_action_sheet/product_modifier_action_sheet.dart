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
                      fontWeight: FontWeight.w500,
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
                          fontWeight: FontWeight.w500,
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

class ProductModifierActionSheet extends StatefulWidget {
  final String mode;
  final Product product;
  final OrderLineItem lineItem;

  const ProductModifierActionSheet({Key key, this.mode, this.product, this.lineItem}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ProductModifierActionSheetState();
}

class _ProductModifierActionSheetState extends State<ProductModifierActionSheet> {
  int _quantity = 1;

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
    List<Modifier> modifiers = widget.product.modifiers;
    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: modifiers.map((modifier) {
          return Container(
            child: _buildModifierItem(context, modifier),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildBottomNavigationBar(BuildContext context, _ViewModel vm) {
    final double additionalBottomPadding = math.max(MediaQuery.of(context).padding.bottom - 8.0, 0.0);

    List<Widget> buttons = [];

    if (widget.mode == 'buyNow') {
      buttons.add(
        Expanded(
          flex: 1,
          child: SizedBox(
            width: double.infinity,
            height: kBottomNavigationBarHeight,
            child: RaisedButton(
              elevation: 0,
              highlightElevation: 0,
              child: Text(
                '立即下单',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
        ),
      );
    } else if (widget.mode == 'addToCart') {
      buttons.add(
        Expanded(
          flex: 1,
          child: SizedBox(
            width: 110,
            height: kBottomNavigationBarHeight,
            child: RaisedButton(
              elevation: 0,
              highlightElevation: 0,
              child: Text(
                '确定加入',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                vm.createOrderLineItem(_quantity);
              },
            ),
          ),
        )
      );
    } else {
      buttons.addAll(
        [
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
                  vm.createOrderLineItem(_quantity);
                },
              ),
            ),
          ),
        ],
      );
    }

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
          children: buttons,
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
                        child: ProductInfo(widget.product),
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
                              if (_quantity <= 1) return;
                              setState(() {
                                _quantity -= 1;
                              });
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
                            '$_quantity',
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
                              setState(() {
                                _quantity += 1;
                              });
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
        return _ViewModel.fromStore(store, product: widget.product);
      },
      builder: (BuildContext context, _ViewModel vm) {
        return _build(context, vm);
      },
    );
  }
}

class _ViewModel {
  final Product product;
  final Future<OrderLineItem> Function(int quantity) createOrderLineItem;
  final Future<OrderLineItem> Function(int quantity) updateOrderLineItem;

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
      createOrderLineItem: (quantity) {
        var action = new CreateOrderLineItemAction(
          number: 'cart',
          quantity: quantity,
          product: _product,
        );

        store.dispatch(action);

        return action.completer.future;
      },
      updateOrderLineItem: (quantity) {
        var action = new UpdateOrderLineItemAction(
          number: 'cart',
          quantity: quantity,
        );
        store.dispatch(action);

        return action.completer.future;
      }
    );
  }
}
