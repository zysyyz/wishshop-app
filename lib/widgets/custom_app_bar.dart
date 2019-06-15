import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget leading;
  final bool automaticallyImplyLeading;
  final Widget title;
  final List<Widget> actions;
  final Widget flexibleSpace;
  final PreferredSizeWidget bottom;
  final double elevation;
  final Color backgroundColor;
  final Brightness brightness;
  final IconThemeData iconTheme;
  final TextTheme textTheme;
  final bool primary;
  final bool centerTitle;
  final double titleSpacing;
  final double toolbarOpacity;
  final double bottomOpacity;
  CustomAppBar({
    Key key,
    this.leading,
    this.automaticallyImplyLeading = true,
    this.title,
    this.actions,
    this.flexibleSpace,
    this.bottom,
    this.elevation = 0.0,
    this.backgroundColor = Colors.white,
    this.brightness,
    this.iconTheme,
    this.textTheme,
    this.primary = true,
    this.centerTitle,
    this.titleSpacing = NavigationToolbar.kMiddleSpacing,
    this.toolbarOpacity = 1.0,
    this.bottomOpacity = 1.0,
  }) : assert(automaticallyImplyLeading != null),
       assert(elevation != null && elevation >= 0.0),
       assert(primary != null),
       assert(titleSpacing != null),
       assert(toolbarOpacity != null),
       assert(bottomOpacity != null),
       preferredSize = Size.fromHeight(kToolbarHeight + (bottom?.preferredSize?.height ?? 0.0)),
       super(key: key);

  @override
  Widget build(BuildContext context) {
    final ScaffoldState scaffold = Scaffold.of(context, nullOk: true);
    final ModalRoute<dynamic> parentRoute = ModalRoute.of(context);

    final bool hasDrawer = scaffold?.hasDrawer ?? false;
    final bool canPop = parentRoute?.canPop ?? false;
    final bool useCloseButton = parentRoute is PageRoute<dynamic> && parentRoute.fullscreenDialog;

    Widget leading = this.leading;
    if (leading == null && this.automaticallyImplyLeading) {
      if (!hasDrawer && canPop) {
        var backButton = IconButton(
          icon: Icon(Icons.arrow_back_ios, size: 20,),
          onPressed: () {
            Navigator.maybePop(context);
          }
        );

        leading = useCloseButton ? null : backButton;
      }
    }

    Widget bottom = this.bottom;

    if (bottom == null) {
      bottom = PreferredSize(
        child: Divider(height: 0),
        preferredSize: Size.fromHeight(0),
      );
    }

    return AppBar(
      leading: leading,
      automaticallyImplyLeading: this.automaticallyImplyLeading,
      title: this.title,
      actions: this.actions,
      flexibleSpace: this.flexibleSpace,
      bottom: bottom,
      elevation: this.elevation,
      backgroundColor: this.backgroundColor,
      brightness: this.brightness,
      iconTheme: this.iconTheme,
      textTheme: this.textTheme,
      primary: this.primary,
      centerTitle: this.centerTitle,
      titleSpacing: this.titleSpacing,
      toolbarOpacity: this.toolbarOpacity,
      bottomOpacity: this.bottomOpacity,
    );
  }

  @override
  final preferredSize;
}
