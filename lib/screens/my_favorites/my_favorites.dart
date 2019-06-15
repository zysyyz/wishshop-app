import 'package:flutter/material.dart';
import 'package:redux/redux.dart' as redux;
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import '../../exports.dart';

class MyFavoritesScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MyFavoritesScreenState();
}

class _MyFavoritesScreenState extends State<MyFavoritesScreen> {
  Widget _buildBody(BuildContext context, _ViewModel vm) {
    List<Favorite> items = vm.items;

    return PullToRefreshLayout(
      initialCount: items.length,
      onLoadData: (page) async {
        return vm.fetchItems(page);
      },
      child: StaggeredGridView.countBuilder(
        padding: EdgeInsets.zero,
        crossAxisCount: 2,
        itemCount: items.length,
        itemBuilder: (BuildContext context, int index) {
          Favorite favorite = items[index];

          return ProductListItem(
            product: favorite.product,
          );
        },
        staggeredTileBuilder: (index) {
          return new StaggeredTile.fit(2);
        },
      ),
    );
  }

  Widget _build(BuildContext context, _ViewModel vm) {
    return Scaffold(
      appBar: CustomAppBar(
        title: Text('我的收藏夹'),
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
    );
  }
}

class _ViewModel {
  final List<Favorite> items;
  final Future<Result<Favorite>> Function(int page) fetchItems;

  _ViewModel({
    this.items,
    this.fetchItems,
  });

  static _ViewModel fromStore(redux.Store<AppState> store) {
    final favoriteState = store.state.favoriteState;
    return _ViewModel(
      items: favoriteState.list ?? [],
      fetchItems: (page) {
        var action = new GetFavoriteListAction(
          page: page,
        );

        store.dispatch(action);

        return action.completer.future;
      }
    );
  }
}
