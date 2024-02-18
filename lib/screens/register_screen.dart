import 'package:bcrypt/bcrypt.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:sprint/app_localizations.dart';
import 'package:sprint/bloc/social_sign_and_login.dart';
import 'package:sprint/screens/veify_email_screen.dart';
import 'package:sprint/widget/custom_elevated_button_with_text.dart';
import 'package:sprint/widget/show_dialog_exeception.dart';
import 'package:sprint/bloc/register_bloc.dart';
import 'package:sprint/screens/home_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<StatefulWidget> createState() => RegisterScreenState();
}

class RegisterScreenState extends State<RegisterScreen> {
  final formKey = GlobalKey<FormState>();
  final emeailController = TextEditingController();
  final passwordController = TextEditingController();
  final passwordConfirmController = TextEditingController();

  final nameController = TextEditingController();
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
        body: Form(
            key: formKey,
            child: Center(
                child: SingleChildScrollView(
                    child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 16.0),
                                child: ElevatedButton(
                                  onPressed: () async {
                                    final provider =
                                        Provider.of<SingAndLoginClass>(context,
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
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 16.0),
                                  child: CustomElevatedButtonWithText(
                                    text: AppLocalizations.of(context)!
                                        .translate('signInWithGoogle'),
                                    onPressedFunction: () async {
                                      final provider =
                                          Provider.of<SingAndLoginClass>(
                                              context,
                                              listen: false);

                                      if (await provider.googleLogin()) {
                                        Navigator.of(context).pushReplacement(
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const HomeScreen(),
                                          ),
                                        );
                                      }
                                    },
                                  )),
                              TextFormField(
                                  controller: nameController,
                                  cursorColor: Theme.of(context).primaryColor,
                                  textInputAction: TextInputAction.next,
                                  decoration: InputDecoration(
                                    icon: const Icon(Icons.person),
                                    hintText: AppLocalizations.of(context)!
                                        .translate('usernameHintText'),
                                    labelText: AppLocalizations.of(context)!
                                        .translate('username'),
                                  ),
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  validator: (name) => name != null && name.isEmpty
                                      ? 'The name can\'t be empty' //TODO: Translate
                                      : null),
                              TextFormField(
                                  controller: emeailController,
                                  cursorColor: Theme.of(context).primaryColor,
                                  textInputAction: TextInputAction.next,
                                  decoration: InputDecoration(
                                    icon: const Icon(Icons.mail),
                                    hintText: 'Email', //TODO: Translate
                                    labelText: 'Email', //TODO: Translate
                                  ),
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  validator: (email) => email != null &&
                                          !EmailValidator.validate(email)
                                      ? 'The name can\'t be empty' //TODO: Translate
                                      : null),
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
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                validator: (password) => password != null &&
                                        !validatePasswordLengthAndWeak(password)
                                    ? 'Password must be at least 6 characters long and contain at least one uppercase letter and one number' //TODO: Translate
                                    : null,
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
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                validator: (passwordConfirm) =>passwordConfirm !=
                                            null &&
                                        !validatePasswordsMatch(
                                            passwordController.text,
                                            passwordConfirm)
                                    ? 'Passwords do not match' //TODO: Translate
                                    : null,
                                onTap: () {
                                  setState(() {
                                    _confirmPasswordVisible =
                                        !_confirmPasswordVisible;
                                  });
                                },
                              ),
                              Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 16.0),
                                  child: CustomElevatedButtonWithText(
                                    text: AppLocalizations.of(context)!
                                        .translate('register'),
                                    onPressedFunction: () => signUp(context),
                                  ))
                            ]))))));
  }

  void signUp(BuildContext context) {
    final isValid = formKey.currentState!.validate();
    if (!isValid) return;

    String passHashed = BCrypt.hashpw(passwordController.text, BCrypt.gensalt());

    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(child: CircularProgressIndicator()));
    signUpWithEmailAndPassword(
            name: nameController.text.trim(),
            email: emeailController.text.trim(),
            password: passHashed,
            context: context)
        .catchError((e) {
      MyDialogExeception(message: e.toString()).showDialogWithDelay(context);
    }).then((value) => {
              if (value)
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const VerifyEmailScreen()))
            });
  }
}
