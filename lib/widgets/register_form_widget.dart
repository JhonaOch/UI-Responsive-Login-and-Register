import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ui_login/api/auth.api.dart';
import 'package:flutter_ui_login/data/autentication_client.dart';
import 'package:flutter_ui_login/pages/home_page.dart';
import 'package:flutter_ui_login/pages/login_page.dart';
import 'package:flutter_ui_login/utlis/dialogs.dart';
import 'package:flutter_ui_login/utlis/responsive.dart';
import 'package:flutter_ui_login/widgets/input_widget.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';
import 'package:page_transition/page_transition.dart';

class RegisterForm extends StatefulWidget {
  static const routeName = 'login';
  const RegisterForm({Key? key}) : super(key: key);

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _email = '', _password = '', _username = '', _lastname = '';
  final _autent = GetIt.instance<AutenticationAPI>();

  final Logger _logger = Logger();
  Future<void> submit() async {
    final isOK = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();

    if (isOK) {
      //_formKey.currentState!.save();
      ProgressDialog.show(context);

      final response = await _autent.register(
          username: _username,
          lastname: _lastname,
          email: _email,
          password: _password);

      // ignore: use_build_context_synchronously
      ProgressDialog.dissmiss(context);

      if (response.data != null) {
        _logger.i("Register success");
        // ignore: use_build_context_synchronously

        // await _autenticationClient.saveSession()
        Navigator.pushNamedAndRemoveUntil(
            context, HomePage.routeName, (_) => false);
        // ignore: use_build_context_synchronously
        mostrarAwesonSnackbar(context, "Registro correcto",
            "Usuario creado con exito.", ContentType.success);
      } else {
        String message = response.error!.message;

        _logger.i(response.error?.statusCode.toString());

        if (response.error!.statusCode == -1) {
          message = "No tiene internet";
          // ignore: use_build_context_synchronously
          mostrarAwesonSnackbar(
              context, "Sin conexion a internet", message, ContentType.failure);
        } else if (response.error!.statusCode == 400) {
          message = "El usuario ya existe";
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
          child: Column(children: [
            InputText(
              label: "FIRST NAME",
              keyboardType: TextInputType.text,
              fontSize: responsive.dp(1.8),
              onChange: (text) {
                _username = text;
              },
              validator: (text) {
                if (text!.isEmpty) {
                  return "Email is required";
                }
                return null;
              },
            ),
            SizedBox(
              height: responsive.dp(1.5),
            ),
            InputText(
              label: "LAST NAME",
              keyboardType: TextInputType.text,
              fontSize: responsive.dp(1.8),
              onChange: (text) {
                _lastname = text;
              },
              validator: (text) {
                if (text!.isEmpty) {
                  return "Email is required";
                }
                return null;
              },
            ),
            SizedBox(
              height: responsive.dp(1.5),
            ),
            InputText(
              label: "EMAIL ADDRESS",
              keyboardType: TextInputType.emailAddress,
              fontSize: responsive.dp(1.8),
              onChange: (text) {
                _email = text;
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

            InputText(
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
                }),

            SizedBox(
              height: responsive.dp(3),
            ),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                  style: ButtonStyle(
                      padding: MaterialStateProperty.all<EdgeInsets>(
                          const EdgeInsets.symmetric(vertical: 15)),
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.pinkAccent)),
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
                  "Already have on account?",
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
                    "Sign in",
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
                            type: PageTransitionType.rightToLeft,
                            child: const LoginPage()));
                  },
                )
              ],
            ),

            SizedBox(
              height: responsive.dp(1),
            ),
          ]),
        ),
      ),
    );
  }
}
