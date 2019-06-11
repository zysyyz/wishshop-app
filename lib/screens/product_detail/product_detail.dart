import 'package:flutter/material.dart';
import '../../exports.dart';
import './tab_info.dart';
import './tab_products.dart';
import './tab_reviews.dart';
import './tab_specification.dart';

class ProductDetailScreen extends StatefulWidget {
  final Product product;

  ProductDetailScreen(this.product);

  @override
  _ProductDetailScreenState createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen>
    with SingleTickerProviderStateMixin/*<-- This is for the controllers*/ {
  TabController _tabController; // To control switching tabs
  ScrollController _scrollViewController; // To control scrolling

  int _selectedIndex = 0;
  double _opacity = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 4);
    _tabController.addListener(() {
      print(_tabController.index);
      setState(() {
        if (_tabController.index == 0) {
          double n = _scrollViewController.position.pixels / 300;
          if (n > 1) {
            _opacity = 1;
          } else if (n < 0) {
            _opacity = 0;
          } else {
            _opacity = n;
          }
        } else {
          _opacity = 1;
        }
        _selectedIndex = _tabController.index;
      });
    });
    _scrollViewController = ScrollController();
    _scrollViewController.addListener(() {
      print(_scrollViewController.position.pixels);
      setState(() {
        _opacity = 1;
        if (_selectedIndex == 0) {
          double n = _scrollViewController.position.pixels / 300;
          if (n > 1) {
            _opacity = 1;
          } else if (n < 0) {
            _opacity = 0;
          } else {
            _opacity = n;
          }
        }
        print(_opacity);
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
    _scrollViewController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);

    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height,
            child: TabBarView(
              controller: _tabController,
              children: <Widget>[
                Container(
                  color: Colors.white,
                  child: TabInfo(
                    this.widget.product,
                    controller: _scrollViewController,
                  ),
                ),
                Container(
                  child: TabSpecification(),
                ),
                Container(
                  child: TabReviews(),
                ),
                Container(
                  margin: EdgeInsets.only(top: kToolbarHeight + MediaQuery.of(context).padding.top + 36),
                  child: TabProducts(category: new Category(id: 2),),
                ),
              ],
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: AnimatedContainer(
              duration: Duration(milliseconds: 500),
              color: themeData.scaffoldBackgroundColor.withOpacity(_opacity),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Container(
                    alignment: Alignment.bottomCenter,
                    padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top, bottom: 0),
                    height: kToolbarHeight + MediaQuery.of(context).padding.top,
                    child: Material(
                      color: Colors.transparent,
                      child: NavigationToolbar(
                        leading: IconButton(
                          icon: Icon(Icons.arrow_back_ios, size: 20,),
                          onPressed: () {
                            Navigator.maybePop(context);
                          }
                        ),
                        middle: AnimatedOpacity(
                          duration: Duration(milliseconds: 500),
                          opacity: _opacity,
                          child: Text(
                            this.widget.product.name,
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        trailing: IconButton(
                          icon: Image.asset('assets/images/ic_menu_share.png'),
                          onPressed: () {
                            showModalBottomSheet(
                              context: context,
                              builder: (builder) {
                                return ProductShareActionSheet(product: null);
                              }
                            );
                          },
                        ),
                        // middleSpacing: widget.titleSpacing,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 36,
                    child: AnimatedOpacity(
                      duration: Duration(milliseconds: 500),
                      opacity: _opacity,
                      child: TabBar(
                        tabs: <Widget>[
                          Tab(
                            child: Text("商品"),
                          ),
                          Tab(
                            child: Text("参数"),
                          ),
                          Tab(
                            child: Text("评价"),
                          ),
                          Tab(
                            child: Text("推荐"),
                          ),
                        ],
                        indicatorSize: TabBarIndicatorSize.label,
                        indicator: UnderlineTabIndicator(
                          borderSide: BorderSide(color: themeData.primaryColor, width: 3.0),
                        ),
                        controller: _tabController,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
