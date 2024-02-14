import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen>{

  final FirebaseAuth _auth = FirebaseAuth.instance;

  //Usuario que utilizaremos para manejar el registro del usuario
  User? _user;

  @override
  void initState() {
    super.initState();
    //Configuramos un oyente para el objeto que maneja el registro de usuario
    _auth.authStateChanges().listen ((user){
      setState(() {
        //Si el usuario es diferente de null, lo asignamos a la variable _user
        _user = user;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registro de usuario'),
      ),
      //Si el usuario es diferente de null, mostramos la información del usuario, en el caso contrario mostramos el botón de registro de google
      body:  //_user != null ? _userInfo() : _googleSignInButton()
      const Center(
        child: Text('Registro de usuario'),

      ),
    );
  }

  Widget _googleSignInButton() {
    return Center();
  }

  Widget _userInfo(){
    return SizedBox();
  }
}