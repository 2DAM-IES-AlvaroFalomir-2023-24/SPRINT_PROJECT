// Contiene los estados de la app
//
// Los estados vendrían a ser los valores de los atributos que podemos "escuchar"
// desde el resto de la app.
//
// En este caso tenemos un contador con un estado incial de 0.
// El UpdateState representa el estado actualizado, donde el contador se ha incrementado

import '../model/language.dart';
import '../model/user.dart';

class UserStates {}

class InitialState extends UserStates {}

class UpdateState extends UserStates {
  final int counter;
  final User user;
  UpdateState(this.counter, this.user);
}
