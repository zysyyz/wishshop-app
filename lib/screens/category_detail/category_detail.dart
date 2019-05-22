import 'dart:async';
import 'package:flutter/material.dart';
import '../../models/models.dart';
import '../../views/views.dart';
import '../../widgets/widgets.dart';

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

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return DefaultTabController(
      length: 6,
      child: Scaffold(
        appBar: DefaultAppBar(
          backgroundColor: Colors.white,
          title: Text(category.name),
          elevation: 0,
          bottom: PreferredSize(
            child: TabBar(
              labelPadding: EdgeInsets.only(left: 6, right: 6),
              isScrollable: true,
              tabs: [
                Tab(icon: Text('全部')),
                Tab(icon: Text('沙发1')),
                Tab(icon: Text('沙发2')),
                Tab(icon: Text('沙发3')),
                Tab(icon: Text('沙发4')),
                Tab(icon: Text('沙发5')),
              ],
              indicator: UnderlineTabIndicator(
                borderSide: BorderSide(color: theme.primaryColor, width: 3.0),
                insets: EdgeInsets.fromLTRB(40.0, 0, 40.0, 4.0),
              ),
            ),
            preferredSize: Size.fromHeight(60),
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            Container(),
            Container(),
            Container(),
            Container(),
            Container(),
            Container(),
          ],
          // controller: _tabController,
        ),
      ),
    );
  }

}
