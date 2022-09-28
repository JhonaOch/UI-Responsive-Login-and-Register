import 'package:flutter/material.dart';
import 'package:flutter_ui_login/api/account.api.dart';
import 'package:flutter_ui_login/data/autentication_client.dart';
import 'package:flutter_ui_login/models/class/user_model.dart';
import 'package:flutter_ui_login/pages/login_page.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';

class HomePage extends StatefulWidget {
  static const routeName = 'home';
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _autenticationClient = GetIt.instance<AutenticationClient>();
  final _accountAPI = GetIt.instance<AccountAPI>();
  UserResponse _user = UserResponse();

  @override
  void initState() {
    super.initState();
    //TODO Que el contexto este asociado a una vista valida
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadUser();
    });
  }

  Future<void> _loadUser() async {
    final response = await _accountAPI.getUserInfo();

    if (response.data != null) {
      final data = UserResponse.fromJson(response.data);

      _user = data;
     // print(_user.name);
      setState(() {});
    }
  }

  Future<void> _signOut() async {
    await _autenticationClient.deleteSession();
    // ignore: use_build_context_synchronously
    Navigator.pushNamedAndRemoveUntil(
        context, LoginPage.routeName, (_) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      width: double.infinity,
      height: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (_user == null) CircularProgressIndicator(),
          if (_user != null) Text(_user.name.toString()),
          Text('Home Page'),
          ElevatedButton(
            child: Text('Logout'),
            onPressed: _signOut,
          )
        ],
      ),
    ));
  }
}
