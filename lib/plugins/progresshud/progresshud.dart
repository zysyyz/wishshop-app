import 'dart:async';
import 'package:flutter/material.dart';

enum ProgressHUDType {
  NORMAL, INFO, SUCCESS, ERROR, PROGRESS
}

class ProgressHUD extends PopupRoute {
  static ProgressHUD _hud;

  static void _show(BuildContext context, ProgressHUDType type, String message) {
    dismiss();
    try {
      if (_hud != null) {
        _hud.navigator.pop();
      }
      ProgressHUD hud = ProgressHUD();
      hud.type = type;
      hud.message = message;
      _hud = hud;
      Navigator.push(context, hud);
      if (type != ProgressHUDType.NORMAL || type != ProgressHUDType.PROGRESS) {
        Future.delayed(hud.delayed).then((val) {
          dismiss();
        });
      }
    } catch (e) {
      _hud = null;
    }
  }

  static void show(BuildContext context, String message) {
    _show(context, ProgressHUDType.NORMAL, message);
  }

  static void showInfo(BuildContext context, String message) {
    _show(context, ProgressHUDType.INFO, message);
  }

  static void showSuccess(BuildContext context, String message) {
    _show(context, ProgressHUDType.SUCCESS, message);
  }

  static void showError(BuildContext context, String message) {
    _show(context, ProgressHUDType.ERROR, message);
  }

  static void showProgress(BuildContext context, double progress, String message) {
    _show(context, ProgressHUDType.PROGRESS, message);
  }

  static Future<void> dismiss() async {
    try {
      _hud.navigator.pop();
      _hud = null;
    } catch (e) {
      _hud = null;
    }
  }

  ProgressHUDType type = ProgressHUDType.NORMAL;
  String message;
  Duration delayed = Duration(milliseconds: 1500);

  @override
  Color get barrierColor => null;

  @override
  String get barrierLabel => null;

  @override
  Duration get transitionDuration => kThemeAnimationDuration;

  @override
  bool get barrierDismissible => true;

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return Container(
      color: Color.fromRGBO(0, 0, 0, 0),
      child: Stack(
        children: <Widget>[
          Center(
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 16),
              constraints: BoxConstraints(
                minWidth: 130.0,
                minHeight: 130.0,
              ),
              decoration: new BoxDecoration(
                color: Colors.black.withOpacity(0.8),
                borderRadius: BorderRadius.circular(6.0)
              ),
              child: _getCenterContent(),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    return super.buildTransitions(context, animation, secondaryAnimation, child);
  }

  Widget _getCenterContent() {
    Widget iconView;
    Widget messageView;

    switch (type) {
      case ProgressHUDType.INFO:
        iconView = Icon(Icons.info, color: Colors.white, size: 36);
        break;
      case ProgressHUDType.SUCCESS:
        iconView = Icon(Icons.check, color: Colors.white, size: 36);
        break;
      case ProgressHUDType.ERROR:
        iconView = Icon(Icons.close, color: Colors.white, size: 36);
        break;
      default:
        iconView = _getCircularProgress();
        break;
    }

    if (message != null && message.isNotEmpty) {
      messageView = Container(
        margin: EdgeInsets.only(top: 16.0),
        child: new Text(
          message,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.normal,
            color: Colors.white,
            decoration: TextDecoration.none
          ),
        ),
      );
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        iconView,
        messageView,
      ],
    );
  }

  Widget _getCircularProgress() {
    return new CircularProgressIndicator(
        valueColor: new AlwaysStoppedAnimation(Colors.white));
  }
}
