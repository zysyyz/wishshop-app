import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';
import 'package:launch_review/launch_review.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../exports.dart';

class AboutUsScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AboutUsScreenState();
}

class _AboutUsScreenState extends State<AboutUsScreen> {
  var _appVersion = 'Unknown';
  List<Map<String, dynamic>> _items = [];

  void _reloadData() async {
    final PackageInfo info = await PackageInfo.fromPlatform();

    String version = info.version;
    String buildNumber = info.buildNumber;

    setState(() {
      _appVersion = "v$version ($buildNumber)";
      _items = [
        {
          'key': 'appIcon',
          'type': 'section',
        },
        {
          'title': '去评分',
          'onTap': () {
            LaunchReview.launch(
              androidAppId: "me.thecode.wordtagapp",
              iOSAppId: "1448128907"
            );
          },
        },
        {
          'title': '功能介绍',
          'onTap': () async {
            const url = 'https://wishshop.org';
            if (await canLaunch(url)) {
              await launch(url);
            }
          },
        },
        // {
        //   'title': '检查更新',
        //   'onTap': () {
        //   },
        // },
      ];
    });
  }

  @override
  void initState() {
    super.initState();

    this._reloadData();
  }

  @override
  Widget build(BuildContext context) {
    final double additionalBottomPadding = math.max(MediaQuery.of(context).padding.bottom - 8.0, 0.0);

    return Scaffold(
      appBar: CustomAppBar(
        title: Text('关于我们'),
      ),
      body: ListView.separated(
        itemCount: _items.length,
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
        itemBuilder: (context, index) {
          var item = _items[index];

          var key = item['key'];
          var title = item['title'];

          if (key == 'appIcon') {
            return Container(
              margin: EdgeInsets.all(24),
              child: Column(
                children: <Widget>[
                  FlutterLogo(
                    size: 64,
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 12),
                    child: Text("wish", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 12),
                    child: Text(_appVersion),
                  ),
                ],
              ),
            );
          }

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
            detailText: detailText,
            onTap: onTap,
            accessoryType: accessoryType,
          );
        },
      ),
      bottomNavigationBar: Semantics(
        container: true,
        explicitChildNodes: true,
        child: Stack(
          children: <Widget>[
            Positioned.fill(
              child: Material( // Casts shadow.
                elevation: 0,
                color: Colors.transparent,
              ),
            ),
            ConstrainedBox(
              constraints: BoxConstraints(minHeight: kBottomNavigationBarHeight + additionalBottomPadding),
              child: Stack(
                children: <Widget>[
                  Material( // Splashes.
                    type: MaterialType.transparency,
                    child: Padding(
                      padding: EdgeInsets.only(bottom: additionalBottomPadding, left: 8, right: 8),
                      child: MediaQuery.removePadding(
                        context: context,
                        removeBottom: true,
                        child: SizedBox(
                          height: kBottomNavigationBarHeight,
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  '© 痕迹 2019',
                                  style: TextStyle(fontSize: 13),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
