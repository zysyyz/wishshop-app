import '../../models/models.dart';

class AuthState {
  User user;

  AuthState({
    this.user,
  });

  static AuthState fromJson(dynamic json) {
    if (json == null) {
      return new AuthState();
    }
    return AuthState(
      user : json['user'] != null ? User.fromJson(json['user']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user' : user != null ? user.toJson() : null,
    };
  }
}
