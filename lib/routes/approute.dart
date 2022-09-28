import 'package:flutter/material.dart';
import 'package:flutter_ui_login/pages/home_page.dart';
import 'package:flutter_ui_login/pages/login_page.dart';
import 'package:flutter_ui_login/pages/register_page.dart';
import 'package:flutter_ui_login/pages/splash_page.dart';

final Map<String, WidgetBuilder> appRoutes = {
  LoginPage.routeName: (_) => const LoginPage(),
  RegisterPage.routeName: (_) => const RegisterPage(),
  HomePage.routeName: (_) => const HomePage(),
  SplashPage.routeName: (_) => const SplashPage(),
};
