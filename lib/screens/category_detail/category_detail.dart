import 'package:flutter/material.dart';
import 'package:redux/redux.dart' as redux;
import 'package:flutter_redux/flutter_redux.dart';
import '../../exports.dart';

class CategoryDetailScreen extends StatefulWidget {
  final Category category;

  const CategoryDetailScreen({Key key, this.category}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _CategoryDetailScreenState(category);
}

class _CategoryDetailScreenState extends State<CategoryDetailScreen>
  with SingleTickerProviderStateMixin {

  ScrollController _scrollViewController;
  TabController _tabController;

  final Category category;

  _CategoryDetailScreenState(this.category);

  @override
  void initState() {
    super.initState();
    _scrollViewController = new ScrollController();
    _tabController = new TabController(vsync: this, length: 2);
  }

  @override
  void dispose() {
    _scrollViewController.dispose();
    _tabController.dispose();
    super.dispose();
  }

  Widget _build(BuildContext context, _ViewModel vm) {
    ThemeData theme = Theme.of(context);

    List<Category> categories = [];

    categories.add(category);
    categories.addAll(vm.listByFilter['parentId=${category.id}'] ?? []);

    return DefaultTabController(
      length: categories.length,
      child: Scaffold(
        appBar: CustomAppBar(
          title: Text(category.name),
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
                isScrollable: true,
                tabs: categories.map((item) => Tab(icon: Text(item.id == category.id ? '全部' : item.name))).toList(),
                indicatorSize: TabBarIndicatorSize.label,
                indicator: UnderlineTabIndicator(
                  borderSide: BorderSide(color: theme.primaryColor, width: 3.0),
                  // insets: EdgeInsets.fromLTRB(40.0, 0, 40.0, 4.0),
                ),
              ),
            ),
            preferredSize: Size.fromHeight(36),
          ),
        ),
        body: TabBarView(
          children: categories.map((item) => ProductGridView(category: item)).toList(),
          // controller: _tabController,
        ),
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
  final Map<String, List<Category>> listByFilter;

  _ViewModel({
    this.listByFilter,
  });

  static _ViewModel fromStore(redux.Store<AppState> store) {
    final categoryState = store.state.category;
    return _ViewModel(
      listByFilter:categoryState.listByFilter,
    );
  }
}
