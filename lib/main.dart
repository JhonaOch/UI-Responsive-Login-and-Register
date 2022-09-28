import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_ui_login/helpers/dependency_injection.dart';
import 'package:flutter_ui_login/routes/approute.dart';

void main() {
  DependencyInjection.initialize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ///Para que la aplicacion no permita la rotacion del dispositivo
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            //primarySwatch: Colors.blue,
            visualDensity: VisualDensity.adaptivePlatformDensity),
        initialRoute: "splash",
        routes: appRoutes);
  }
}
