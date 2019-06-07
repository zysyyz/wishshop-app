import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import './CupertinoCityPicker.dart';
import '../../widgets/widgets.dart';

class AddressesScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AddressesScreen();
}

const double _kPickerSheetHeight = 216.0;
const double _kPickerItemHeight = 50.0;

class _AddressesScreen extends State<AddressesScreen> {
  final _formKey = GlobalKey<FormState>();
  String _name = '';
  String _contact = '';
  String _region = '';
  String _address = '';
  bool _isDefault = false;
  List _pcaData = null;
  String _province = '';
  String _city = '';
  String _district = '';
  int _provinceIndex = 0;
  int _cityIndex = 0;
  int _districtIndex = 0;

  @override
  void initState() {
    super.initState();
    Future<String> loadString = DefaultAssetBundle.of(context)
        .loadString("assets/database/pca-code.json");

    loadString.then((String value) {
      // 通知框架此对象的内部状态已更改
      setState(() {
        // 将参数赋予存储点击数的变量
        _pcaData = json.decode(value) as List;
      });
    });
  }

  Widget _buildBottomPicker(Widget picker) {
    return Container(
      height: _kPickerSheetHeight,
      padding: const EdgeInsets.only(top: 6.0),
      color: CupertinoColors.white,
      child: DefaultTextStyle(
        style: const TextStyle(
          color: CupertinoColors.black,
          fontSize: 22.0,
        ),
        child: GestureDetector(
          // Blocks taps from propagating to the modal sheet and popping.
          onTap: () {},
          child: SafeArea(
            top: false,
            child: picker,
          ),
        ),
      ),
    );
  }

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
                      return CupertinoCityPicker(this._pcaData);
                    });
                if (data != null) {
                  setState(() {
                    _province = _pcaData[data['provinceIndex']]['name'];
                    _city = _pcaData[data['provinceIndex']]['children'][data['cityIndex']]['name'];
                    _district = _pcaData[data['provinceIndex']]['children'][data['cityIndex']]['children'][data['districtIndex']]['name'];
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
                          color: currentRegion.trim().isEmpty ? Colors.black54 : Colors.black,
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

    return Scaffold(
      appBar: DefaultAppBar(
        title: Text('编辑收货地址'),
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
            )
          ],
        ),
      ),
    );
  }
}
