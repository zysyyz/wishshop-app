import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import '../../models/models.dart';
import '../../networking/networking.dart';
import '../../redux/redux.dart';
import '../../routes/routes.dart';
import '../login/login.dart';
import '../home/home.dart';

checkIfAuthenticated(User user) async {
  await Future.delayed(Duration(microseconds: 0));
  if (user == null) {
    return false;
  }
  return true;
}

class BootstrapScreen extends StatelessWidget {
  Widget _build(BuildContext context) {
    return Scaffold(
      body: Center(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, int>(
      builder: (BuildContext context, _) {
        return _build(context);
      },
      converter: (store) => 0,
      onInit: (store) {
        sharedApiClient.setDefaultStoreId(1);
        var auth = store.state.auth;
        checkIfAuthenticated(auth.user)
          .then((isLoggedIn) {
            Navigator
              .of(context)
              .pushReplacement(FadeInPageRoute(builder: (_) => HomeScreen()));
          });
      },
    );
  }
}
