import 'package:flutter/material.dart';
import '../../exports.dart';

class ModifierOptionGridItem extends StatelessWidget {
  final Modifier modifier;
  final ModifierOption modifierOption;

  const ModifierOptionGridItem(this.modifier, this.modifierOption);

  @override
  Widget build(BuildContext context) {
    print(modifier.optionType);
    return Container(
      // height: 46,
      // alignment: Alignment.center,
      constraints: BoxConstraints(
        minWidth: 64,
        minHeight: 42,
        maxWidth: (MediaQuery.of(context).size.width)
      ),
      decoration: BoxDecoration(
        border: Border.fromBorderSide(
          BorderSide(
            color: Theme.of(context).dividerColor,
            width: 1.0,
          ),
        )
      ),
      child: Container(
        padding: EdgeInsets.only(left: 10, right: 10),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            modifier.optionType != 'color' || modifierOption.optionValue == null || modifierOption.optionValue.isEmpty ? Container() : Container(
              color: HexColor(modifierOption.optionValue),
              width: 24,
              height: 24,
              margin: EdgeInsets.only(right: 6),
            ),
            Text(
              modifierOption?.optionName ?? '',
              overflow: TextOverflow.ellipsis,
            )
          ],
        ),
      ),
    );
  }
}
