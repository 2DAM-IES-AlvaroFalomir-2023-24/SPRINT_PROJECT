import 'package:flutter/material.dart';
import 'package:sprint/data/odoo_connect.dart';
import 'package:sprint/screens/home_screen.dart';
import 'package:sprint/screens/register_screen.dart';
import 'package:sprint/screens/user_screen.dart';

import '../model/language.dart';
import '../model/user.dart';

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
        title: const Text('Login'),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextFormField(
                decoration: const InputDecoration(
                  icon: Icon(Icons.person),
                  hintText: 'Introduce tu nombre de usuario',
                  labelText: 'Nombre de usuario',
                ),
              ),
              TextFormField(
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
                    // Aquí va la lógica de inicio de sesión
                  },
                  child: const Text('Iniciar sesión'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const RegisterScreen()));
                  },
                  child: const Text('Registrarse'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const HomeScreen()));
                  },
                  child: const Text('Home'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const UserScreen()));
                  },
                  child: const Text('User Profile'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

}