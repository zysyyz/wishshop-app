import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:redux/redux.dart' as redux;
import 'package:flutter_redux/flutter_redux.dart';
import '../../exports.dart';

class TabHomepage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _TabHomepageState();
}

class _TabHomepageState extends State<TabHomepage> {
  Widget _buildBody(BuildContext context, _ViewModel vm) {
    List<Collection> collections = vm.listByFilter['all'] ?? [];

    if (collections.length == 0) {
      return ListEmptyIndicator();
    }

    return Container(
      height: MediaQuery.of(context).size.height,
      child: new ListView.builder(
        padding: EdgeInsets.only(
          top: 0,
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        itemCount: collections.length,
        itemBuilder: (BuildContext context, int index) {
          Collection collection = collections[index];
          return CollectionListItem(collection);
        },
      ),
    );
  }

  Widget _build(BuildContext context, _ViewModel vm) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: DefaultAppBar(
        title: Image.asset('assets/images/ic_logo.png', height: 12),
        actions: <Widget>[
          IconButton(
            icon: Image.asset('assets/images/ic_menu_search.png'),
            onPressed: () {
              Navigator
              .of(context)
              .push(MaterialPageRoute(builder: (_) => SearchScreen()));
            },
          )
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
      onInit: (store) {
        store.dispatch(new GetCollectionListAction());
      },
    );
  }
}

class _ViewModel {
  final Map<String, List<Collection>> listByFilter;

  _ViewModel({
    this.listByFilter,
  });

  static _ViewModel fromStore(redux.Store<AppState> store) {
    final collectionState = store.state.collection;
    return _ViewModel(
      listByFilter: collectionState.listByFilter,
    );
  }
}
