import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc_user/user_bloc.dart';
import '../bloc_user/user_state.dart';
import '../model/language.dart';
import '../model/user.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({super.key});

  final String userNameLabel = "Nombre";
  final String userNameValue = "Nombre";

  final String userPasswordLabel = "Contraseña";
  final String userPasswordValue = "Contraseña oculta";

  final String userEmailLabel = "Email (Login)";
  final String userEmailValue = "Email";

  final String userLanguageLabel = "Idioma";

  final String userLogoutLabel = "Cerrar sesión";
  final String userChangeUserLabel = "Cambiar Usuario";
  final String userDeleteUserLabel = "Borrar Usuario";

  @override
  State<StatefulWidget> createState() => UserScreenState();
}

class UserScreenState extends State<UserScreen> {
  bool editable = false;

  Widget _UserScreen(BuildContext context, int counter, User user) {
    return SingleChildScrollView(
        child: Padding(
            padding: EdgeInsets.all(40),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const CircleAvatar(
                  // TODO Cargar el avatar del usuario al pulsar si esta en modo edicion
                  child: Icon(Icons.photo_camera_outlined, size: 80),
                  radius: 100,
                ),
                Column(
                  children: [
                    // NOMBRE DE USUARIO
                    TextFormField(
                      initialValue: user.name,
                      decoration:
                          InputDecoration(labelText: widget.userNameValue),
                      enabled: editable,
                    ),
                    // PASSWORD DE USUARIO
                    TextFormField(
                      initialValue: user.password,
                      decoration:
                          InputDecoration(labelText: widget.userPasswordLabel),
                      obscureText: true,
                      enabled: editable,
                    ),
                    // EMAIL DE USUARIO
                    TextFormField(
                      initialValue: user.email,
                      decoration:
                          InputDecoration(labelText: widget.userEmailLabel),
                      enabled: editable,
                    ),
                    // IDIOMA DE USUARIO
                    // TODO Custom Spinner

                    TextFormField(
                      initialValue: "Idioma",
                      decoration: const InputDecoration(labelText: "Idioma"),
                      enabled: editable,
                    ),
                  ],
                ),
                Column(
                  children: [
                    ElevatedButton(
                        child: Text(widget.userLogoutLabel),
                        onPressed: () {
                          // TODO Llamar a la función de Cerrar sesión (Alexandra)
                        }),
                    ElevatedButton(
                        child: Text(widget.userChangeUserLabel),
                        onPressed: () {
                          // TODO Llamar a la función de Cambiar Usuario (Laura)
                        }),
                    ElevatedButton(
                        // TODO Falta cambiar el fondo del botón a rojo. Mirar como hacerlo global con el tema
                        child: Text(widget.userDeleteUserLabel),
                        onPressed: () {
                          // TODO Llamar a la función de Borrar Usuario (Rubén)
                        }),
                  ],
                ),
              ],
            )));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // TODO ajustar el comportamiento por defecto al pulsar en un elemento editable
        appBar: AppBar(),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.edit),
          onPressed: () {
            setState(() {
              editable = !editable;
            });
            // TODO Editar el usuario.
            // TODO Utilizar el propio botón como botón para guardar los cambios
            // TODO ¿Añadir un segundo botón para cancelar?
          },
        ),
        body: BlocBuilder<UserBloc, UserStates>(builder: (context, state) {
          if (state is InitialState) {
            User user = User(
                "USER_EMAIL", "USER_PASS", false, "USER_NAME", Language.esES);
            return _UserScreen(context, 0, user);
          }
          if (state is UpdateState) {
            return _UserScreen(context, state.counter, state.user);
          }
          return Container();
        }));
  }
}
