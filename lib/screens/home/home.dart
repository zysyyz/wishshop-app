import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:redux/redux.dart' as redux;
import 'package:flutter_redux/flutter_redux.dart';
import '../../models/models.dart';
import '../../redux/redux.dart';
import '../../screens/screens.dart';
import './tab_homepage.dart';
import './tab_category.dart';
import './tab_cart.dart';
import './tab_mine.dart';

class _IconWithBadge extends StatelessWidget {
  final String icon;
  final Color color;
  final int badgeNumber;

  const _IconWithBadge({Key key, this.icon, this.color, this.badgeNumber}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.centerLeft,
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(top: 6, left: 12, right: 12),
          child: Image.asset(icon, color: color, width: 20),
        ),
        Positioned(
          top: 0,
          right: 0,
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

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _items = [
    {
      'title': '首页',
      'icon': 'assets/images/ic_tab_homepage.png',
      'badgeNumber': 0,
      'screen': TabHomepageScreen(),
    },
    {
      'title': '分类',
      'icon': 'assets/images/ic_tab_category.png',
      'badgeNumber': 0,
      'screen': TabCategoryScreen(),
    },
    {
      'title': '购物车',
      'icon': 'assets/images/ic_tab_shopping_cart.png',
      'badgeNumber': 8,
      'screen': TabCartScreen(),
    },
    {
      'title': '我的',
      'badgeNumber': 0,
      'icon': 'assets/images/ic_tab_mine.png',
      'screen': TabMineScreen(),
    }
  ];
  int _selectedIndex = 0;

  Widget _build(BuildContext context, _ViewModel vm) {
    List<Widget> stackItems = [];
    List<BottomNavigationBarItem> bottomNavigationBarItems = [];
    for (var i = 0; i < _items.length; i++) {
      bool isSelected = _selectedIndex == i;
      var item = _items[i];
      final title = item['title'];
      final icon = item['icon'];
      final badgeNumber = item['badgeNumber'] ?? 0;
      final screen = item['screen'];

      Offstage offstage = Offstage(
        offstage: !isSelected,
        child: TickerMode(
          enabled: isSelected,
          child: screen,
        ),
      );

      stackItems.add(offstage);

      BottomNavigationBarItem bottomNavigationBarItem = BottomNavigationBarItem(
        icon: _IconWithBadge(icon: icon, color: Colors.grey, badgeNumber: badgeNumber),
        activeIcon: _IconWithBadge(icon: icon, color: Colors.black, badgeNumber: badgeNumber),
        title: Text(title, style: TextStyle(fontSize: 10)),
      );
      bottomNavigationBarItems.add(bottomNavigationBarItem);
    }

    return Scaffold(
      body: Stack(children: stackItems),
      bottomNavigationBar: CupertinoTabBar(
        backgroundColor: Colors.white,
        border: Border(
          top: BorderSide(
            color: Theme.of(context).dividerColor,
            width: 0.0, // One physical pixel.
            style: BorderStyle.solid,
          ),
        ),
        items: bottomNavigationBarItems,
        currentIndex: _selectedIndex,
        inactiveColor: Colors.grey,
        activeColor: Colors.black,
        onTap: (int index) {
          if (index == 3 && vm.currentUser == null) {
            Navigator
              .of(context)
              .push(MaterialPageRoute(builder: (_) => LoginScreen(), fullscreenDialog: true));
            return;
          }
          setState(() {
            _selectedIndex = index;
          });
        },
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
      onWillChange: (_ViewModel vm) {
        if (vm.currentUser == null && _selectedIndex == 3) {
          setState(() {
            _selectedIndex = 0;
          });
        }
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
