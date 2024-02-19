import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:sprint/data/odoo_connect.dart';
import 'package:sprint/model/language.dart';
import 'package:sprint/model/odoo-user.dart' as user_odoo;
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

  user_odoo.OdooUser? user = await OdooConnect.getUserByEmail(email);

  if (user != null) throw EmailAlreadyInUseException(context);

  user_odoo.OdooUser newUser = user_odoo.OdooUser(
      email, password, true, name, Language.setLanguageByString('es_ES'));

  if (await OdooConnect.createUser(newUser)) return true;

  return false;
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
