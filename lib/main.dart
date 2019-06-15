import 'dart:io';
import 'package:flutter/material.dart';
import 'package:redux/redux.dart' as redux;
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux_persist/redux_persist.dart';
import 'package:redux_persist_flutter/redux_persist_flutter.dart';
import 'package:flutter_flipperkit/flutter_flipperkit.dart';
import 'package:flipperkit_redux_middleware/flipperkit_redux_middleware.dart';
import './redux/redux.dart';
import './screens/screens.dart';

void main() async {
  FlipperClient flipperClient = FlipperClient.getDefault();

  flipperClient.addPlugin(new FlipperNetworkPlugin(
    filter: (HttpClientRequest request) {
      String url = '${request.uri}';
      if (url.startsWith('https://res.yslbeautycn.com')
        || url.startsWith('https://via.placeholder.com')
        || url.startsWith('https://cn.gravatar.com')
      ) {
        return false;
      }
      return true;
    }
  ));
  flipperClient.addPlugin(new FlipperReduxInspectorPlugin());
  flipperClient.addPlugin(new FlipperSharedPreferencesPlugin());
  flipperClient.start();

  // Create Persistor
  final persistor = Persistor<AppState>(
    storage: FlutterStorage(),
    serializer: JsonSerializer<AppState>(AppState.fromJson),
  );

  // Load initial state
  final initialState = await persistor.load();

  final store = redux.Store<AppState>(
    appReducer,
    initialState: initialState ?? AppState(),
    middleware: []
      ..addAll(appMiddlewares)
      ..add(persistor.createMiddleware())
      ..add(new FlipperKitReduxMiddleware())
  );

  runApp(MyApp(
    store: store
  ));
}

class MyApp extends StatelessWidget {
  final redux.Store<AppState> store;

  MyApp({Key key, this.store}) : super(key: key);

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
          scaffoldBackgroundColor: Color(0xfff5f6f7),
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
