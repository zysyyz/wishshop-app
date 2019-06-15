import 'package:flutter/material.dart';
import 'package:redux/redux.dart' as redux;
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import '../../models/models.dart';
import '../../redux/redux.dart';
import '../../views/views.dart';
import '../../widgets/widgets.dart';

class TabProducts extends StatefulWidget {
  final Category category;

  const TabProducts({Key key, this.category}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _TabProductsState();
}

class _TabProductsState extends State<TabProducts> {
  Widget _build(BuildContext context, _ViewModel vm) {
    List<Product> items = vm.items;

    return PullToRefreshLayout(
      initialCount: items.length,
      onLoadData: (page) async {
        return await vm.fetchItems(page);
      },
      child: StaggeredGridView.countBuilder(
        padding: EdgeInsets.zero,
        crossAxisCount: 2,
        itemCount: items.length,
        itemBuilder: (BuildContext context, int index) {
          Product product = items[index];
          return ProductGridItem(
            product: product,
          );
        },
        staggeredTileBuilder: (index) {
          return StaggeredTile.fit(1);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      converter: (store) => _ViewModel.fromStore(store, categoryId: widget.category.id),
      builder: (BuildContext context, _ViewModel vm) {
        return _build(context, vm);
      },
    );
  }
}

class _ViewModel {
  final List<Product> items;
  final Future<Result<Product>> Function(int page) fetchItems;

  _ViewModel({
    this.items,
    this.fetchItems,
  });

  static _ViewModel fromStore(redux.Store<AppState> store, {
    categoryId: String,
  }) {
    final productState = store.state.productState;
    return _ViewModel(
      items: productState.listByFilter['categoryId=$categoryId'] ?? [],
      fetchItems: (page) {
        var action = new GetProductListAction(
          page: page,
          categoryId: categoryId,
        );

        store.dispatch(action);

        return action.completer.future;
      }
    );
  }
}
