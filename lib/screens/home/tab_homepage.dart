import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:redux/redux.dart' as redux;
import 'package:flutter_redux/flutter_redux.dart';
import '../../exports.dart';

class TabHomepageScene extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _TabHomepageSceneState();
}

class _TabHomepageSceneState extends State<TabHomepageScene> {
  Widget _buildBody(BuildContext context, _ViewModel vm) {
    List<Collection> items = vm.items;

    return PullToRefreshLayout(
      initialCount: items.length,
      onLoadData: vm.fetchItems,
      child: ListView.builder(
        padding: EdgeInsets.only(
          top: 0,
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        itemCount: items.length,
        itemBuilder: (BuildContext context, int index) {
          Collection collection = items[index];
          return CollectionListItem(collection);
        },
      ),
    );
  }

  Widget _build(BuildContext context, _ViewModel vm) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        title: Image.asset('assets/images/ic_logo.png', height: 12),
        leading: IconButton(
          icon: Image.asset('assets/images/ic_menu_scan.png'),
          onPressed: () {
            // Navigator
            //   .of(context)
            //   .push(MaterialPageRoute(builder: (_) => SearchScreen()));
          },
        ),
        actions: <Widget>[

        ],
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
  final List<Collection> items;
  final Future<Result<Collection>> Function(int page) fetchItems;

  _ViewModel({
    this.items,
    this.fetchItems,
  });

  static _ViewModel fromStore(redux.Store<AppState> store) {
    final collectionState = store.state.collectionState;
    return _ViewModel(
      items: collectionState.listByFilter['all'] ?? [],
      fetchItems: (page) {
        var action = new GetCollectionListAction(
          page: page,
        );

        store.dispatch(action);

        return action.completer.future;
      }
    );
  }
}
