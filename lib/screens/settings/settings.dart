import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:redux/redux.dart' as redux;
import 'package:flutter_redux/flutter_redux.dart';
import '../../exports.dart';

class SettingsScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  var _appVersion = 'Unknown';

  void _reloadData() async {
    final PackageInfo info = await PackageInfo.fromPlatform();

    String version = info.version;
    String buildNumber = info.buildNumber;

    setState(() {
      _appVersion = "v$version ($buildNumber)";
    });
  }

  @override
  void initState() {
    super.initState();

    this._reloadData();
  }

  Widget _build(BuildContext context, _ViewModel vm) {
    List<Map<String, dynamic>> _items = [
        {
          'type': 'section',
          'title': '其他',
        },
        {
          'title': '用户反馈',
          'onTap': () async {
            String subject = "WishShop Feedback - $_appVersion".replaceAll(" ", "%20");
            String urlString = 'mailto:wishshop@thecode.me?subject=$subject';
            if (await canLaunch(urlString)) {
              await launch(urlString);
            } else {
              throw 'Could not launch $urlString';
            }
          },
        },
        {
          'title': '关于我们',
          'onTap': () {
            Navigator
              .of(context)
              .push(MaterialPageRoute(builder: (_) => AboutUsScreen()));
          },
        },
      ];

    return Scaffold(
      appBar: CustomAppBar(
        title: Text('设置'),
        backgroundColor: Colors.white,
        elevation: 0.0,
      ),
      body: ListView.separated(
        separatorBuilder: (context, index) {
          if (_items[index]['type'] == 'section' || (index < _items.length && _items[index + 1]['type'] == 'section')) {
            return Padding(padding: EdgeInsets.all(0));
          }
          return Container(
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: Divider(indent: 16, height: 1));
        },
        itemCount: _items.length,
        itemBuilder: (context, index) {
          var item = _items[index];

          var key = item['key'];
          var title = item['title'];

          if (item['type'] == 'section') {
            return ListSection(title);
          }

          var titleStyle = item['titleStyle'];
          var detailText = item['detailText'];
          var onTap = item['onTap'];
          var accessoryType = item['accessoryType'];

          return ListItem(
            title,
            titleStyle: titleStyle,
            titleAlign: key == 'logout' ? TextAlign.center : null,
            detailText: detailText,
            onTap: onTap,
            accessoryType: accessoryType,
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

    _ViewModel vm = _ViewModel(
      user: auth.user,
    );
    return vm;
  }
}
