import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sprint/bloc/bloc_user/user_bloc.dart';
import 'package:sprint/bloc/bloc_user/user_state.dart';
import 'package:sprint/model/odoo-user.dart';
import 'package:sprint/repository/login_repo.dart';

// Eventos
abstract class LoginEvent {}

class SendLoginLinkEvent extends LoginEvent {
  final String email;
  SendLoginLinkEvent(this.email);
}

class UserLoggedInEvent extends LoginEvent {
  final OdooUser user;
  UserLoggedInEvent(this.user);
}

class CheckLoginStatusEvent extends LoginEvent {}


// Estados
abstract class LoginState {}

class LoginInitial extends LoginState {}
class LoginLoading extends LoginState {}
class LoginSuccess extends LoginState {
  final OdooUser user;
  LoginSuccess(this.user);
}
class LoginFailure extends LoginState {
  final String error;
  LoginFailure(this.error);
}

// BLoC
class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRepository _authRepository;
  final UserBloc _userBloc;

  LoginBloc(this._authRepository, this._userBloc) : super(LoginInitial()) {
    on<SendLoginLinkEvent>(_onSendLoginLink);
    on<UserLoggedInEvent>(_onUserLoggedIn);
  }

  Future<void> _onSendLoginLink(SendLoginLinkEvent event, Emitter<LoginState> emit) async {
    emit(LoginLoading());
    try {
      await _authRepository.sendLoginLinkToEmail(event.email, _userBloc);
    } catch (e) {
      emit(LoginFailure(e.toString()));
    }
  }

  Future<void> _onUserLoggedIn(UserLoggedInEvent event, Emitter<LoginState> emit) async {
    try{
      final OdooUser user = event.user;
      emit(LoginSuccess(user));
    }catch (e){
      emit(LoginFailure('Error: Usuario no ha iniciado sesión correctamente.'));
    }
  }
}