import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart' as redux;
import '../../exports.dart';
import './picker_city.dart';

class AddressEditScreen extends StatefulWidget {
  final addressId;

  AddressEditScreen({this.addressId});

  @override
  State<StatefulWidget> createState() =>
      _AddressEditScreenState(this.addressId);
}

const double _kPickerSheetHeight = 216.0;
const double _kPickerItemHeight = 50.0;

class _AddressEditScreenState extends State<AddressEditScreen> {
  int _addressId;
  Address _address = Address();

  final _formKey = GlobalKey<FormState>();
  String _name = '';
  String _contact = '';
  String _region = '';
  bool _isDefault = false;
  List _pcaData = null;
  String _province = '';
  String _city = '';
  String _district = '';
  String _line1 = '';
  String _line2 = '';
  int _provinceIndex = 0;
  int _cityIndex = 0;
  int _districtIndex = 0;

  _AddressEditScreenState(this._addressId);

  @override
  void initState() {
    super.initState();
    Future<String> loadString = DefaultAssetBundle.of(context)
        .loadString('assets/datasets/pca-code.json');

    loadString.then((String value) {
      setState(() {
        _pcaData = json.decode(value) as List;
      });
    });
    if (_addressId != null) {
      // 是新增
      this.fetchData();
    }
  }

  fetchData() async {
    sharedApiClient.defaultStore.addresses.setAddressId(_addressId);
    Address address =
        await sharedApiClient.defaultStore.address(_addressId).get();
    updateLocalData(address);
  }

  void updateLocalData(Address address) {
    _nameEditingController.text = address.fullName;
    _contactEditingController.text = address.phoneNumber;
    _line1EditingController.text = address.line1;
    setState(() {
      _address = address;
      _name = address.fullName;
      _contact = address.phoneNumber;
      _province = address.province;
      _city = address.city;
      _district = address.district;
      _line1 = address.line1;
    });
  }

  saveAddress(_ViewModel vm) async {
    ProgressHUD.show(context, '正在保存...');
    Address address;
    if (_addressId == null) {
      address = await sharedApiClient.defaultStore.addresses.create(
        fullName: _nameEditingController.text,
        phoneNumber: _contactEditingController.text,
        province: _province,
        city: _city,
        district: _district,
        line1: _line1,
      );
      setState(() {
        _addressId = address.id;
      });
    } else {
      address = await sharedApiClient.defaultStore.address(_addressId).patch(
            fullName: _nameEditingController.text,
            phoneNumber: _contactEditingController.text,
            province: _province,
            city: _city,
            district: _district,
            line1: _line1,
          );
    }

    vm.updateAddress(address);
    ProgressHUD.showSuccess(context, '保存成功');
  }

  deleteAddress(_ViewModel vm) async {
    ProgressHUD.show(context, '正在删除...');
    bool deleted =
        await sharedApiClient.defaultStore.address(_addressId).delete();
    if (deleted) {
      vm.deleteAddress(_addressId);
      ProgressHUD.showSuccess(context, '删除成功');
      ProgressHUD.dismiss();
      Navigator.pop(context);
    } else {
      ProgressHUD.showError(context, '删除失败');
    }
  }

