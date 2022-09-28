import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_ui_login/api/account.api.dart';
import 'package:flutter_ui_login/api/auth.api.dart';
import 'package:flutter_ui_login/data/autentication_client.dart';
import 'package:flutter_ui_login/global/env.dart';
import 'package:flutter_ui_login/helpers/http.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';

abstract class DependencyInjection {
  static void initialize() {
    final Dio dio = Dio(
      BaseOptions(baseUrl: Enviroment.apiUrl),
    );

    Logger logger = Logger();

    Http http = Http(
      dio: dio,
      logger: logger,
      logsEnabled: true,
    );

    FlutterSecureStorage flutterSecureStorage = const FlutterSecureStorage();

    final AutenticationAPI autent = AutenticationAPI(http);
    final AutenticationClient autenticationClient =
        AutenticationClient(flutterSecureStorage, autent);

    final AccountAPI account = AccountAPI(http, autenticationClient);

    GetIt.instance.registerSingleton<AutenticationClient>(autenticationClient);
    GetIt.instance.registerSingleton<AutenticationAPI>(autent);
    GetIt.instance.registerSingleton<AccountAPI>(account);
  }
}
