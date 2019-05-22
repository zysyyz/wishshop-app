import 'dart:async';
import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import '../../models/models.dart';
import '../../redux/redux.dart';
import '../../views/views.dart';
import '../../widgets/widgets.dart';
import '../category_detail/category_detail.dart';

class HomeCategoryScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomeCategoryScreen();
}

class _HomeCategoryScreen extends State<HomeCategoryScreen> {
  PageController _pageController;
  ScrollController _scrollController;

  int _selectedIndex = 0;

  _pageListener() {
  }

  _scrollListener() {
  }

  @override
  void initState() {
    _pageController = PageController();
    _scrollController = ScrollController();

    _pageController.addListener(this._pageListener);
    _scrollController.addListener(this._scrollListener);

    super.initState();
  }

  Widget _buildBody(BuildContext context, _ViewModel vm) {
    ThemeData theme = Theme.of(context);

    if (vm.items.length == 0) {
      return ListLoadIndicator();
    }

    Category category = vm.items[_selectedIndex];
    List<Category> categories = new List()
      ..add(category)
      ..addAll(vm.listByFilter['parentId=${category.id}']);
    return Row(
      children: <Widget>[
        Container(
          width: 100,
          child: ListView.builder(
            itemCount: vm.items.length,
            itemBuilder: (context, index) {
              Category item = vm.items[index];
              return InkWell(
                splashColor: Colors.white,
                onTap: () {
                  _pageController.animateToPage(
                    index, 
                    duration: Duration(milliseconds: 1),
                    curve: Curves.linear
                  );
                  setState(() {
                    _selectedIndex = index;
                  });
                },
                child: Container(
                  height: 58,
                  alignment: Alignment.center,
                  child: Container(
                    padding: EdgeInsets.only(bottom: 2),
                    decoration: BoxDecoration(
                      border: Border(
                        top: BorderSide(color: Colors.transparent, width: 3),
                        bottom: BorderSide(color: _selectedIndex != index ? Colors.white : theme.primaryColor, width: 3),
                      )
                    ),
                    child: Text(
                      item.name,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        VerticalDivider(width: 1),
        Expanded(
          child: PageView.builder(
            controller: _pageController,  
            scrollDirection: Axis.vertical,
            onPageChanged: (index) {
              setState(() {
                _selectedIndex = index;
              });
            },
            itemCount: categories.length,
            itemBuilder: (context, index) {
              return Container(
                height: MediaQuery.of(context).size.height,
                child: new StaggeredGridView.countBuilder(
                  crossAxisCount: 2,
                  itemCount: 8,
                  itemBuilder: (BuildContext context, int index) {
                    if (index == 0) {
                      return Container(
                        color: theme.dividerColor,
                        height: 100,
                        child: FadeInImage(
                          placeholder: AssetImage("images/placeholder.jpg"),
                          image: NetworkImage(
                            category.imageUrl,
                          ),
                          fit: BoxFit.cover,
                        ),
                      );
                    }

                    Category category2 = categories[index];

                    return InkWell(
                      onTap: () {
                        Navigator
                          .of(context)
                          .push(MaterialPageRoute(builder: (_) => CategoryDetailScreen(category: category2)));
                      },
                      child: Container(
                        height: 100,
                        child: Container(
                          child: ClipRRect(
                            borderRadius: new BorderRadius.all(Radius.circular(0.0)),
                            child: FadeInImage(
                              placeholder: AssetImage("images/placeholder.jpg"),
                              image: NetworkImage(
                                category2.imageUrl,
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                  staggeredTileBuilder: (index) {
                    if (index == 0) return new StaggeredTile.count(2, 1);

                    return new StaggeredTile.fit(1);
                  },
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _build(BuildContext context, _ViewModel vm) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: DefaultAppBar(
        title: SearchBar(),
        titleSpacing: 0.0,
      ),
      body: _buildBody(context, vm),
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
        store.dispatch(new GetCategoryListAction());
      },
    );
  }
}

class _ViewModel {
  final List<Category> items;
  final Map<String, List<Category>> listByFilter;

  _ViewModel({
    this.items,
    this.listByFilter,
  });

  static _ViewModel fromStore(Store<AppState> store) {
    final categoryState = store.state.category;
    return _ViewModel(
      items: categoryState.listByFilter['parentId=0'] ?? [],
      listByFilter:categoryState.listByFilter,
    );
  }
}
