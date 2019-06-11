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
  bool _loading = true;

  Widget _buildBody(BuildContext context, _ViewModel vm) {
    List<Product> products = vm.listByFilter['categoryId=2'] ?? [];

    if (_loading) {
      return ListLoadIndicator();
    }

    if (products.length == 0) {
      return ListEmptyIndicator();
    }

    return Container(
      height: MediaQuery.of(context).size.height,
      child: new StaggeredGridView.countBuilder(
        padding: EdgeInsets.zero,
        crossAxisCount: 2,
        itemCount: products.length,
        itemBuilder: (BuildContext context, int index) {
          Product product = products[index];

          return ProductListItem(
            product: product,
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
      appBar: DefaultAppBar(
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
      onInit: (store) async {
        var action = new GetProductListAction(categoryId: 2);
        action.completer.future.then((_){
          setState(() {
            _loading = false;
          });
        });

        store.dispatch(action);
      },
    );
  }
}

class _ViewModel {
  final Map<String, List<Product>> listByFilter;

  _ViewModel({
    this.listByFilter,
  });

  static _ViewModel fromStore(redux.Store<AppState> store) {
    final productState = store.state.productState;
    return _ViewModel(
      listByFilter:productState.listByFilter,
    );
  }
}
