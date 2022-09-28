import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ui_login/data/autentication_client.dart';
import 'package:flutter_ui_login/models/session.dart';
import 'package:flutter_ui_login/pages/home_page.dart';
import 'package:flutter_ui_login/pages/login_page.dart';
import 'package:get_it/get_it.dart';

class SplashPage extends StatefulWidget {
  static const routeName = 'splash';
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final _autenticationClient = GetIt.instance<AutenticationClient>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _chekLogin();
    });
  }

  Future<void> _chekLogin() async {
    final token = await _autenticationClient.accessToken;
    if (token == null) {
      Navigator.pushReplacementNamed(context, LoginPage.routeName);
      return;
    }
    Navigator.pushReplacementNamed(context, HomePage.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
