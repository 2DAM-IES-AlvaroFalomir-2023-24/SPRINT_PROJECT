import 'package:cloud_functions/cloud_functions.dart';
import 'package:sprint/bloc/bloc_user/user_event.dart';
import 'package:sprint/bloc/bloc_user/user_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sprint/data/odoo_connect.dart';
import 'package:sprint/model/language.dart';
import 'package:sprint/model/odoo-user.dart';

class UserBloc extends Bloc<UserEvents, UserStates> {
  int counter = 0;
  OdooUser user = OdooUser("email", "password", false, "name", Language.esES);  // Estado inicial del usuario. Este es el usuario que almacena toda la información dentro de la app

  UserBloc() : super(InitialState()) {
    on<UserInformationChangedEvent>(onUserInformationChanged);
    on<UserDeleteRequested>(onUserDeleteRequested);
    // on<UserCancellationRequested>(onUserCancellationRequested);
  }

  void onUserInformationChanged(
    UserInformationChangedEvent event, Emitter<UserStates> emit) async {
    // Pillamos el user que se ha creado con el constructor en el evento.
    user = event.user;
    emit(UpdateState(user));
  }

  // void onUserCancellationRequested(UserCancellationRequested event, Emitter<UserStates> emit) async {
  //   try {
  //     // Lógica para revertir la baja del usuario
  //     // bool cancellationSuccess = await _revertUserDeletion(event.userEmail);
  //     if (cancellationSuccess) {
  //       emit(UserCancellationSuccess());
  //     } else {
  //       emit(UserCancellationFailure());
  //     }
  //   } catch (e) {
  //     emit(UserCancellationFailure());
  //   }
  // }
  // Método para revertir la baja del usuario
  // Future<bool> _revertUserDeletion(String userEmail) async {
  //   try {
  //     // Obtener la información del usuario
  //     var user = await OdooConnect.getUserByEmail(userEmail);
  //
  //     // Verificar si el usuario está dentro del período de gracia
  //     if (user != null && user.deletionRequestDate != null) {
  //       var hoursSinceDeletionRequest = DateTime.now().difference(user.deletionRequestDate!).inHours;
  //       if (hoursSinceDeletionRequest > 24) {
  //         // Fuera del período de gracia
  //         return false;
  //       }
  //     }
  //     // Reactivar el usuario en Odoo
  //     // user?.isDeletionRequested = false;
  //     // user?.deletionRequestDate = null; // o cualquier otro manejo que desees
  //     bool updateSuccess = await OdooConnect.modifyUser(user!);
  //
  //     return updateSuccess;
  //   } catch (e) {
  //     print("Error al revertir la baja del usuario: $e");
  //     return false;
  //   }
  // }

  void onUserDeleteRequested(UserDeleteRequested event, Emitter<UserStates> emit) async {
    try {
      // Marcar el usuario como pendiente de eliminación y guardar la fecha de solicitud
      // user.isDeletionRequested = true;
      // user.deletionRequestDate = DateTime.now();
      bool updateSuccess = await OdooConnect.modifyUser(user);
      if (updateSuccess) {
        // Enviar correo de confirmación
        await _sendDeletionConfirmationEmail(user.email);
        emit(UserDeleteSuccess());
      } else {
        emit(UserDeleteFailure());
      }
    } catch (e) {
      emit(UserDeleteFailure());
    }
  }

  Future<void> _sendDeletionConfirmationEmail(String userEmail) async {
    HttpsCallable callable = FirebaseFunctions.instance.httpsCallable('sendUserDeletionEmail');
    try {
      await callable.call(<String, dynamic>{'email': userEmail});
      _modifyUserInOdoo(userEmail);
    } catch (e) {
      print('Error al enviar correo de confirmación: $e');
    }
  }

  Future<bool> _modifyUserInOdoo(String email) async {
    try {
      OdooUser? temp = await OdooConnect.getUserByEmail(email);
      if(temp != null){
        return await OdooConnect.deactivateUser(temp);
      }else{
        throw Exception();
      }
    } catch (e) {
      print("Error al modificar el usuario en Odoo: $e");
      return false;
    }
  }

}