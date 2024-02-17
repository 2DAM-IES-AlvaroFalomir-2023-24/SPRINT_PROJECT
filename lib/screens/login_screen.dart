import 'package:flutter/material.dart';
import 'package:sprint/data/odoo_connect.dart';
import 'package:sprint/screens/home_screen.dart';
import 'package:sprint/screens/register_screen.dart';
import 'package:sprint/screens/user_screen.dart';

import 'package:sprint/app_localizations.dart';
import 'package:sprint/model/language.dart';
import 'package:sprint/model/user.dart';

class LoginScreen extends StatefulWidget{
  const LoginScreen({super.key});

  @override
  State<StatefulWidget> createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen>{

  // late User a = User("a", "a", true, "a", Language.enUS);
  @override
  void initState() {
    super.initState();
    OdooConnect.initialize();
    // OdooConnect.getUserByEmail("damproyectoflutter@gmail.com").then((value) => a = value!);
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.translate('login')),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(
                  icon: Icon(Icons.person),
                  hintText: AppLocalizations.of(context)!.translate('usernameHintText'),
                  labelText: AppLocalizations.of(context)!.translate('username')
                  )
              ),
              TextFormField(
                obscureText: true,
                decoration: InputDecoration(
                  icon: const Icon(Icons.lock),
                  hintText: AppLocalizations.of(context)!.translate('passwordHintText'),
                  labelText: AppLocalizations.of(context)!.translate('password')
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: ElevatedButton(
                  onPressed: () {
                    // Aquí va la lógica de inicio de sesión
                  },
                  child: Text(AppLocalizations.of(context)!.translate('login')),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => RegisterScreen()));
                  },
                  child: Text(AppLocalizations.of(context)!.translate('register')),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const HomeScreen()));
                  },
                  child: Text(AppLocalizations.of(context)!.translate('home')),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const UserScreen()));
                  },
                  child: Text(AppLocalizations.of(context)!.translate('updateProfile')),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

}