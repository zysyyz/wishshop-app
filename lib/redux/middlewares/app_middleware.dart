import 'package:redux/redux.dart';
import '../states/app_state.dart';
import './auth_middleware.dart';
import './category_middleware.dart';
import './user_middleware.dart';

final List<Middleware<AppState>> appMiddlewares = []
  ..addAll(createAuthMiddleware())
  ..addAll(createCategoryMiddleware())
  ..addAll(createUserMiddleware());
