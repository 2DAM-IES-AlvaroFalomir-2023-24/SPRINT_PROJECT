class SprintException implements Exception {
  const SprintException() : message = 'Generic Error de Sprint';

  final String message;

  @override
  String toString() => message;
}

class ValidationException implements Exception {
  const ValidationException() : message = 'Error de validación';
  final String message;
  @override
  String toString() => message;
}

class PassWordLengthOrWeakException implements Exception {
  const PassWordLengthOrWeakException()
      : message =
            'La contraseña debe tener al menos 6 caracteres, una letra mayúscula y un número.';
  final String message;
  @override
  String toString() => message;
}

class NetworkException implements Exception {
  const NetworkException() : message = 'Error de conexión a internet';
  final String message;
  @override
  String toString() => message;
}

class AuthenticationException implements Exception {
  const AuthenticationException() : message = 'Error de autenticación';
  final String message;
  @override
  String toString() => message;
}

class EmailAlreadyInUseException implements Exception {
  const EmailAlreadyInUseException()
      : message = 'El correo electrónico ya está en uso por otra cuenta.';
  final String message;
  @override
  String toString() => message;
}

class PasswordsDoNotMatchException implements Exception {
  const PasswordsDoNotMatchException()
      : message = 'Las contraseñas no coinciden.';

  final String message;

  @override
  String toString() => message;
}
