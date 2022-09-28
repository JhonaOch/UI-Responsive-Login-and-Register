import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ui_login/api/auth.api.dart';
import 'package:flutter_ui_login/data/autentication_client.dart';
import 'package:flutter_ui_login/pages/home_page.dart';
import 'package:flutter_ui_login/pages/register_page.dart';
import 'package:flutter_ui_login/utlis/dialogs.dart';
import 'package:flutter_ui_login/utlis/responsive.dart';
import 'package:flutter_ui_login/widgets/input_widget.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';
import 'package:page_transition/page_transition.dart';

class LoginForm extends StatefulWidget {
  static const routeName = 'login';
  const LoginForm({Key? key}) : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final Logger _logger = Logger();
  String _email = '', _password = '';
  final _autent = GetIt.instance<AutenticationAPI>();
  final _autenticationClient = GetIt.instance<AutenticationClient>();

  submit() async {
    final isOK = _formKey.currentState!.validate();

    if (isOK) {
      ProgressDialog.show(context);

      final response = await _autent.login(email: _email, password: _password);
      // ignore: use_build_context_synchronously
      ProgressDialog.dissmiss(context);

      if (response.data != null) {
        // print(response.data);
        await _autenticationClient.saveSession(response.data!);

        // print(loginResponseToJson(data));

        // ignore: use_build_context_synchronously
        Navigator.pushNamedAndRemoveUntil(
            context, HomePage.routeName, (_) => false);
        // ignore: use_build_context_synchronously
        mostrarAwesonSnackbar(context, "Ingreso correcto", "Bienvenido :D !",
            ContentType.success);
      } else {
        String message = response.error!.message;

        _logger.i(response.error?.statusCode.toString());

        if (response.error!.statusCode == -1) {
          message = "No tiene internet";
          // ignore: use_build_context_synchronously
          mostrarAwesonSnackbar(
              context, "Sin conexion a internet", message, ContentType.failure);
        } else if (response.error!.statusCode == 401) {
          message = "Contraseña o email incorrecto.";
          // ignore: use_build_context_synchronously
          mostrarAwesonSnackbar(context, "Error", message, ContentType.failure);
        } else {
          message = "Error desconocido";
          // ignore: use_build_context_synchronously
          mostrarAwesonSnackbar(context, "Error", message, ContentType.failure);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive.of(context);
    return Positioned(
      bottom: 30,
      child: Container(
        constraints: BoxConstraints(
          maxWidth: responsive.isTablet! ? 430 : 360,
        ),
        child: Form(
          key: _formKey,
          child: Column(
              // ignore: prefer_const_literals_to_create_immutables
              children: [
                InputText(
                  label: "EMAIL ADDRESS",
                  keyboardType: TextInputType.emailAddress,
                  fontSize: responsive.dp(1.8),
                  onChange: (text) {
                    _email = text;
                    // print(text);
                  },
                  validator: (text) {
                    if (text!.isEmpty || !text.contains("@")) {
                      return "Email is required";
                    }
                    return null;
                  },
                ),

                SizedBox(
                  height: responsive.dp(1.5),
                ),
                // ignore: prefer_const_constructors
                Container(
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: Colors.black12,
                      ),
                    ),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: InputText(
                            label: "PASSWORD",
                            keyboardType: TextInputType.text,
                            fontSize: responsive.dp(1.8),
                            obscureText: true,
                            borderEnabled: false,
                            validator: (text) {
                              if (text!.trim().isEmpty) {
                                return "Password is required";
                              }
                              return null;
                            },
                            onChange: (text) {
                              _password = text;
                              //print(text);
                            }),
                      ),
                      TextButton(
                        style: ButtonStyle(
                            padding: MaterialStateProperty.all<EdgeInsets>(
                                EdgeInsets.symmetric(vertical: 10))),
                        child: Text(
                          "Forgot Password?",
                          style: TextStyle(
                            color: const Color.fromARGB(255, 0, 0, 0),
                            fontWeight: FontWeight.bold,
                            fontSize: responsive.dp(1.5),
                          ),
                        ),
                        onPressed: () {},
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: responsive.dp(5),
                ),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                      style: ButtonStyle(
                          padding: MaterialStateProperty.all<EdgeInsets>(
                              const EdgeInsets.symmetric(vertical: 15)),
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Colors.pinkAccent)),
                      onPressed: submit,
                      child: Text(
                        "Sign in",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: responsive.dp(1.8),
                        ),
                      )),
                ),

                SizedBox(
                  height: responsive.dp(2),
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account?",
                      style: TextStyle(
                        color: Colors.black45,
                        fontWeight: FontWeight.w500,
                        fontSize: responsive.dp(1.5),
                      ),
                    ),
                    TextButton(
                      style: ButtonStyle(
                          padding: MaterialStateProperty.all<EdgeInsets>(
                              const EdgeInsets.symmetric(vertical: 10))),
                      child: Text(
                        "Sign up",
                        style: TextStyle(
                          color: Colors.pinkAccent,
                          fontWeight: FontWeight.bold,
                          fontSize: responsive.dp(1.5),
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            PageTransition(
                                type: PageTransitionType.leftToRight,
                                child: const RegisterPage()));
                      },
                    )
                  ],
                ),

                SizedBox(
                  height: responsive.dp(10),
                ),
              ]),
        ),
      ),
    );
  }
}
