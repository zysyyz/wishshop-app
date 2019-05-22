import 'dart:async';
import '../../models/models.dart';

class UsersService {
  final _http;

  var _userId;

  UsersService(this._http);

  void setUserId(id) {
    this._userId = id;
  }

  Future<User> get() async {
    final response = await _http.get('/users/$_userId');

    var d = User.fromJson(response.data['data']);
    return d;
  }
}
