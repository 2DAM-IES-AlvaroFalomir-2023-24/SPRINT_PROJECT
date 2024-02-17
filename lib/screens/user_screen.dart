import 'package:flutter/material.dart';

class UserScreen extends StatelessWidget {
  const UserScreen({super.key});

  final String userNameLabel = "Nombre";
  final String userNameValue = "NOMBRE_USUARIO";

  final String userPasswordLabel = "Contraseña";
  final String userPasswordValue = "CONTRASEÑA_USUARIO";

  final String userEmailLabel = "Email (Login)";
  final String userEmailValue = "EMAIL_USUARIO";

  final String userLanguageLabel = "Idioma";

  final String userLogoutLabel = "Cerrar sesión";
  final String userChangeUserLabel = "Cambiar Usuario";
  final String userDeleteUserLabel = "Borrar Usuario";

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
        body:Container(
          // TODO centrar verticalmente de forma correcta. La barra inferior del sistema descentra visualmente los elementos
        //height: MediaQuery.of(context).size.height - MediaQuery.of(context).padding.bottom,
            child: Center(
          child: Padding(
              padding: EdgeInsets.all(40),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CircleAvatar(
                    // TODO Cargar el avatar del usuario al pulsar. Si no tiene uno, mostrar el icono
                    child: Icon(Icons.photo_camera_outlined, size: 80),
                    radius: 100,
                  ),
                  Column(
                    children: [
                      // NOMBRE DE USUARIO
                      textFieldWithLabel(
                          label: userNameLabel, value: userNameValue),
                      // PASSWORD DE USUARIO
                      textFieldWithLabel(
                          label: userPasswordLabel, value: userPasswordValue),
                      // EMAIL DE USUARIO
                      textFieldWithLabel(
                          label: userEmailLabel, value: userEmailValue),
                      // IDIOMA DE USUARIO
                      // TODO Custom Spinner
                      textFieldWithLabel(
                          label: "Idioma", value: "IDIOMA_USUARIO"),
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
        )));
  }
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
