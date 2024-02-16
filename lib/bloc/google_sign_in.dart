import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sprint/data/odoo_connect.dart';
import 'package:sprint/model/user.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert';

import '../model/language.dart';

class GoogleSignInProvider extends ChangeNotifier{

  final googleSignIn = GoogleSignIn();

  //esta variable nos permitirá manejar la información y estado del usuario
  GoogleSignInAccount? _user;
  GoogleSignInAccount get user => _user!;

  Future googleLogin() async {

    //Vamos a esperar a que el usuario seleccione su cuenta de google
    final googleUser = await googleSignIn.signIn();
    //comprobamos que el usuario que seleccionó no sea nulo para poder asignarlo a la variable _user
    if(googleUser == null) return;
    _user = googleUser;

    final googleAuth = await googleUser.authentication;

    //Creamos las credenciales para poder autenticarnos con firebase
    final credential = auth.GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken
    );

    //Autenticamos al usuario con firebase pasando le las credenciales del usuario
    await auth.FirebaseAuth.instance.signInWithCredential(credential);
    //Notificamos a los oyentes que el usuario ha cambiado
    notifyListeners();

    print(_user?.email);

    //Comprobamos si el usuario ya existe en la base de datos para saber si lo tenemos que registrar o iniciar sesión
    if(comprobarInicioSesion(_user?.email)){
      print("El usuario ya existe");
    }else{
      //llamamos al metodo que nos va a permitir crear un usuario en la base de datos
      //pasandole el usuario que nos devuelve el metodo que parsea la informacion del usuario de google
      OdooConnect.createUser(crearUsuario(crearUsuario(_user)));
    }
  }

  /**
   * Este metodo nos va a permitir parsear la información del usuario de google
   * a un objeto usuario para poder manejarlo
   * @param usuario es el usuario de google
   */
  User crearUsuario(usuario){

    //Encriptamos el id del usuario
    var bytes = utf8.encode(usuario.id.toString());
    var idEncriptado = sha256.convert(bytes);

    //Creamos el usuario con la información que nos devuelve el usuario de google
    User user = User(usuario.email, idEncriptado.toString(), false, usuario.displayName, Language.esES);

    return user;
  }

  /**
   * Este metodo nos va a permitir comprobar si el usuario ya existe en la base de datos
   * para saber si lo tenemos que registrar o iniciar sesión
   * @param emailUser es el email del usuario
   */
  bool comprobarInicioSesion(emailUser){
    bool inicioSesion = true;
    var user;
    user = OdooConnect.getUserByEmail(emailUser);

    //Si el usuario es nulo significa que no existe en la base de datos
    if(user == null){
      inicioSesion = false;
    }

    return inicioSesion;
  }

  /**
   * Este metodo nos va a permitir cerrar sesión
   */
  Future logout() async {
    await googleSignIn.disconnect();
    auth.FirebaseAuth.instance.signOut();
  }
}