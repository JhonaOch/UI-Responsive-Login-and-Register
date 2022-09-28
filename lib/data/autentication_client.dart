import 'dart:async';
import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_ui_login/api/auth.api.dart';
import 'package:flutter_ui_login/models/session.dart';

class AutenticationClient {
  final FlutterSecureStorage _secureStorage;
  final AutenticationAPI _autenticationApi;

  Completer? _completer;

  AutenticationClient(this._secureStorage, this._autenticationApi);

  void _complete() {
    if (_completer != null && !_completer!.isCompleted) {
      _completer!.complete();
    }
  }

  Future<String?> get accessToken async {
    if (_completer != null) {
      await _completer!.future;
    }

    _completer = Completer();

    final data = await _secureStorage.read(key: 'SESSION');

    print('data: $data');

    if (data != null) {
      final session = SessionResponse.fromJson(json.decode(data));

      if (session.accessToken != null) {
        _complete();
        return session.accessToken;
      }
      final response = await _autenticationApi.refresToken(
          token: session.accessToken as String);
      if (response.data != null) {
        await saveSession(response.data);
        _complete();
        return response.data.accessToken;
      }
      _complete();
      return null;
    }
    _complete();
    return null;
  }

  Future<void> saveSession(Map<String, dynamic> response) async {
    final SessionResponse session = SessionResponse(
      accessToken: response['accessToken'],
      createAt: DateTime.now(),
    );

    final data = jsonEncode(session.toJson());
    await _secureStorage.write(key: 'SESSION', value: data);
  }

  Future<void> deleteSession() async {
    await _secureStorage.deleteAll();
  }
}
