import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../exports.dart';


class PullToRefreshLayout extends StatefulWidget {
  Future<Result<dynamic>> Function(int page) onLoadData;
  int initialCount = 0;
  final Widget child;

  PullToRefreshLayout({
    Key key,
    this.onLoadData,
    this.initialCount,
    this.child,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _PullToRefreshLayoutState();
}

class _PullToRefreshLayoutState extends State<PullToRefreshLayout> {
  bool _firstLoading = true;
  int _currentPage = 1;

  RefreshController _refreshController;

  @override
  void initState() {
    super.initState();

    _refreshController = RefreshController(
      initialRefresh: widget.initialCount > 0,
    );

    if (widget.initialCount > 0) {
      _firstLoading = false;
    } else if (widget.onLoadData != null) {
      this._handleLoadData(0);
    }
  }

  void dispose(){
    _refreshController.dispose();
    super.dispose();
  }

  void _handleLoadData(int currentPage) {
    if (widget.onLoadData != null) {
      Future<Result<dynamic>> future = widget.onLoadData(currentPage);
      future
        .then((result) {
          if (currentPage == 1) {
            _refreshController.resetNoData();
            _refreshController.refreshCompleted();
          } else {
            _refreshController.loadComplete();
          }

          Pagination pagination = result.pagination;

          if ((pagination.currentPage) >= pagination.total) {
            _refreshController.loadNoData();
          }
          setState(() {
            _firstLoading = false;
            _currentPage = pagination.currentPage;
          });
        })
        .catchError((error) {
          if (currentPage == 1) {
            _refreshController.refreshFailed();
          } else {
            _refreshController.loadNoData();
          }
          setState(() {
            _firstLoading = false;
          });
        });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        !_firstLoading ? Container() : ListLoadIndicator(),
        SmartRefresher(
          enablePullDown: widget.onLoadData != null,
          enablePullUp: widget.onLoadData != null,
          header: ClassicHeader(),
          footer: ClassicFooter(),
          controller: _refreshController,
          onRefresh: () {
            this._handleLoadData(1);
          },
          onLoading: () {
            this._handleLoadData(_currentPage + 1);
          },
          child: widget.child,
        )
      ],
    );
  }
}
