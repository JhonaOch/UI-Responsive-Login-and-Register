import 'package:flutter_ui_login/helpers/http.dart';
import 'package:flutter_ui_login/helpers/http_response.dart';

class AutenticationAPI {
  final Http _http;

  AutenticationAPI(this._http);

  Future<HttpResponse> register(
      {required String username,
      required String lastname,
      required String email,
      required String password}) {
    return _http.request(
      '/auth/signup',
      method: 'POST',
      data: {
        'username': username,
        'lastname': lastname,
        'email': email,
        'password': password,
      },
      //parser: (data)  { return UserResponse.fromJson(data);},
    );
  }

  Future<HttpResponse> login(
      {required String email, required String password}) {
    return _http.request(
      '/auth/signin',
      method: 'POST',
      data: {
        'email': email,
        'password': password,
      },
      //parser: (data)  { return LoginResponse.fromJson(data);},
    );
  }

  Future<HttpResponse> refresToken({required String token}) async {
    return _http.request(
      '/auth/token/refresh',
      method: 'POST',
      headers: {
        'Authorization': 'Bearer $token',
      },
      //parser: (data)  { return UserResponse.fromJson(data);},
    );
  }
}
