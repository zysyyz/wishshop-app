import 'package:flutter/material.dart';
import 'package:redux/redux.dart' as redux;
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import '../../exports.dart';

class TabReviews extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _TabReviewsState();
}

class _TabReviewsState extends State<TabReviews> {
  bool _loading = false;

  @override
  Widget build(BuildContext context) {

    if (_loading) {
      return ListLoadIndicator();
    }

    return Container(
      color: Colors.white,
      height: MediaQuery.of(context).size.height,
      child: new StaggeredGridView.countBuilder(
        padding: EdgeInsets.zero,
        crossAxisCount: 2,
        itemCount: 0,
        itemBuilder: (BuildContext context, int index) {
          return Container();
        },
        staggeredTileBuilder: (index) {
          return new StaggeredTile.fit(1);
        },
      ),
    );
  }
}
