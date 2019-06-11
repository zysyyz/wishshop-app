import 'package:flutter/material.dart';
import 'package:redux/redux.dart' as redux;
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import '../../exports.dart';

class _SearchBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Color(0xfff1f1f1),
      margin: EdgeInsets.fromLTRB(16, 10, 16, 10),
      child: FlatButton(
        padding: EdgeInsets.only(left: 10, right: 10),
        child: Row(
          children: <Widget>[
            Image.asset(
              'assets/images/ic_menu_search.png',
              color: Color(0xffa3a3a3),
              width: 20,
              height: 20,
            ),
            Padding(padding: EdgeInsets.only(left: 6)),
            Text(
              "搜索...",
              style: TextStyle(
                color: Color(0xffa3a3a3),
                fontSize: 15,
                fontWeight: FontWeight.normal
              ),
            )
          ],
        ),
        onPressed: () {
          Navigator
            .of(context)
            .push(MaterialPageRoute(builder: (_) => SearchScreen()));
        },
      ),
    );
  }
}

class TabCategory extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _TabCategoryState();
}

class _TabCategoryState extends State<TabCategory> {
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

    List<Category> firstLevelCategories = vm.listByFilter['parentId=0'] ?? [];

    if (firstLevelCategories.length == 0) {
      return ListLoadIndicator();
    }

    Category selectedCategory = firstLevelCategories[_selectedIndex];
    List<Category> categories = new List()
      ..add(selectedCategory);

    List<Category> secondLevelCategories = vm.listByFilter['parentId=${selectedCategory.id}'] ?? [];

    for (var i = 0; i < secondLevelCategories.length; i++) {
      Category category = secondLevelCategories[i];
      List<Category> thirdLevelCategories = vm.listByFilter['parentId=${category.id}'] ?? [];

      categories.add(category);
      categories.addAll(thirdLevelCategories);
    }

    categories = categories.where((category) => category.imageUrl != null && category.imageUrl.isNotEmpty).toList();

    return Row(
      children: <Widget>[
        Container(
          width: 100,
          child: ListView.builder(
            itemCount: firstLevelCategories.length,
            itemBuilder: (context, index) {
              Category category = firstLevelCategories[index];
              return InkWell(
                splashColor: Colors.white,
                onTap: () {
                  setState(() {
                    _selectedIndex = index;
                  });

                  // _pageController.animateToPage(
                  //   index,
                  //   duration: Duration(milliseconds: 1),
                  //   curve: Curves.linear
                  // );
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
                      category.name,
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
                  padding: EdgeInsets.all(8),
                  crossAxisCount: 2,
                  itemCount: categories.length,
                  itemBuilder: (BuildContext context, int index) {
                    Category parentCategory;
                    Category category = categories[index];
                    if (category.level == 2) {
                      parentCategory = categories.firstWhere((v) => v.id == category.parentId);
                    }

                    switch (category.level) {
                      case 0:
                        return CategoryListItem(
                          category: category,
                          parentCategory: parentCategory,
                        );
                      case 1:
                        return CategoryListSection(
                          category: category,
                          parentCategory: parentCategory,
                        );
                      case 2:
                        return CategoryGridItem(
                          category: category,
                          parentCategory: parentCategory,
                        );
                    }
                  },
                  staggeredTileBuilder: (index) {
                    Category category = categories[index];
                    if (category.level == 0 || category.level == 1) {
                      return new StaggeredTile.fit(2);
                    }
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
        title: _SearchBar(),
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
