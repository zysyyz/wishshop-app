import '../states/app_state.dart';
import './auth_reducer.dart';
import './category_reducer.dart';
import './user_reducer.dart';

AppState appReducer(AppState state, action) {
  return AppState(
    auth: authReducer(state.auth, action),
    category: categoryReducer(state.category, action),
    // user: userReducer(state.user, action),
  );
}
