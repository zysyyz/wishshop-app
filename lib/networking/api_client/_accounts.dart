import 'dart:async';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../models/models.dart';

class AccountsService {
  final Dio _http;

  AccountsService(this._http);

  Future<User> register(String name, String email, String password) async {
    final response = await _http.post(
      '/accounts/register',
      data: {
        "name": name,
        "email": email,
        "password": password,
        "use_gravatar": true,
      }
    );
    var d = User.fromJson(response.data['data']);

    (await SharedPreferences.getInstance())
      .setString("access_token", d.jwtToken.accessToken);

    return d;
  }

  Future<User> login(String email, String password) async {
    final response = await _http.post(
      '/accounts/login',
      data: {
        "email": email,
        "password": password
      }
    );
    var d = User.fromJson(response.data['data']);

    (await SharedPreferences.getInstance())
      .setString("access_token", d.jwtToken.accessToken);

    return d;
  }

  Future logout() async {
    await _http.post('/accounts/logout');

    (await SharedPreferences.getInstance())
      .remove("access_token");
  }

  Future<User> updateProfile({ String name, String gender}) async {
    var data = {};
    if (name != null && name.isNotEmpty) {
      data['name'] = name;
    }
    if (gender != null && gender.isNotEmpty) {
      data['gender'] = gender;
    }

    final response = await _http.patch(
      '/accounts/profile',
      data: data,
    );

    return User.fromJson(response.data['data']);
  }
}
