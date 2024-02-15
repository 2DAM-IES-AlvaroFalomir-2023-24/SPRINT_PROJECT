// Contiene los eventos que pueden dispararse desde la aplicación
//
// La lógica para estos eventos se define en la clase UserBloc

import '../model/user.dart';

class UserEvents {}

class UserInformationChangedEvent extends UserEvents {
  User user;
  UserInformationChangedEvent(this.user);
}

class NumberIncreaseEvent extends UserEvents {
  int incremento;
  NumberIncreaseEvent(this.incremento);
}

class NumberDecreaseEvent extends UserEvents {}
