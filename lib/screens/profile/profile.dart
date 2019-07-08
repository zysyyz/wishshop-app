import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:redux/redux.dart' as redux;
import 'package:flutter_redux/flutter_redux.dart';
import '../../exports.dart';
import './profile_edit_gender.dart';
import './profile_edit_name.dart';


String _toFriendlyGender(gender) {
  final _friendlyGenders = {
    'secrecy': '保密',
    'male'   : '男',
    'female' : '女',
  };
  return _friendlyGenders[gender];
}

class ProfileScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Widget _build(BuildContext context, _ViewModel vm) {
    String name;
    String username;
    String email;
    String gender = _toFriendlyGender('secrecy');

    if (vm.user != null) {
      name     = vm.user.name;
      username = vm.user.username;
      email    = vm.user.email;
      gender   = _toFriendlyGender(vm.user.gender);
    }
    List<Map<String, dynamic>> items = [
        {
          'type': 'section',
          'title': '个人资料'
        },
        {
          'key': 'avatar',
          'title': '头像',
          'detailTextView': CustomAvatar(vm.user.avatarUrl, size: 48),
          'accessoryType': 'none',
          // 'onTap': () {
          // },
          'contentPadding': EdgeInsets.fromLTRB(16,  8, 16, 8)
        },
        {
          'title': '姓名',
          'detailText': name,
          'onTap': () {
            Navigator
              .of(context)
              .push(MaterialPageRoute(builder: (_) => ProfileEditNameScreen()));
          },
        },
        {
          'title': '性别',
          'detailText': gender,
          'onTap': () {
            Navigator
              .of(context)
              .push(MaterialPageRoute(builder: (_) => ProfileEditGenderScreen()));
          },
        },
        {
          'type': 'section',
          'title': '账号安全'
        },
        {
          'title': '用户名',
          'detailText': username ?? '未设置',
          'accessoryType': 'none',
        },
        {
          'title': '邮箱',
          'detailText': email ?? '未设置',
          'accessoryType': 'none',
        },
        // {
        //   'title': '修改密码',
        //   'detailText': '',
        //   'onTap': () {
        //     Navigator
        //       .of(context)
        //       .push(MaterialPageRoute(builder: (_) => ChangePasswordScreen()));
        //   },
        // },
      ];

    return Scaffold(
      appBar: CustomAppBar(
        title: Text('个人信息'),
        backgroundColor: Colors.white,
        elevation: 0.0,
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

          var key = item['key'];
          var title = item['title'];

          if (item['type'] == 'section') {
            return ListSection(title);
          }

          var titleStyle = item['titleStyle'];
          var titleAlign = item['titleAlign'];
          var detailText = item['detailText'];
          var detailTextStyle = item['detailTextStyle'];
          var detailTextView = item['detailTextView'];
          var onTap = item['onTap'];
          var accessoryType = item['accessoryType'];
          var contentPadding = item['contentPadding'];

          return ListItem(
            title,
            titleAlign: titleAlign,
            titleStyle: titleStyle,
            detailText: detailText,
            detailTextStyle: detailTextStyle,
            detailTextView: detailTextView,
            onTap: onTap,
            accessoryType: accessoryType,
            contentPadding: contentPadding,
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

  _ViewModel({
    this.user,
  });

  static _ViewModel fromStore(redux.Store<AppState> store) {
    final auth = store.state.auth;
    return _ViewModel(
      user: auth.user,
    );
  }
}
