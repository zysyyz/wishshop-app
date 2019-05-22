import './auth_state.dart';
import './category_state.dart';
// import './user_state.dart';

class AppState {
  final AuthState auth;
  final CategoryState category;
  // final UserState user;

  AppState({
    this.auth,
    this.category,
    // this.user,
  });

  static AppState fromJson(dynamic json) {
    if (json == null) {
      return AppState(
        auth: AuthState(),
        category: CategoryState(),
        // user: UserState(),
      );
    }
    return AppState(
      auth: AuthState.fromJson(json['auth']),
      category: CategoryState.fromJson(json['category']),
      // user: UserState.fromJson(json['user']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'auth': auth.toJson(),
      // 'category': category.toJson(),
      // 'user': user.toJson(),
    };
  }
}
