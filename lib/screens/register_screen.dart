import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:sprint/app_localizations.dart';
import 'package:sprint/bloc/google_sign_in.dart';
import 'package:sprint/widget/custom_elevated_button_with_text.dart';
import 'package:sprint/widget/show_dialog_exeception.dart';
import 'package:sprint/Controller/user_controller.dart';
import 'package:sprint/bloc/register_bloc.dart';
import 'package:sprint/screens/home_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<StatefulWidget> createState() => RegisterScreenState();
}

class RegisterScreenState extends State<RegisterScreen> {
  final emeailController = TextEditingController();
  final passwordController = TextEditingController();
  final passwordConfirmController = TextEditingController();
  final Logger logger = Logger();
  bool _passwordVisible = false;
  bool _confirmPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(AppLocalizations.of(context)!.translate('register')),
          centerTitle: true,
        ),
        body: Center(
            child: SingleChildScrollView(
                child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 16.0),
                            child: ElevatedButton(
                              onPressed: () async {
                                final provider = Provider.of<SingAndLoginClass>(
                                    context,
                                    listen: false);

                                if (await provider.signInWithFacebook()) {
                                  Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                      builder: (context) => HomeScreen(),
                                    ),
                                  );
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50.0),
                                ),
                              ),
                              child: const Text('Facebook'),
                            ),
                          ),
                          Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 16.0),
                              child: CustomElevatedButtonWithText(
                                text: AppLocalizations.of(context)!
                                    .translate('signInWithGoogle'),
                                onPressedFunction: () async {
                                  final provider =
                                      Provider.of<SingAndLoginClass>(context,
                                          listen: false);

                                  if (await provider.googleLogin()) {
                                    Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(
                                        builder: (context) => HomeScreen(),
                                      ),
                                    );
                                  }
                                },
                              )),
                          TextFormField(
                            controller: emeailController,
                            cursorColor: Theme.of(context).primaryColor,
                            textInputAction: TextInputAction.next,
                            decoration: InputDecoration(
                              icon: const Icon(Icons.person),
                              hintText: AppLocalizations.of(context)!
                                  .translate('usernameHintText'),
                              labelText: AppLocalizations.of(context)!
                                  .translate('username'),
                            ),
                          ),
                          TextFormField(
                            controller: passwordController,
                            cursorColor: Theme.of(context).primaryColor,
                            textInputAction: TextInputAction.next,
                            obscureText: !_passwordVisible,
                            decoration: InputDecoration(
                              suffixIcon: Icon(_passwordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off),
                              icon: const Icon(Icons.lock),
                              hintText: AppLocalizations.of(context)!
                                  .translate('passwordHintText'),
                              labelText: AppLocalizations.of(context)!
                                  .translate('password'),
                            ),
                            onTap: () {
                              setState(() {
                                _passwordVisible = !_passwordVisible;
                              });
                            },
                          ),
                          TextFormField(
                            controller: passwordConfirmController,
                            cursorColor: Theme.of(context).primaryColor,
                            textInputAction: TextInputAction.next,
                            obscureText: !_confirmPasswordVisible,
                            decoration: InputDecoration(
                              suffixIcon: Icon(_confirmPasswordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off),
                              icon: const Icon(Icons.lock),
                              hintText: AppLocalizations.of(context)!
                                  .translate('passwordHintText'),
                              labelText: AppLocalizations.of(context)!
                                  .translate('confirmPassword'),
                            ),
                            onTap: () {
                              setState(() {
                                _confirmPasswordVisible =
                                    !_confirmPasswordVisible;
                              });
                            },
                          ),
                          Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 16.0),
                              child: CustomElevatedButtonWithText(
                                text: AppLocalizations.of(context)!
                                    .translate('register'),
                                onPressedFunction: () => signUp(context),
                              ))
                        ])))));
  }

  void signUp(BuildContext context) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(child: CircularProgressIndicator()));
    signUpWithEmailAndPassword(
            email: emeailController.text.trim(),
            password: passwordController.text.trim(),
            passwordConfirm: passwordConfirmController.text.trim(),
            context: context)
        .catchError((e) {
      MyDialogExeception(message: e.toString()).showDialogWithDelay(context);
    }).then((value) => {
              if (value)
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => const HomeScreen()))
            });
  }
}
