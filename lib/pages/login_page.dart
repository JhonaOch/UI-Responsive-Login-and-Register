import 'package:flutter/material.dart';
import 'package:flutter_ui_login/utlis/responsive.dart';
import 'package:flutter_ui_login/widgets/circle_widget.dart';
import 'package:flutter_ui_login/widgets/icon_container_widget.dart';
import 'package:flutter_ui_login/widgets/login_form_widget.dart';

class LoginPage extends StatefulWidget {
  static const routeName = 'login';
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive.of(context);
    //Obtener datos del dispositivo

    final pinkSize = responsive.wp(80);
    final orangeSize = responsive.wp(57);

    return Scaffold(
        body: GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: SingleChildScrollView(
        child: Container(
            width: double.infinity,
            height: responsive.height,
            color: Colors.white,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Positioned(
                  top: -pinkSize * 0.4,
                  right: -pinkSize * 0.2,
                  child: Circle(
                      size: pinkSize,
                      colors: const [Colors.pinkAccent, Colors.pink]),
                ),
                Positioned(
                  top: -orangeSize * 0.55,
                  left: -orangeSize * 0.15,
                  child: Circle(
                      size: orangeSize,
                      colors: const [Colors.orange, Colors.deepOrangeAccent]),
                ),
                Positioned(
                    top: pinkSize * 0.40,
                    child: Column(
                      children: [
                        IconContainer(size: responsive.wp(27)),
                        SizedBox(
                          height: responsive.dp(03),
                        ),
                        Text(
                          "Hello Again\n Welcome Back!",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: responsive.dp(2.0),
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    )),
                const LoginForm()
              ],
            )),
      ),
    ));
  }
}
