// Contiene los estados de la app
//
// Los estados vendrían a ser los valores de los atributos que podemos "escuchar"
// desde el resto de la app.
//
// En este caso tenemos un contador con un estado incial de 0.
// El UpdateState representa el estado actualizado, donde el contador se ha incrementado

import '../../model/odoo-user.dart';

class UserStates {}

// Define estados para el éxito o fracaso de la eliminación de usuario
class UserDeleteSuccess extends UserStates {}
class UserDeleteFailure extends UserStates {}

class InitialState extends UserStates {}

class UpdateState extends UserStates {
  final OdooUser user;
  UpdateState(this.user);
}
class UserLoggedInState extends UserStates {
  final OdooUser user;
  UserLoggedInState({required this.user});
}