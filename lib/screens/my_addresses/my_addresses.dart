import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:redux/redux.dart' as redux;
import 'package:flutter_redux/flutter_redux.dart';
import 'package:wishshop_app/redux/actions/address_actions.dart';
import '../../redux/redux.dart';
import '../../models/models.dart';
import '../../screens/screens.dart';
import '../../views/views.dart';
import '../../widgets/widgets.dart';
import '../../models/models.dart';
import 'package:wishshop_app/networking/api_client/api_client.dart';
import 'package:wishshop_app/networking/networking.dart';
import '../../networking/api_client/_addresses.dart';
import '../../widgets/widgets.dart';
import '../screens.dart';

class MyAddressesScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MyAddressesScreenState();
}

class _MyAddressesScreenState extends State<MyAddressesScreen> {
  List<Address> _addresses = [];
  bool _loading;

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
        converter: _ViewModel.fromStore,
        onInit: (store) async {
          var action = new GetAddressListAction();
          action.completer.future.then((_) {
            setState(() {
              _loading = false;
            });
          });

          store.dispatch(action);
        },
        builder: (BuildContext context, _ViewModel vm) {
          _addresses = vm.addresses;
          return Scaffold(
                  appBar: DefaultAppBar(
                    title: Text('我的地址簿'),
                  ),
                  body: SafeArea(
                    child: _addresses == null
                        ? Center()
                        : Column(
                      children: <Widget>[
                        Flexible(
                          flex: 1,
                          child: ListView(
                            children: List<Widget>.generate(_addresses.length,
                                (int index) {
                              return Container(
                                margin: EdgeInsets.only(top: 10),
                                child: RaisedButton(
                                  onPressed: () {
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                            builder: (_) => AddressEditScreen(
                                                  addressId:
                                                      _addresses[index].id,
                                                )));
                                  },
                                  padding: EdgeInsets.all(16),
                                  color: Colors.white,
                                  elevation: 0,
                                  highlightElevation: 0,
                                  child: Column(
                                    children: <Widget>[
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Text(_addresses[index].fullName ?? '',
                                              style: TextStyle(fontSize: 16)),
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
                                            Text(
                                                _addresses[index].phoneNumber ??
                                                    ''),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(top: 10),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: <Widget>[
                                            Container(
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
                                            Container(
                                              margin: EdgeInsets.only(
                                                  left: _addresses[index]
                                                          .province
                                                          .isEmpty
                                                      ? 4
                                                      : 0),
                                              child: Text(
                                                  _addresses[index].province ??
                                                      '',
                                                  overflow:
                                                      TextOverflow.ellipsis),
                                            ),
                                            Container(
                                              margin: EdgeInsets.only(
                                                  left: _addresses[index]
                                                          .province
                                                          .isEmpty
                                                      ? 4
                                                      : 0),
                                              child: Text(
                                                  _addresses[index].city ?? '',
                                                  overflow:
                                                      TextOverflow.ellipsis),
                                            ),
                                            Container(
                                              margin: EdgeInsets.only(
                                                  left: _addresses[index]
                                                          .province
                                                          .isEmpty
                                                      ? 4
                                                      : 0),
                                              child: Text(
                                                  _addresses[index].district ??
                                                      '',
                                                  overflow:
                                                      TextOverflow.ellipsis),
                                            ),
                                            Container(
                                              margin: EdgeInsets.only(
                                                  left: _addresses[index]
                                                          .province
                                                          .isEmpty
                                                      ? 4
                                                      : 0),
                                              child: Text(
                                                  _addresses[index].line1 ?? '',
                                                  overflow:
                                                      TextOverflow.ellipsis),
                                            ),
                                            Container(
                                              margin: EdgeInsets.only(
                                                  left: _addresses[index]
                                                          .province
                                                          .isEmpty
                                                      ? 4
                                                      : 0),
                                              child: Text(
                                                  _addresses[index].line2 ?? '',
                                                  overflow:
                                                      TextOverflow.ellipsis),
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
                        ),
                        Container(
                          margin: EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              RaisedButton(
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
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                );
        });
  }

  @override
  void initState() {
    super.initState();
//    sharedApiClient.addresses.setStoreId();
//    fetchData();
  }

//  fetchData() async {
//    List<Address> addresses =
//        await sharedApiClient.defaultStore.addresses.list();
//    setState(() {
//      _addresses = addresses;
//    });
//  }
}

class _ViewModel {
  final List<Address> addresses;

  _ViewModel({
    this.addresses,
  });

  static _ViewModel fromStore(redux.Store<AppState> store) {
    final addressState = store.state.address;
    return _ViewModel(
      addresses: addressState.addresses, // addressState.addresses
    );
  }
}
