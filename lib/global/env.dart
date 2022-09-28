import 'dart:io';

class Enviroment {
  static String apiUrl = Platform.isAndroid
      ? 'http://192.168.100.20:3000/api/v1'
      : 'http://localhost:3000/api/v1';
}
