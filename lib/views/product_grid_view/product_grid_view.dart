import 'package:flutter/material.dart';
import 'package:redux/redux.dart' as redux;
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import '../../models/models.dart';
import '../../redux/redux.dart';
import '../../views/views.dart';
import '../../widgets/widgets.dart';

class ProductGridView extends StatefulWidget {
  final Category category;

  const ProductGridView({Key key, this.category}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ProductGridViewState();
}

class _ProductGridViewState extends State<ProductGridView> {
  bool _loading = true;

  Widget _build(BuildContext context, _ViewModel vm) {
    Category category = this.widget.category;

    List<Product> products = vm.listByFilter['categoryId=${category.id}'] ?? [];

    if (_loading) {
      return ListLoadIndicator();
    }

    if (products.length == 0) {
      return ListEmptyIndicator();
    }

    return Container(
      height: MediaQuery.of(context).size.height,
      child: new StaggeredGridView.countBuilder(
        padding: EdgeInsets.only(top: 6, bottom: MediaQuery.of(context).padding.bottom),
        crossAxisCount: 2,
        itemCount: products.length,
        itemBuilder: (BuildContext context, int index) {
          Product product = products[index];

          return ProductGridItem(
            product: product,
          );
        },
        staggeredTileBuilder: (index) {
          return new StaggeredTile.fit(1);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Category category = this.widget.category;
    return StoreConnector<AppState, _ViewModel>(
      converter: _ViewModel.fromStore,
      builder: (BuildContext context, _ViewModel vm) {
        return _build(context, vm);
      },
      onInit: (store) async {
        var action = new GetProductListAction(categoryId: category.id);
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
