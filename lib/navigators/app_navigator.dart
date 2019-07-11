import 'package:flutter/material.dart';
import 'package:redux/redux.dart' as redux;
import 'package:flutter_redux/flutter_redux.dart';
import '../exports.dart';

class AppNavigator extends StatelessWidget {
  final redux.Store<AppState> store;

  AppNavigator({Key key, this.store}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new StoreProvider<AppState> (
      store: store,
      child: MaterialApp(
        theme: ThemeData(
          primaryColor: Colors.black,
          primaryColorBrightness: Brightness.light,
          accentColor: Colors.black,
          primaryTextTheme: TextTheme(title: TextStyle(fontSize: 17)),
          scaffoldBackgroundColor: Color(0xfff6f6f6),
          // hintColor: Colors.black,
          buttonTheme: ButtonThemeData(
            height: 48,
            buttonColor: Colors.black,
            // highlightColor: Color(0xffffff).withOpacity(0.2),
            // splashColor: Colors.black,
            // colorScheme: ColorScheme.light(
            //   primary: Colors.black87,
            // ),
            shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(0.0)),
          ),
          inputDecorationTheme: new InputDecorationTheme(
            labelStyle: TextStyle(fontSize: 14),
            enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Color(0xffeaedf3)))
          ),
          // dividerColor: const Color(0x2F000000)
        ),
        home: BootstrapScreen(),
      ),
    );
  }
}
