import 'dart:io';
import 'package:intl/date_symbol_data_local.dart';
import 'package:flutter/material.dart';
import 'package:redux/redux.dart' as redux;
import 'package:redux_persist/redux_persist.dart';
import 'package:redux_persist_flutter/redux_persist_flutter.dart';
// import 'package:flutter_flipperkit/flutter_flipperkit.dart';
// import 'package:flipperkit_redux_middleware/flipperkit_redux_middleware.dart';

import './exports.dart';

void main() async {
  // FlipperClient flipperClient = FlipperClient.getDefault();

  // flipperClient.addPlugin(new FlipperNetworkPlugin(
  //   filter: (HttpClientRequest request) {
  //     String url = '${request.uri}';
  //     if (url.startsWith('https://res.yslbeautycn.com') || url.startsWith('https://cn.gravatar.com')
  //     ) {
  //       return false;
  //     }
  //     return true;
  //   }
  // ));
  // flipperClient.addPlugin(new FlipperReduxInspectorPlugin());
  // flipperClient.addPlugin(new FlipperSharedPreferencesPlugin());
  // flipperClient.start();

  await initializeDateFormatting("zh_CN", null);

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
      // ..add(new FlipperKitReduxMiddleware())
  );

  runApp(AppNavigator(
    store: store
  ));
}

