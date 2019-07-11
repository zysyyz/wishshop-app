import 'package:flutter/material.dart';

import '../../exports.dart';

class BootstrapScreen extends StatefulWidget {
  @override
  _BootstrapScreenState createState() => _BootstrapScreenState();
}

class _BootstrapScreenState extends State<BootstrapScreen> {
  @override
  void initState() {
    sharedApiClient.setDefaultStoreId(1);

    Future
      .delayed(new Duration(seconds: 0))
      .then((_) {
        Navigator
          .of(context)
          .pushReplacement(FadeInPageRoute(builder: (_) => HomeScreen()));
      }
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container()
    );
  }
}
