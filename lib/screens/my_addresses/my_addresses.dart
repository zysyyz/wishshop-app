import 'package:flutter/material.dart';
import 'package:redux/redux.dart' as redux;
import 'package:flutter_redux/flutter_redux.dart';
import 'package:wishshop_app/redux/actions/address_actions.dart';
import '../../exports.dart';

class MyAddressesScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MyAddressesScreenState();
}

class _MyAddressesScreenState extends State<MyAddressesScreen> {
  Widget _buildBody(BuildContext context, _ViewModel vm) {
    List<Address> _items = vm.items;
    return PullToRefreshLayout(
      initialCount: _items.length,
      onLoadData: (page) async {
        return await vm.fetchItems(page);
      },
      child: ListView(
        children: List<Widget>.generate(
          _items.length,
          (int index) {

          Address address = _items[index];
          return Container(
            margin: EdgeInsets.only(top: 10),
            child: RaisedButton(
              onPressed: () {
                Navigator
                  .of(context)
                  .push(MaterialPageRoute(builder: (_) => AddressEditScreen(addressId: address.id)));
              },
              padding: EdgeInsets.all(16),
              color: Colors.white,
              elevation: 0,
              highlightElevation: 0,
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        address.fullName ?? '',
                        style: TextStyle(fontSize: 16)
                      ),
                      Icon(
                        Icons.mode_edit,
                        size: 16,
                      ),
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 4),
                    child: Row(
                      children: <Widget>[
                        Text(address.phoneNumber ?? ''),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 10),
                    child: Row(
                      crossAxisAlignment:
                          CrossAxisAlignment.center,
                      children: <Widget>[
                        !address.asDefault ? Container() : Container(
                          color: Theme.of(context)
                              .primaryColor,
                          padding: EdgeInsets.only(
                              left: 4, right: 4),
                          child: Text(
                            '默认',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 10),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(
                            margin: EdgeInsets.only(left: 4),
                            child: Text(
                              address.province
                                + ' ' + address.city
                                + ' ' + address.district
                                + ' ' + address.line1
                                + ' ' + address.line2,
                              overflow:
                              TextOverflow.ellipsis),
                            ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget _build(BuildContext context, _ViewModel vm) {
    return Scaffold(
      appBar: DefaultAppBar(
        title: Text('我的地址簿'),
      ),
      body: _buildBody(context, vm),
      bottomNavigationBar: Container(
        margin: EdgeInsets.all(16),
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom),
        child: RaisedButton(
          elevation: 0,
          highlightElevation: 0,
          child: Text(
            '添加新收货地址',
            style: TextStyle(color: Colors.white),
          ),
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (_) => AddressEditScreen()));
          },
        ),
      ),
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
  final List<Address> items;
  final Future<Result<Address>> Function(int page) fetchItems;

  _ViewModel({
    this.items,
    this.fetchItems,
  });

  static _ViewModel fromStore(redux.Store<AppState> store) {
    final addressState = store.state.address;
    return _ViewModel(
      items: addressState.list ?? [],
      fetchItems: (page) {
        var action = new GetAddressListAction(
          page: page,
        );

        store.dispatch(action);

        return action.completer.future;
      }
    );
  }
}
