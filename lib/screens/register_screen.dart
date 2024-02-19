import 'package:bcrypt/bcrypt.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:sprint/app_localizations.dart';
import 'package:sprint/widget/veify_email_dialog.dart';
import 'package:sprint/widget/custom_elevated_button_with_text.dart';
import 'package:sprint/widget/show_dialog_exeception.dart';
import 'package:sprint/bloc/register_bloc.dart';

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
                              TextFormField(
                                  controller: nameController,
                                  cursorColor: Theme.of(context).primaryColor,
                                  textInputAction: TextInputAction.next,
                                  decoration: InputDecoration(
                                    icon: const Icon(Icons.person),
                                    hintText: AppLocalizations.of(context)!
                                        .translate('usernameHintText'),
                                    labelText:
                                    AppLocalizations.of(context)!.translate('username'),
                                  ),
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  validator: (name) => name != null &&
                                          name.isEmpty
                                      ? 'The name can\'t be empty' //TODO: Translate
                                      : null),
                              TextFormField(
                                  controller: emeailController,
                                  cursorColor: Theme.of(context).primaryColor,
                                  textInputAction: TextInputAction.next,
                                  decoration: InputDecoration(
                                    icon: const Icon(Icons.mail),
                                    hintText: AppLocalizations.of(context)!.translate('email'),
                                    labelText: AppLocalizations.of(context)!.translate('email')
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
                                  suffixIcon: IconButton(
                                    onPressed:(){
                                      setState(() {
                                        _passwordVisible = !_passwordVisible;
                                      });
                                    },
                                    icon: Icon(_passwordVisible
                                        ? Icons.visibility
                                        : Icons.visibility_off),),
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
                                    ? AppLocalizations.of(context)!.translate('passLengthOrWeak')
                                    : null,
                              ),
                              TextFormField(
                                controller: passwordConfirmController,
                                cursorColor: Theme.of(context).primaryColor,
                                textInputAction: TextInputAction.next,
                                obscureText: !_confirmPasswordVisible,
                                decoration: InputDecoration(
                                  suffixIcon: IconButton(
                                    icon: Icon(_confirmPasswordVisible
                                        ? Icons.visibility
                                        : Icons.visibility_off),
                                    onPressed: () {
                                      setState(() {
                                        _confirmPasswordVisible =
                                        !_confirmPasswordVisible;
                                      });
                                    },
                                  ),
                                  icon: const Icon(Icons.lock),
                                  hintText: AppLocalizations.of(context)!
                                      .translate('passwordHintText'),
                                  labelText: AppLocalizations.of(context)!
                                      .translate('confirmPassword'),
                                ),
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                validator: (passwordConfirm) => passwordConfirm !=
                                            null &&
                                        !validatePasswordsMatch(
                                            passwordController.text,
                                            passwordConfirm)
                                    ? AppLocalizations.of(context)!.translate('passesNotMatch')
                                    : null,
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

    String passHashed =
        BCrypt.hashpw(passwordController.text, BCrypt.gensalt());

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
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return const VerifyEmailDialog();
                  },
                )
            });
  }
}


