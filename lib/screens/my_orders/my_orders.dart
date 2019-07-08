
import 'package:flutter/material.dart';
import 'package:redux/redux.dart' as redux;
import 'package:flutter_redux/flutter_redux.dart';
import '../../exports.dart';

class MyOrdersScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MyOrdersScreenState();
}

class _MyOrdersScreenState extends State<MyOrdersScreen> {

    List _tabItems = [
    {
      'title': '全部',
    },
    {
      'title': '待付款',
    },
    {
      'title': '待收货',
    },
    {
      'title': '已完成',
    },
    {
      'title': '已取消',
    },
  ];

  Widget _buildBody(BuildContext context, _ViewModel vm) {
    return TabBarView(
      children: _tabItems.map((item) => OrderListView(userId: 'item')).toList(),
      // controller: _tabController,
    );
  }

  Widget _build(BuildContext context, _ViewModel vm) {
    ThemeData theme = Theme.of(context);

    return DefaultTabController(
      length: _tabItems.length,
      child: Scaffold(
        appBar: CustomAppBar(
          title: Text('我的订单'),
          elevation: 0,
          bottom: PreferredSize(
            child: Container(
              padding: EdgeInsets.only(left: 4),
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border(
                  bottom: BorderSide(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    width: 1.0,
                  )
                )
              ),
              child: TabBar(
                labelPadding: EdgeInsets.only(left: 16, right: 16),
                isScrollable: false,
                tabs: _tabItems.map((item) => Tab(icon: Text(item['title']))).toList(),
                // indicatorSize: TabBarIndicatorSize.label,
                indicator: UnderlineTabIndicator(
                  borderSide: BorderSide(color: theme.primaryColor, width: 3.0),
                  insets: EdgeInsets.fromLTRB(32.0, 0, 32.0, 2.0),
                ),
              ),
            ),
            preferredSize: Size.fromHeight(36),
          ),
        ),
        body: _buildBody(context, vm),
      ),
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
  final User currentUser;

  _ViewModel({
    this.currentUser,
  });

  static _ViewModel fromStore(redux.Store<AppState> store) {
    final authState = store.state.auth;

    return _ViewModel(
      currentUser: authState.user,
    );
  }
}
