import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../exports.dart';

class AboutUsScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AboutUsScreenState();
}

class _AboutUsScreenState extends State<AboutUsScreen> {
  var _appVersion = 'Unknown';

  @override
  void initState() {
    super.initState();

    this._initPlatformState();
  }

  void _initPlatformState() async {
    final PackageInfo info = await PackageInfo.fromPlatform();

    String version = info.version;
    String buildNumber = info.buildNumber;

    setState(() {
      _appVersion = "v$version ($buildNumber)";
    });
  }

  Widget _buildListHeader(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(24),
      child: Column(
        children: <Widget>[
          FlutterLogo(
            size: 64,
          ),
          Padding(
            padding: EdgeInsets.only(top: 12),
            child: Text("wish", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),),
          ),
          Padding(
            padding: EdgeInsets.only(top: 12),
            child: Text(_appVersion),
          ),
        ],
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    List<Map<String, dynamic>> items = [
        {
          'type': 'header',
        },
        {
          'title': '获取源码',
          'onTap': () async {
            const url = 'https://github.com/wishshop/wishshop_app';
            if (await canLaunch(url)) {
              await launch(url);
            }
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
      ];
    return ListView.separated(
      itemCount: items.length,
      separatorBuilder: (context, index) {
        if (items[index]['type'] == 'section' ||
          (index < items.length && items[index + 1]['type'] == 'section')) {
          return Container();
        }
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          child: Divider(indent: 16, height: 1));
      },
      itemBuilder: (context, index) {
        var item = items[index];

        switch (item['type']) {
          case 'header':
            return _buildListHeader(context);
          case 'section':
            return ListSection(
              item['title'],
            );
          default:
            return ListItem(
              item['title'],
              onTap: item['onTap'],
            );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final double additionalBottomPadding = math.max(MediaQuery.of(context).padding.bottom - 8.0, 0.0);

    return Scaffold(
      appBar: CustomAppBar(
        title: Text('关于我们'),
      ),
      body: _buildBody(context),
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
