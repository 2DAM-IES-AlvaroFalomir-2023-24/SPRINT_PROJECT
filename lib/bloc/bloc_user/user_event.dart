// Contiene los eventos que pueden dispararse desde la aplicación
//
// La lógica para estos eventos se define en la clase UserBloc

import 'package:sprint/bloc/bloc_user/user_state.dart';

import '../../model/odoo-user.dart';

class UserEvents {}
// Define un nuevo evento para la solicitud de eliminación de usuario
class UserDeleteRequested extends UserEvents {}
// Define un nuevo evento para la actualización de la información del usuario
class UserCancellationSuccess extends UserStates {}
class UserCancellationFailure extends UserStates {}

// Define un nuevo evento para la actualización de la información del usuario
class UserInformationChangedEvent extends UserEvents {
  OdooUser user;
  UserInformationChangedEvent(this.user);
}
// Define un nuevo evento para la solicitud de cancelación de usuario
class UserCancellationRequested extends UserEvents {
  final String userEmail;
  UserCancellationRequested(this.userEmail);
}