  alertDeleteAddressTips(_ViewModel vm) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: new Text("确定要删除？"),
          actions: <Widget>[
            new CupertinoDialogAction(
              child: new Text("取消"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            new CupertinoDialogAction(
              child: new Text("确定"),
              onPressed: () {
                Navigator.of(context).pop();
                this.deleteAddress(vm);
              },
            ),
          ],
        );
      },
    );
  }

  final _nameEditingController = TextEditingController();
  final _contactEditingController = TextEditingController();
  final _line1EditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final nameRow = SizedBox(
      height: 60,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Container(
              child: Text(
                '收货人',
                style: Theme.of(context).textTheme.body2,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: TextFormField(
              controller: _nameEditingController,
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                  hintText: '请输入',
                  border: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  enabledBorder: InputBorder.none),
              onSaved: (value) {
                setState(() {
                  _name = value;
                });
              },
            ),
          ),
        ],
      ),
    );
    final contactRow = SizedBox(
      height: 60,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Container(
              child: Text(
                '联系方式',
                style: Theme.of(context).textTheme.body2,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: TextFormField(
              controller: _contactEditingController,
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                  hintText: '请输入',
                  border: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  enabledBorder: InputBorder.none),
              onSaved: (value) {
                setState(() {
                  _contact = value;
                });
              },
            ),
          ),
        ],
      ),
    );

    final currentRegion = _province + ' ' + _city + ' ' + _district;
    final regionRow = SizedBox(
      height: 60,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Container(
              child: Text(
                '收货地区',
                style: Theme.of(context).textTheme.body2,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: RaisedButton(
              padding: EdgeInsets.only(left: 0),
              elevation: 0,
              highlightElevation: 0,
              onPressed: () async {
                var data = await showCupertinoModalPopup(
                    context: context,
                    builder: (BuildContext context) {
                      return CityPicker(this._pcaData);
                    });
                if (data != null) {
                  setState(() {
                    _province = _pcaData[data['provinceIndex']]['name'];
                    _city = _pcaData[data['provinceIndex']]['children']
                        [data['cityIndex']]['name'];
                    _district = _pcaData[data['provinceIndex']]['children']
                            [data['cityIndex']]['children']
                        [data['districtIndex']]['name'];
                  });
                }
              },
              color: Colors.white,
              child: Row(
                children: <Widget>[
                  Flexible(
                    fit: FlexFit.tight,
                    child: Text(
                      (currentRegion.trim().isEmpty ? '请选择' : currentRegion),
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          color: currentRegion.trim().isEmpty
                              ? Colors.black54
                              : Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.normal),
                    ),
                  ),
                  Icon(Icons.keyboard_arrow_right),
                ],
              ),
            ),
          ),
        ],
      ),
    );
    final addressRow = SizedBox(
      height: 60,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Container(
              child: Text(
                '详细地址',
                style: Theme.of(context).textTheme.body2,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: TextFormField(
              controller: _line1EditingController,
              textInputAction: TextInputAction.done,
              decoration: InputDecoration(
                  hintText: '请输入',
                  border: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  enabledBorder: InputBorder.none),
              onSaved: (value) {
                setState(() {
                  _name = value;
                });
              },
            ),
          ),
        ],
      ),
    );

    return StoreConnector<AppState, _ViewModel>(
        converter: _ViewModel.fromStore,
        onInit: (store) async {},
        builder: (BuildContext context, _ViewModel vm) {
          return Scaffold(
            appBar: DefaultAppBar(
              title: Text('编辑收货地址'),
              actions: <Widget>[
                _addressId == null
                    ? Center()
                    : GestureDetector(
                        onTap: () {
                          this.alertDeleteAddressTips(vm);
                        },
                        child: Container(
                          padding: EdgeInsets.only(left: 16, right: 16),
                          margin: EdgeInsets.all(0),
                          child: Center(
                            child: Text('删除'),
                          ),
                        ),
                      ),
              ],
            ),
            body: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: 10),
                    padding: EdgeInsets.only(left: 16, right: 16),
                    color: Colors.white,
                    child: Column(
                      children: <Widget>[
                        nameRow,
                        Divider(
                          height: 1,
                        ),
                        contactRow,
                        Divider(
                          height: 1,
                        ),
                        regionRow,
                        Divider(
                          height: 1,
                        ),
                        addressRow,
                      ],
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      Checkbox(
                        value: _isDefault,
                        onChanged: (value) {
                          setState(() {
                            _isDefault = value;
                          });
                        },
                      ),
                      Text(
                        '设为默认地址',
                        style: Theme.of(context).textTheme.body2,
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.all(16),
                    child: RaisedButton(
                      elevation: 0,
                      highlightElevation: 0,
                      onPressed: () {
                        this.saveAddress(vm);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            '保存地址',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }
}

class _ViewModel {
  final Function updateAddress;
  final Function deleteAddress;

  _ViewModel({
    this.updateAddress,
    this.deleteAddress,
  });

  static _ViewModel fromStore(redux.Store<AppState> store) {
    return _ViewModel(
      updateAddress: (Address address) {
        store.dispatch(UpdateAddressSuccessAction(address));
      },
      deleteAddress: (addressId) {
        store.dispatch(DeleteAddressSuccessAction(addressId));
      },
    );
  }
}
