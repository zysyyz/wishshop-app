import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CupertinoCityPicker extends StatefulWidget {
  List _pcaData;

  @override
  State<StatefulWidget> createState() => _CupertinoCityPicker(this._pcaData);

  CupertinoCityPicker(this._pcaData);
}

const double _kPickerSheetHeight = 288;
const double _kPickerItemHeight = 50.0;

class _CupertinoCityPicker extends State<CupertinoCityPicker> {
  final _pcaData;
  String _province = '';
  String _city = '';
  String _district = '';
  int _provinceIndex = 0;
  int _cityIndex = 0;
  int _districtIndex = 0;

  _CupertinoCityPicker(this._pcaData);

  Widget _buildBottomPicker(Widget picker) {
    return Container(
      height: _kPickerSheetHeight,
      color: CupertinoColors.white,
      child: DefaultTextStyle(
        style: const TextStyle(
          color: CupertinoColors.black,
          fontSize: 16.0,
        ),
        child: GestureDetector(
          // Blocks taps from propagating to the modal sheet and popping.
          onTap: () {},
          child: SafeArea(
            top: false,
            child: Column(
              children: <Widget>[
                Container(
                  color: Colors.white,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      RaisedButton(
                        color: Colors.white,
                        highlightElevation: 0,
                        padding: EdgeInsets.all(0),
                        elevation: 0,
                        onPressed: () {

                        },
                        child: Text('取消'),
                      ),
                      RaisedButton(
                        color: Colors.white,
                        highlightElevation: 0,
                        padding: EdgeInsets.all(0),
                        elevation: 0,
                        onPressed: () {
                          Navigator.of(context).pop({
                            'provinceIndex': _provinceIndex,
                            'cityIndex': _cityIndex,
                            'districtIndex': _districtIndex,
                          });
                        },
                        child: Text('完成', style: TextStyle(color: Colors.lightGreen),),
                      ),
                    ],
                  ),
                ),
                Flexible(
                  flex: 1,
                  child: picker,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return _buildBottomPicker(Row(
      children: <Widget>[
        Expanded(
          flex: 1,
          child: CupertinoPicker(
            itemExtent: _kPickerItemHeight,
            backgroundColor: CupertinoColors.white,
            onSelectedItemChanged: (int index) {
              setState(() => _provinceIndex = index);
            },
            children: List<Widget>.generate(_pcaData.length, (int index) {
              return Center(
                child: Text(_pcaData[index]['name'],
                    style: TextStyle(fontSize: 16)),
              );
            }),
          ),
        ),
        Expanded(
          flex: 1,
          child: CupertinoPicker(
            itemExtent: _kPickerItemHeight,
            backgroundColor: CupertinoColors.white,
            onSelectedItemChanged: (int index) {
              setState(() => _cityIndex = index);
            },
            children: List<Widget>.generate(
                _pcaData[_provinceIndex]['children'].length, (int index) {
              return Center(
                child: Text(
                  _pcaData[_provinceIndex]['children'][index]['name'],
                  style: TextStyle(fontSize: 16),
                ),
              );
            }),
          ),
        ),
        Expanded(
          flex: 1,
          child: CupertinoPicker(
            itemExtent: _kPickerItemHeight,
            backgroundColor: CupertinoColors.white,
            onSelectedItemChanged: (int index) {
              setState(() => _districtIndex = index);
            },
            children: List<Widget>.generate(
                _pcaData[_provinceIndex]['children'][_cityIndex]['children'].length,
                (int index) {
              return Center(
                child: Text(
                    _pcaData[_provinceIndex]['children'][_cityIndex]['children']
                        [index]['name'],
                    style: TextStyle(fontSize: 16)),
              );
            }),
          ),
        ),
      ],
    ));
  }
}
