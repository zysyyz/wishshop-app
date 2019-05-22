import 'package:flutter/material.dart';
import 'package:feather_icons_flutter/feather_icons_flutter.dart';

class ListItem extends StatelessWidget {
  final String title;
  TextAlign titleAlign;
  TextStyle titleStyle;
  String subtitle;
  TextStyle subtitleStyle;
  String detailText;
  TextStyle detailTextStyle;
  Widget detailTextView;
  GestureTapCallback onTap;
  String accessoryType = "disclosureIndicator";
  EdgeInsetsGeometry contentPadding;

  TextStyle _defaultTitleStyle = TextStyle(fontSize: 15, color: Color(0xff000000), fontWeight: FontWeight.w600);
  TextStyle _defaultSubtitleStyle = TextStyle();
  TextStyle _defaultDetailTextStyle = TextStyle(fontSize: 14, color: Color(0xff999999));

  ListItem(this.title, {
    this.titleAlign,
    this.titleStyle,
    this.subtitle,
    this.subtitleStyle,
    this.detailText,
    this.detailTextStyle,
    this.detailTextView,
    this.onTap,
    this.accessoryType,
    this.contentPadding,
  });

  @override
  Widget build(BuildContext context) {
    var hasTrailing = detailTextView != null || detailText != null || accessoryType != 'none';

    return Material(
      color: Colors.white,
      child: ListTile(
        title: Text(
          title,
          style: titleStyle != null ? titleStyle : _defaultTitleStyle,
          textAlign: titleAlign,
        ),
        subtitle: subtitle == null ? null : Text(
          subtitle,
          style: subtitleStyle != null ? subtitleStyle : _defaultSubtitleStyle,
        ),
        trailing: !hasTrailing ? null : Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          children: <Widget>[
            detailText == null ? (detailTextView ?? SizedBox()) : Text(
              detailText,
              style: detailTextStyle != null ? detailTextStyle : _defaultDetailTextStyle,
            ),
            accessoryType == 'none' ? SizedBox() : Icon(FeatherIcons.chevronRight, size: 18),
          ],
        ),
        isThreeLine: false,
        onTap: onTap,
        contentPadding: contentPadding,
      ),
    );
  }
}