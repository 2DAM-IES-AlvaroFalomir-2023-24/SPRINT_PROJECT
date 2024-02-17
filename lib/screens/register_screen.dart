import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:sprint/app_localizations.dart';
import '../Controller/user_controller.dart';
import 'package:sprint/bloc/register_bloc.dart';
import 'package:sprint/screens/home_screen.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});
  final emeailController = TextEditingController();
  final passwordController = TextEditingController();
  final passwordConfirmController = TextEditingController();
  final Logger logger = Logger();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.translate('register')),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: ElevatedButton(
                  onPressed: () {
                    // Aquí va la lógica de inicio de sesión
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50.0),
                    ),
                  ),
                  child: TextButton(
                    onPressed: () async {
                      try {
                        final user = UserController().signInWithGoogle();
                        if (user != null) {
                          //Trabajar con user
                          user.then((value) => logger.i("User: $value"));
                        }
                      } on FirebaseAuthException catch (e) {
                        logger.e('FirebaseAuthException: ${e.message}');
                      }
                    },
                    child: const Text("SIGN IN WITH GOOGLE"),
                  ),
                ),
              ),
              TextFormField(
                controller: emeailController,
                cursorColor: Theme.of(context).primaryColor,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  icon: const Icon(Icons.person),
                  hintText: AppLocalizations.of(context)!
                      .translate('usernameHintText'),
                  labelText:
                      AppLocalizations.of(context)!.translate('username'),
                ),
              ),
              TextFormField(
                controller: passwordController,
                cursorColor: Theme.of(context).primaryColor,
                textInputAction: TextInputAction.next,
                obscureText: true,
                decoration: InputDecoration(
                  icon: const Icon(Icons.lock),
                  hintText: AppLocalizations.of(context)!
                      .translate('passwordHintText'),
                  labelText:
                      AppLocalizations.of(context)!.translate('password'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: ElevatedButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (context) =>
                            const Center(child: CircularProgressIndicator()));
                    signUpWithEmailAndPassword(
                            email: emeailController.text.trim(),
                            password: passwordController.text.trim())
                        .then((value) => {
                              if (value)
                                {
                                  Navigator.pushReplacementNamed(
                                      context, 'home')
                                }
                              else
                                {
                                  Future.delayed(
                                      const Duration(seconds: 3),
                                      () => {
                                            Navigator.pop(context),
                                            showDialog(
                                              context: context,
                                              builder: (context) => AlertDialog(
                                                title: const Text('Error'),
                                                content: const Text(
                                                    'Se ha producido un error inesperado.'),
                                                actions: <Widget>[
                                                  TextButton(
                                                    onPressed: () =>
                                                        Navigator.pop(context),
                                                    child:
                                                        const Text('Aceptar'),
                                                  ),
                                                ],
                                              ),
                                            )
                                          }),
                                  logger.e('Error al registrar usuario')
                                }
                            });
                  },
                  child:
                      Text(AppLocalizations.of(context)!.translate('register')),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
