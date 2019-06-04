import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../utilities/constants.dart';
import './_account.dart';
import './_stores.dart';
import './_users.dart';

class ApiClient {
  static ApiClient shared = new ApiClient();

  Dio _http;

  var _defaultStoreId;

  AccountService    _accountService;
  StoresService     _storesService;
  UsersService      _usersService;

  ApiClient() {
    BaseOptions options = new BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: 5000,
      receiveTimeout: 3000,
      headers: {
        "Accept": "application/json",
        "Content-Type": "application/json"
      },
      responseType: ResponseType.json,
    );
    this._http = new Dio(options);
    this._http.interceptors.add(InterceptorsWrapper(
      onRequest: (RequestOptions options) async {
        String accessToken = (await SharedPreferences.getInstance())
          .getString('access_token');

        if (accessToken != null && accessToken.isNotEmpty) {
          options.headers['Authorization'] = 'Bearer $accessToken';
        }

        return options;
      },
      onError: (DioError e) {
        switch (e.type) {
          case DioErrorType.DEFAULT:
            e.message = '网络请求失败，请稍后重试。';
            break;
          case DioErrorType.CONNECT_TIMEOUT:
            e.message = '网络请求超时，请稍后重试。';
            break;
          case DioErrorType.RESPONSE:
            e.message = '请求失败，状态码为 ${e.response.statusCode}。';
            if (e.response != null) {
              var errors = e.response.data['errors'];
              if (errors != null && errors.length > 0) {
                e.message = errors[0]['message'];
              }
            }
            break;
          default: break;
        }
        return e;
      }
    ));

    this._accountService    = new AccountService(_http);
    this._storesService     = new StoresService(_http);
    this._usersService      = new UsersService(_http);
  }

  void setDefaultStoreId(id) {
    this._defaultStoreId = id;
  }

  StoresService get defaultStore {
    _storesService.setStoreId(_defaultStoreId);
    return _storesService;
  }

  AccountService get account => _accountService;

  UsersService get users => _usersService;

  StoresService store(id) {
    _storesService.setStoreId(id);
    return _storesService;
  }

  StoresService get stores => _storesService;

  UsersService user(id) {
    _usersService.setUserId(id);
    return _usersService;
  }
}
