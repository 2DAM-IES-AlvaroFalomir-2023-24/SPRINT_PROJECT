import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sprint/bloc_user/user_bloc.dart';
import 'package:sprint/bloc_user/user_event.dart';
import 'package:sprint/bloc_user/user_state.dart';

import '../data/odoo_connect.dart';
import '../model/language.dart';
import '../model/user.dart';

class UserScreen extends StatelessWidget {
  const UserScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        // TODO ajustar el comportamiento por defecto al pulsar en un elemento editable
        appBar: AppBar(),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.edit),
          onPressed: () {
            // TODO Editar el usuario.
            // TODO Utilizar el propio botón como botón para guardar los cambios
            // TODO ¿Añadir un segundo botón para cancelar?
          },
        ),

        // BlocBuilder para permitir que la UI se actualice ante cualquier cambio de estado
        body: BlocBuilder<UserBloc, UserStates>(builder: (context, state) {
          if (state is InitialState) {
            User user = User("EMAIL COSAS JAJA", "password", false, "name", Language.esES);
            return _UserScreen(context, 0, user);
          }
          if (state is UpdateState) {
            return _UserScreen(context, state.counter, state.user);
          }
          return Container();
        }));
  }
}

Widget _UserScreen(BuildContext context, int counter, User user) {
  final String userNameLabel = "Nombre";
  final String userNameValue = "NOMBRE_USUARIO";

  final String userPasswordLabel = "Contraseña";
  final String userPasswordValue = "CONTRASEÑA_USUARIO";

  final String userEmailLabel = "Email (Login)";
  final String userEmailValue = "EMAIL_USUARIO";

  final String userPhoneLabel = "Teléfono";
  final String userPhoneValue = "TELEFONO_USUARIO";

  final String userLanguageLabel = "Idioma";

  final String userLogoutLabel = "Cerrar sesión";
  final String userChangeUserLabel = "Cambiar Usuario";
  final String userDeleteUserLabel = "Borrar Usuario";

  // TODO centrar verticalmente de forma correcta. La barra inferior del sistema descentra visualmente los elementos
  //height: MediaQuery.of(context).size.height - MediaQuery.of(context).padding.bottom,
  return Center(
    child: Padding(
        padding: EdgeInsets.all(40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const CircleAvatar(
              // TODO Cargar el avatar del usuario al pulsar. Si no tiene uno, mostrar el icono
              child: Icon(Icons.photo_camera_outlined, size: 80),
              //Image.memory(base64Decode(source)), // Para decodificar la imagen que recibimos en base64
              radius: 100,
            ),

            //////////////////////////////
            // Prueba del BLOC con un contador
            ////////////////////////////////

            Row(
              children: [
                ElevatedButton(onPressed: () {
                  // Con add notificamos al Bloc que han habido cambios con el evento que le corresponda
                  // El funcionamiento de esta vaina: el evento puede tener un constructor al que le
                  // pasamos la información del evento. Al pulsar el botón le

                  User user = User("OLRAIT", "420", true, "ELAMIGOS", Language.enUS);
                  context.read<UserBloc>().add(UserInformationChangedEvent(user));

                }, child: Text("Se viene")),

                // Este text muestra el valor del counter del bloc
                Text(user.email.toString())
              ],
            ),

            Column(
              children: [
                // NOMBRE DE USUARIO
                textFieldWithLabel(label: userNameLabel, value: user.name),
                // PASSWORD DE USUARIO
                textFieldWithLabel(
                    label: userPasswordLabel, value: user.password),
                // EMAIL DE USUARIO
                textFieldWithLabel(
                    label: userEmailLabel, value: user.email),
                // EMAIL DE USUARIO
                textFieldWithLabel(
                    label: userPhoneLabel, value: "no tenemos telefono todavia jaja"),
                // IDIOMA DE USUARIO
                // TODO Custom Spinner
                textFieldWithLabel(label: "Idioma", value: "IDIOMA_USUARIO"),
              ],
            ),
            Column(
              children: [
                ElevatedButton(
                    child: Text(userLogoutLabel),
                    onPressed: () {
                      // TODO Llamar a la función de Cerrar sesión (Alexandra)
                    }),
                ElevatedButton(
                    child: Text(userChangeUserLabel),
                    onPressed: () {
                      // TODO Llamar a la función de Cambiar Usuario (Laura)
                    }),
                ElevatedButton(
                    // TODO Falta cambiar el fondo del botón a rojo. Mirar como hacerlo global con el tema
                    child: Text(userDeleteUserLabel),
                    onPressed: () {
                      // TODO Llamar a la función de Borrar Usuario (Rubén)
                    }),
              ],
            ),
          ],
        )),
  );
}

class textFieldWithLabel extends StatelessWidget {
  textFieldWithLabel({super.key, required this.label, required this.value});

  String label, value;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(vertical: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label),
            Container(
                width: 220,
                height: 45,
                child: TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: value,
                    filled: true,
                  ),
                ))
          ],
        ));
  }
}
