import 'package:flutter/material.dart';

import '../../exports.dart';

class TabReviews extends StatefulWidget {
  final Product product;

  TabReviews(this.product);

  @override
  State<StatefulWidget> createState() => _TabReviewsState();
}

class _TabReviewsState extends State<TabReviews> {
  bool _loading = true;
  List<Review> _items = [];


  void _reloadData() async {
    Result<Review> result = await sharedApiClient.defaultStore.product(widget.product.id).reviews.list();
    setState(() {
      _items = result.items;
      _loading = false;
    });
  }

  @override
  void initState() {
    super.initState();

    this._reloadData();
  }

  @override
  Widget build(BuildContext context) {

    if (_loading) {
      return ListLoadIndicator();
    }

    return Container(
      color: Colors.white,
      child: ListView.separated(
        separatorBuilder: (context, index) {
          return Container(
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: Divider(indent: 52, height: 1));
        },
        padding: EdgeInsets.zero,
        itemCount: _items.length,
        itemBuilder: (BuildContext context, int index) {
          Review item = _items[index];
          return ReviewListItem(item);
        },
      ),
    );
  }
}
