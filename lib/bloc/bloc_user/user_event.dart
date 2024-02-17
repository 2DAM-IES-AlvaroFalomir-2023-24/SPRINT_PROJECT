// Contiene los eventos que pueden dispararse desde la aplicación
//
// La lógica para estos eventos se define en la clase UserBloc

import '../../model/odoo-user.dart';

class UserEvents {}

class UserInformationChangedEvent extends UserEvents {
  OdooUser user;
  UserInformationChangedEvent(this.user);
}
