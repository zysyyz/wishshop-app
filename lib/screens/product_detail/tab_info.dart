import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:redux/redux.dart' as redux;
import 'package:flutter_redux/flutter_redux.dart';
import '../../exports.dart';

class _BadgeContainer extends StatelessWidget {
  final Widget child;
  final int badgeNumber;

  const _BadgeContainer({Key key, this.child, this.badgeNumber}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.centerLeft,
      children: <Widget>[
        child,
        Positioned(
          top: 8,
          right: 8,
          child: badgeNumber <= 0 ? Container() : Container(
            alignment: Alignment.center,
            padding: EdgeInsets.only(left: 3, right: 3, bottom: 1),
            decoration: new BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.circular(8),
            ),
            constraints: BoxConstraints(
              minWidth: 16,
              minHeight: 16,
            ),
            child: Text(
              '${badgeNumber > 99 ? '99+' : badgeNumber}',
              style: new TextStyle(
                color: Colors.white,
                fontSize: 10,
                fontWeight: FontWeight.w500,
                letterSpacing: 0.2,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        )
      ],
    );
  }
}

class TabInfo extends StatefulWidget {
  final Product product;
  final ScrollController controller;

  const TabInfo(this.product, {this.controller});
  @override
  State<StatefulWidget> createState() => _TabInfoState();
}

class _TabInfoState extends State<TabInfo> {
  bool _loading = false;

  void _handlePressAddToCart(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (builder) {
        return ProductModifierActionSheet(product: this.widget.product,);
      },
      isScrollControlled: true,
    );
  }

  Widget _buildContents(BuildContext context, _ViewModel vm) {
    Product product = vm.product;
    if (product.contents == null) return Container();
    return Container(
      child: Column(
        children: product.contents.map((content) {
          return Container(
            child: FadeInImage(
              placeholder: AssetImage("images/placeholder.jpg"),
              image: NetworkImage(
                content.content,
              ),
              fit: BoxFit.cover,
            ),
          );
        }).toList(),
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
        child: Row(
          children: <Widget>[
            _BadgeContainer(
              badgeNumber: 8,
              child: SizedBox(
                width: 64,
                height: kBottomNavigationBarHeight,
                child: RaisedButton(
                  color: Colors.white,
                  elevation: 0,
                  highlightElevation: 0,
                  padding: EdgeInsets.zero,
                  child: Image.asset('assets/images/ic_cart.png'),
                  onPressed: () {
                    Navigator
                      .of(context)
                      .push(MaterialPageRoute(builder: (_) => CartScreen()));
                  },
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 12, bottom: 12),
              child: VerticalDivider(width: 1),
            ),
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
                    // style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    this._handlePressAddToCart(context);
                  },
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: SizedBox(
                width: double.infinity,
                height: kBottomNavigationBarHeight,
                child: RaisedButton(
                  elevation: 0,
                  highlightElevation: 0,
                  child: Text(
                    '加入购物车',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    this._handlePressAddToCart(context);
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
    ThemeData themeData = Theme.of(context);
    Product product = vm.product;

    bool _favorited = product.favoritedAt != null;

    if (_loading) {
      return ListLoadIndicator();
    }

    List<String> imageList = new List();
    imageList.add(product.imageUrl);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        controller: this.widget.controller,
        child: Column(
          children: <Widget>[
            Column(
              children: <Widget>[
                AnimatedContainer(
                  padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
                  duration: Duration(milliseconds: 500),
                  curve: Curves.decelerate,
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.width,
                  child: PageView.builder(
                    onPageChanged: (index) {
                      // setState(() {
                      //   _selectedIndex = index;
                      // });
                    },
                    itemCount: imageList.length,
                    itemBuilder: (context, index) {
                      String imageUrl = imageList[index];
                      return Container(
                        height: double.infinity,
                        child: FadeInImage(
                          placeholder: AssetImage("images/placeholder.jpg"),
                          image: NetworkImage(
                            imageUrl,
                          ),
                          fit: BoxFit.contain,
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
            Container(
              padding: EdgeInsets.fromLTRB(16, 16, 6, 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          product.name,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xff333333),
                          ),
                        ),
                      ),
                      IconButton(
                        color: Colors.white,
                        padding: EdgeInsets.zero,
                        icon: Image.asset(
                          _favorited
                            ? 'assets/images/ic_menu_star.png'
                            : 'assets/images/ic_menu_outline_star.png'
                        ),
                        iconSize: 38,
                        onPressed: () {

                        },
                      )
                    ],
                  ),
                  Container(height: 6),
                  Text(
                    product.summary,
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  Container(height: 16),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Text(
                        '￥${product.price}',
                        style: TextStyle(
                          fontSize: 20,
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
                  ),
                ],
              ),
            ),
            Container(height: 6, color: themeData.scaffoldBackgroundColor,),
            Container(
              padding: EdgeInsets.all(16),
              child: Text(
                product.description,
                style: TextStyle(
                  fontSize: 14,
                ),
              ),
            ),
            // 构建端口内容详情
            _buildContents(context, vm),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(context),
    );
  }

  @override
  Widget build(BuildContext context) {
    Product product = widget.product;
    return StoreConnector<AppState, _ViewModel>(
      converter: (store) {
        return _ViewModel.fromStore(store, product: product);
      },
      builder: (BuildContext context, _ViewModel vm) {
        return _build(context, vm);
      },
      onInit: (store) async {
        var action = new GetProductAction(product.id);
        action.completer.future.then((_){
          setState(() {
            _loading = false;
          });
        });

        store.dispatch(action);
      },
    );
  }
}

class _ViewModel {
  final Product product;

  _ViewModel({
    this.product,
  });

  static _ViewModel fromStore(redux.Store<AppState> store, {
    product: Product,
  }) {
    final productState = store.state.productState;
    return _ViewModel(
      product: productState.get('${product.id}') ?? product,
    );
  }
}

