import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:sprint/app_localizations.dart';
import 'package:sprint/data/odoo_connect.dart';
import 'package:sprint/model/language.dart';
import 'package:sprint/model/odoo-user.dart';
import 'package:sprint/utils/sprint_exceptions.dart';

Logger logger = Logger();

Future signUpWithEmailAndPassword(
    {required String name,
    required String email,
    required String password,
    required BuildContext context}) async {
  bool canRegistered = false;

  try {
    canRegistered = await _tryRegisterOnOdoo(name, email, password, context);
  } catch (e) {
    logger.e('Error: $e');
    rethrow;
  }

  if (canRegistered) {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      return true;
    } on FirebaseAuthException catch (e) {
      logger.e('FirebaseAuthException: ${e.code}\n${e.message}');
      if (e.code.contains('email-already-in-use')) {
        throw EmailAlreadyInUseException(context);
      } else {
        throw SprintException(context);
      }
    } catch (e) {
      logger.e('Error: $e');
      rethrow;
    }
  }
}

Future<bool> _tryRegisterOnOdoo(
    String name, String email, String password, BuildContext context) async {
  if (email.isEmpty) throw ValidationException(context);

  OdooUser? user = await getUserByEmail(email);

  if (user != null) throw EmailAlreadyInUseException(context);

  OdooUser newUser = OdooUser(
      email, password, true, name, Language.setLanguageByString('es_ES'));

  if (await OdooConnect.createUser(newUser)) return true;

  return false;
}

Future<OdooUser?> getUserByEmaik(String email) async {
  OdooUser? user = await OdooConnect.getUserByEmail(email);
  return user;
}

bool validatePasswordsMatch(String password, String passwordConfirm) {
  return password == passwordConfirm;
}

bool validatePasswordLengthAndWeak(String password) {
  if (password.length >= 6 &&
      password.contains(RegExp(r'[A-Z]')) &&
      password.contains(RegExp(r'[0-9]'))) {
    return true;
  }
  return false;
}

Future<bool> loginWithEmailAndPass({required String email, required String password, required BuildContext context}) async {
  OdooUser? user = await getUserByEmail(email);
  if(user == null) throw EmailValidator();
  try {
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    return true;
  } catch (e) {
    throw FirebaseAuthException(code: AppLocalizations.of(context)!.translate('userNotExist'));
  }
}

Future<OdooUser?> getUserByEmail(String email) {
  return OdooConnect.getUserByEmail(email);
}
