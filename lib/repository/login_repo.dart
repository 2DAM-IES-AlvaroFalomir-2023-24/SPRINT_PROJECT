import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:sprint/bloc/bloc_user/user_bloc.dart';
import 'package:sprint/bloc/bloc_user/user_event.dart';
import 'package:sprint/bloc/login_bloc.dart';
import 'package:sprint/model/odoo-user.dart';
import '../data/odoo_connect.dart';


class AuthRepository {
  final auth.FirebaseAuth _auth = auth.FirebaseAuth.instance;

  Future<OdooUser> getUserByEmail(String email) async {
    OdooUser? odooUser = await OdooConnect.getUserByEmail(email);

    if (odooUser != null) {
      return odooUser;
    } else {
      // Puedes manejar el caso de usuario no encontrado lanzando una excepción o devolviendo un valor predeterminado
      throw Exception('Usuario no encontrado en Odoo');
    }
  }

  Future<void> sendLoginLinkToEmail(String email, UserBloc userBloc) async {
    try {
      final OdooUser odooUser = await getUserByEmail(email);

      final auth.ActionCodeSettings actionCodeSettings = auth.ActionCodeSettings(
        url: 'https://sprintproject.page.link/tobR',
        handleCodeInApp: true,
        iOSBundleId: 'com.example.ios',
        androidPackageName: 'com.example.android',
        androidInstallApp: true,
        androidMinimumVersion: '12',
      );

      await _auth.sendSignInLinkToEmail(
        email: email,
        actionCodeSettings: actionCodeSettings,
      );

      // Notificar al UserBloc solo después de una autenticación exitosa
      await _auth.authStateChanges().firstWhere((user) => user != null);

      userBloc.add(UserLoggedInEvent(odooUser) as UserEvents);
    } catch (e) {
      // Manejar errores y notificar al UserBloc si es necesario
    }
  }

    auth.User? getCurrentUser() {
    return _auth.currentUser;
    }

}