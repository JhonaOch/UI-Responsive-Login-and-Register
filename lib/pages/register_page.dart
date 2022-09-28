import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ui_login/pages/login_page.dart';
import 'package:flutter_ui_login/utlis/responsive.dart';
import 'package:flutter_ui_login/widgets/avatar_widget.dart';
import 'package:flutter_ui_login/widgets/circle_widget.dart';
import 'package:flutter_ui_login/widgets/register_form_widget.dart';
import 'package:page_transition/page_transition.dart';

class RegisterPage extends StatefulWidget {
  static const routeName = 'register';
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
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
                  top: -pinkSize * 0.20,
                  right: -pinkSize * 0.2,
                  child: Circle(
                      size: pinkSize,
                      colors: const [Colors.pinkAccent, Colors.pink]),
                ),
                Positioned(
                  top: -orangeSize * 0.25,
                  left: -orangeSize * 0.15,
                  child: Circle(
                      size: orangeSize,
                      colors: const [Colors.orange, Colors.deepOrangeAccent]),
                ),
                Positioned(
                    top: pinkSize * 0.25,
                    child: Column(
                      children: [
                        Text(
                          "Hello\n Sign up get started!",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: responsive.dp(2.5),
                            fontWeight: FontWeight.bold,
                            color: const Color.fromARGB(255, 255, 255, 255),
                          ),
                        ),
                        SizedBox(
                          height: responsive.dp(6),
                        ),
                        Avatar(
                          imageSize: responsive.wp(30),
                        )
                      ],
                    )),

                Positioned(
                  left: responsive.dp(2.5),
                  top: responsive.dp(1),
                  child: SafeArea(
                    child: CupertinoButton(
                      color: Colors.black12,
                      padding: const EdgeInsets.all(10),
                      borderRadius: BorderRadius.circular(30),
                      child: const Icon(Icons.arrow_back),
                      onPressed: () {
                        Navigator.push(
                            context,
                            PageTransition(
                                type: PageTransitionType.fade,
                                child: const LoginPage()));
                      },
                    ),
                  ),
                ),

                const RegisterForm()

                // const LoginForm()
              ],
            )),
      ),
    ));
  }
}
