import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

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
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken
    );

    //Autenticamos al usuario con firebase pasando le las credenciales del usuario
    await FirebaseAuth.instance.signInWithCredential(credential);
    //Notificamos a los oyentes que el usuario ha cambiado
    notifyListeners();
  }
}