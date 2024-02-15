import 'package:sprint/bloc_user/user_event.dart';
import 'package:sprint/bloc_user/user_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sprint/model/language.dart';
import 'package:sprint/model/user.dart';

    // Contiene la lógica de negocio del Bloc.
    //
    // Se encarga de gestionar los eventos lanzados por el usuario y
    // de actualizar los estados acorde a estos eventos.
    //
    // Esta clase escucha a los eventos NumberIncreaseEvent y NumberDecreaseEvent,
    // actualiza los valores del contador y emite un UpdateState con el nuevo valor
    // del contador


class UserBloc extends Bloc<UserEvents, UserStates> {
  int counter = 0;
  User user = User("email", "password", false, "name", Language.esES);  // Estado inicial del usuario. Este es el usuario que almacena toda la información dentro de la app

  UserBloc() : super(InitialState()) {
    on<UserInformationChangedEvent>(onUserInformationChanged);

    on<NumberIncreaseEvent>(onNumberIncrease);
    on<NumberDecreaseEvent>(onNumberDecrease);
  }

  void onUserInformationChanged(
    UserInformationChangedEvent event, Emitter<UserStates> emit) async {
    // Pillamos el user que se ha creado con el constructor en el evento.
    user = event.user;
    emit(UpdateState(counter, user));
  }

  void onNumberIncrease(
      NumberIncreaseEvent event, Emitter<UserStates> emit) async {
    counter = counter + event.incremento;
    emit(UpdateState(counter, user));
  }

  void onNumberDecrease(
      NumberDecreaseEvent event, Emitter<UserStates> emit) async {
    counter = counter - 1;
    emit(UpdateState(counter, user));
  }
}