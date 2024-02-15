import 'package:flutter/material.dart';
import 'package:sprint/app_localizations.dart';

class RegisterScreen extends StatelessWidget{
  const RegisterScreen({super.key});

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
              TextFormField(
                decoration:  InputDecoration(
                  icon: const Icon(Icons.person),
                  hintText: AppLocalizations.of(context)!.translate('usernameHintText'),
                  labelText: AppLocalizations.of(context)!.translate('username'),
                ),
              ),
              TextFormField(
                obscureText: true,
                decoration: InputDecoration(
                  icon: const Icon(Icons.lock),
                  hintText: AppLocalizations.of(context)!.translate('passwordHintText'),
                  labelText: AppLocalizations.of(context)!.translate('password'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: ElevatedButton(
                  onPressed: () {
                    // Aquí va la lógica de inicio de sesión
                  },
                  child: Text(AppLocalizations.of(context)!.translate('register')),
                ),
              ),
              
            ],
          ),
        ),
      ),
    );
  }
  
}