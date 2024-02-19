import 'package:flutter/cupertino.dart';
import 'package:sprint/app_localizations.dart';

class SprintException implements Exception {
  SprintException(BuildContext context) : message = AppLocalizations.of(context)!.translate('genericSprintError');

  final String message;

  @override
  String toString() => message;
}

class ValidationException implements Exception {
  ValidationException(BuildContext context) : message = AppLocalizations.of(context)!.translate('validationError');
  final String message;
  @override
  String toString() => message;
}

class PassWordLengthOrWeakException implements Exception {
  PassWordLengthOrWeakException(BuildContext context)
      : message = AppLocalizations.of(context)!.translate('passLengthOrWeak');
  final String message;
  @override
  String toString() => message;
}

class NetworkException implements Exception {
  NetworkException(BuildContext context) : message = AppLocalizations.of(context)!.translate('netError');
  final String message;
  @override
  String toString() => message;
}

class AuthenticationException implements Exception {
  AuthenticationException(BuildContext context) : message = AppLocalizations.of(context)!.translate('authError');
  final String message;
  @override
  String toString() => message;
}

class EmailAlreadyInUseException implements Exception {
  EmailAlreadyInUseException(BuildContext context)
      : message = AppLocalizations.of(context)!.translate('emailAlreadyInUse');
  final String message;
  @override
  String toString() => message;
}

class PasswordsDoNotMatchException implements Exception {
  PasswordsDoNotMatchException(BuildContext context)
      : message = AppLocalizations.of(context)!.translate('passesNotMatch');

  final String message;

  @override
  String toString() => message;
}

class EmailNotVerifiedException implements Exception {
  EmailNotVerifiedException(BuildContext context)
      : message = 'Your email has not been verified. Please verify your email.'; // TODO: Translate

  final String message;

  @override
  String toString() => message;
}

class EmailNotSentException implements Exception {
  EmailNotSentException(BuildContext context)
      : message = 'The email could not be sent. Please try again later.'; //TODO: Translate

  final String message;

  @override
  String toString() => message;
}