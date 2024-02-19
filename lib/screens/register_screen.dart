import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:sprint/app_localizations.dart';
import 'package:sprint/data/odoo_connect.dart';
import 'package:sprint/model/language.dart';
import 'package:sprint/model/odoo-user.dart';
import 'package:sprint/screens/home_screen.dart';
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
  final emailController = TextEditingController();
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
                                    labelText: AppLocalizations.of(context)!
                                        .translate('username'),
                                  ),
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  validator: (name) =>
                                      name != null && name.isEmpty
                                          ? AppLocalizations.of(context)
                                              ?.translate("nameCantBeEmpty")
                                          : null),
                              TextFormField(
                                  controller: emailController,
                                  cursorColor: Theme.of(context).primaryColor,
                                  textInputAction: TextInputAction.next,
                                  decoration: InputDecoration(
                                      icon: const Icon(Icons.mail),
                                      hintText: AppLocalizations.of(context)!
                                          .translate('email'),
                                      labelText: AppLocalizations.of(context)!
                                          .translate('email')),
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  validator: (email) => email != null &&
                                          !EmailValidator.validate(email)
                                      ? AppLocalizations.of(context)
                                          ?.translate("nameCantBeEmpty")
                                      : null),
                              TextFormField(
                                controller: passwordController,
                                cursorColor: Theme.of(context).primaryColor,
                                textInputAction: TextInputAction.next,
                                obscureText: !_passwordVisible,
                                decoration: InputDecoration(
                                  suffixIcon: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        _passwordVisible = !_passwordVisible;
                                      });
                                    },
                                    icon: Icon(_passwordVisible
                                        ? Icons.visibility
                                        : Icons.visibility_off),
                                  ),
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
                                    ? AppLocalizations.of(context)!
                                        .translate('passLengthOrWeak')
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
                                validator: (passwordConfirm) =>
                                    passwordConfirm != null &&
                                            !validatePasswordsMatch(
                                                passwordController.text,
                                                passwordConfirm)
                                        ? AppLocalizations.of(context)!
                                            .translate('passesNotMatch')
                                        : null,
                              ),
                              Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 16.0),
                                  child: CustomElevatedButtonWithText(
                                    text: AppLocalizations.of(context)!
                                        .translate('register'),
                                    onPressedFunction: () => signUp(context),
                                  )),
                              TextButton(
                                child: const Text('Enviar'),
                                onPressed: () {
                                  // Llama al BLoC para enviar el correo electrónico
                                  context.read<RegisterBloc>().add(SendPasswordlessEmail(emailController.text));

                                  _showPasswordlessRegisterDialog();


                                },
                              )
                            ]))))));
  }

  void _showPasswordlessRegisterDialog() {
    final TextEditingController _usernameController = TextEditingController();
    // final String randomPassword = generateRandomPassword(12);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Registro sin contraseña'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                TextField(
                  controller: emailController,
                  decoration: const InputDecoration(
                    hintText: 'Introduce tu correo electrónico',
                  ),
                  keyboardType: TextInputType.emailAddress,
                ),
                TextField(
                  controller: _usernameController,
                  decoration: const InputDecoration(
                    hintText: 'Introduce tu nombre de usuario',
                  ),
                ),
                /*Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text('Tu contraseña generada: $randomPassword'),
                ),*/
                // Agrega aquí más campos si son necesarios
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Enviar'),
              onPressed: () async {
                // Recolectar datos del formulario
                final String email = emailController.text;
                final String username = _usernameController.text;
                final bool active = true;
                final Language lang = Language.enUS;


                // Crear instancia de User
                final user = OdooUser(email, "", active, username, lang);

                // Llamar a createUser y manejar la respuesta
                final bool success = await OdooConnect.createUser(user);
                Navigator.of(context).pop(); // Cierra el diálogo

                if (success) {
                  // Mostrar un mensaje de éxito
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Usuario creado exitosamente')),
                  );

                  // Navegar a HomeScreen después de un corto retraso
                  Future.delayed(Duration(seconds: 2), () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => const HomeScreen()),
                    );
                  });
                } else {
                  // Mostrar un mensaje de error
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Error al crear el usuario')),
                  );
                }

              },
            ),


          ],
        );
      },
    );
  }


  void signUp(BuildContext context) {
    final isValid = formKey.currentState!.validate();
    if (!isValid) return;

    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(child: CircularProgressIndicator()));
    signUpWithEmailAndPassword(
            name: nameController.text.trim(),
            email: emailController.text.trim(),
            password: passwordController.text.trim(),
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
