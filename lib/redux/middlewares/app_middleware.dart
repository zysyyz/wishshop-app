import 'package:redux/redux.dart' as redux;
import '../states/app_state.dart';
import './auth_middleware.dart';
import './category_middleware.dart';
import './collection_middleware.dart';
import './product_middleware.dart';
import './user_middleware.dart';

final List<redux.Middleware<AppState>> appMiddlewares = []
  ..addAll(createAuthMiddleware())
  ..addAll(createCategoryMiddleware())
  ..addAll(createCollectionMiddleware())
  ..addAll(createProductMiddleware())
  ..addAll(createUserMiddleware());
