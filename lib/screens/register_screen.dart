import 'package:flutter/material.dart';
import 'package:sprint/bloc/register_bloc.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});
  final emeailController = TextEditingController();
  final passwordController = TextEditingController();
  final passwordConfirmController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
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
                  child: const Text('Google'),
                ),
              ),
              TextFormField(
                controller: emeailController,
                cursorColor: Theme.of(context).primaryColor,
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(
                  icon: Icon(Icons.person),
                  hintText: 'Introduce tu nombre de usuario',
                  labelText: 'Nombre de usuario',
                ),
              ),
              TextFormField(
                controller: passwordController,
                cursorColor: Theme.of(context).primaryColor,
                textInputAction: TextInputAction.next,
                obscureText: true,
                decoration: const InputDecoration(
                  icon: Icon(Icons.lock),
                  hintText: 'Introduce tu contraseña',
                  labelText: 'Contraseña',
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: ElevatedButton(
                  onPressed: () {
                    signUpWithEmailAndPassword(email: emeailController.text.trim(), password: passwordController.text.trim());
                  },
                  child: const Text('Registro'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
