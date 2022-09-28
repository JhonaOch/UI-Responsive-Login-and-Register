import 'package:flutter_ui_login/data/autentication_client.dart';
import 'package:flutter_ui_login/helpers/http.dart';
import 'package:flutter_ui_login/helpers/http_response.dart';

class AccountAPI {
  final Http _http;
  final AutenticationClient autenticationClient;

  AccountAPI(this._http, this.autenticationClient);

  Future<HttpResponse> getUserInfo() async {
    final token = await autenticationClient.accessToken;
    return _http.request(
      '/user/my-info',
      method: 'GET',
      headers: {
        'Authorization': 'Bearer $token',
      },
    );
  }
}
