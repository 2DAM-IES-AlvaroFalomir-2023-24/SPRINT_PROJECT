import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:sprint/app_localizations.dart';
import 'package:sprint/widget/show_dialog_exeception.dart';
import '../Controller/user_controller.dart';
import 'package:sprint/bloc/register_bloc.dart';
import 'package:sprint/screens/home_screen.dart';

/// This is the [RegisterScreen] class.
/// It is a [StatelessWidget] that represents the screen for user registration.
/// The screen contains a form with input fields for email, password, and password confirmation.
/// It also includes buttons for signing in with Google and registering a new account.
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
                        final user = UserController().signInWithFacebook();
                        if (user != null) {
                          //Trabajar con user
                          user.then((value) => logger.i("User: $value"));
                        }
                      } on FirebaseAuthException catch (e) {
                        logger.e('FirebaseAuthException: ${e.message}');
                      }
                    },
                    child: const Text("SIGN IN WITH FACEBOOK"),
                  ),
                ),
              ),
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
              TextFormField(
                controller: passwordConfirmController,
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
                    signUp(context);
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

  void signUp(BuildContext context) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(child: CircularProgressIndicator()));
    signUpWithEmailAndPassword(
            email: emeailController.text.trim(),
            password: passwordController.text.trim(),
            passwordConfirm: passwordConfirmController.text.trim())
        .catchError((e) {
      MyDialogExeception(mensage: e.toString()).showDialogWithDelay(context);
    }).then((value) => {
              if (value)
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => const HomeScreen()))
            });
  }
}
