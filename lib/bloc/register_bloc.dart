import 'package:firebase_auth/firebase_auth.dart';
import 'package:logger/logger.dart';
import 'package:sprint/utils/sprint_exceptions.dart';

Future signUpWithEmailAndPassword(
    {required String email,
    required String password,
    required String passwordConfirm}) async {
  Logger logger = Logger();
  if (!_validatePasswordsMatch(password, passwordConfirm)) {
    throw const PasswordsDoNotMatchException();
  }
  if (!_validatePasswordLengthAndWeak(password)) {
    throw const PassWordLengthOrWeakException();
  }

  try {
    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
    return true;
  } on FirebaseAuthException catch (e) {
    logger.e('FirebaseAuthException: ${e.code}\n${e.message}');
    if (e.message!.contains('auth/email-already-in-use')) {
      throw const EmailAlreadyInUseException();
    } else {
      throw const SprintException();
    }
  } catch (e) {
    logger.e('Error: $e');
    rethrow;
  }
}

bool _validatePasswordsMatch(String password, String passwordConfirm) {
  return password == passwordConfirm;
}

bool _validatePasswordLengthAndWeak(String password) {
  if (password.length >= 6 &&
      password.contains(RegExp(r'[A-Z]')) &&
      password.contains(RegExp(r'[0-9]'))) {
    return true;
  }
  return false;
}
