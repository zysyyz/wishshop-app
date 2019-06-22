import 'package:flutter/material.dart';
import 'package:redux/redux.dart' as redux;
import 'package:flutter_redux/flutter_redux.dart';
import '../../exports.dart';

class ProfileEditGenderScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ProfileEditGenderScreenState();
}

class _ProfileEditGenderScreenState extends State<ProfileEditGenderScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  String _newGender;

  Widget _build(BuildContext context, _ViewModel vm) {
    if (_newGender == null) {
      _newGender = vm.user.gender;
    }
    ThemeData theme = Theme.of(context);
    List items = [
      {
        'type': 'section',
      },
      {
        'key': "secrecy",
        'title': '保密',
      },
      {
        'key':  "male",
        'title': '男',
      },
      {
        'key':  "female",
        'title': '女',
      },
    ];

    return Scaffold(
      key: _scaffoldKey,
      appBar: CustomAppBar(
        title: Text('修改性别'),
        actions: <Widget>[
          IconButton(
            icon: Text("确定"),
            onPressed: () async {
              try {
                SVProgressHUD.show('正在保存...');
                await vm.doUpdateGender(_newGender);
                Navigator.of(context).pop();
              } catch (e) {
                _scaffoldKey.currentState.hideCurrentSnackBar();
                final snackBar = SnackBar(content: Text(e.message));
                _scaffoldKey.currentState.showSnackBar(snackBar);
              } finally {
                SVProgressHUD.dismissWithDelay(1500);
              }
            },
          ),
        ],
      ),
      body: ListView.separated(
        separatorBuilder: (context, index) {
          if (items[index]['type'] == 'section' || (index < items.length && items[index + 1]['type'] == 'section')) {
            return Padding(padding: EdgeInsets.all(0));
          }
          return Container(
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: Divider(indent: 16, height: 1));
        },
        itemCount: items.length,
        itemBuilder: (context, index) {
          var item = items[index];

          var title = item['title'];

          if (item['type'] == 'section') {
            return ListSection(title);
          }

          var key         = item['key'];
          var titleStyle  = item['titleStyle'];
          var subtitle    = item['subtitle'];

          return ListItem(
            title,
            titleStyle: titleStyle,
            subtitle: subtitle,
            onTap: () {
              setState(() {
                _newGender = key;
              });
            },
            detailTextView: key != _newGender ? null : Icon(
              Icons.check,
              size: 18,
              color: theme.primaryColor,
            ),
            accessoryType: 'none',
          );
        },
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
  final User user;
  final Function doUpdateGender;

  _ViewModel({
    this.user,
    this.doUpdateGender
  });

  static _ViewModel fromStore(redux.Store<AppState> store) {
    final auth = store.state.auth;
    return _ViewModel(
      user: auth.user,
      doUpdateGender: (String gender) {
        // UpdateProfileAction action = new UpdateProfileAction(
        //   gender: gender,
        // );
        // store.dispatch(action);
        // return action.completer.future;
      }
    );
  }
}
