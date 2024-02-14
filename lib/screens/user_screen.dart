import 'package:flutter/material.dart';

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

class UserScreenState extends State<UserScreen>{

  bool editable = false;

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
        body: SingleChildScrollView(
          // TODO centrar verticalmente de forma correcta. La barra inferior del sistema descentra visualmente los elementos
          //height: MediaQuery.of(context).size.height - MediaQuery.of(context).padding.bottom,
            child: Center(
              child: Padding(
                  padding: EdgeInsets.all(40),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const CircleAvatar(
                        // TODO Cargar el avatar del usuario al pulsar. Si no tiene uno, mostrar el icono
                        child: Icon(Icons.photo_camera_outlined, size: 80),
                        radius: 100,
                      ),
                      Column(
                        children: [
                          // NOMBRE DE USUARIO
                          TextFormField(
                            initialValue: widget.userNameLabel,
                            decoration: InputDecoration(
                                labelText: widget.userNameValue
                            ),
                            enabled: editable,
                          ),
                          // PASSWORD DE USUARIO
                          TextFormField(
                            initialValue: widget.userPasswordValue,
                            decoration: InputDecoration(
                                labelText: widget.userPasswordLabel
                            ),
                            obscureText: true,
                            enabled: editable,
                          ),
                          // EMAIL DE USUARIO
                          TextFormField(
                            initialValue: widget.userEmailValue,
                            decoration: InputDecoration(
                                labelText: widget.userEmailLabel
                            ),
                            enabled: editable,
                          ),
                          // IDIOMA DE USUARIO
                          // TODO Custom Spinner

                          TextFormField(
                            initialValue: "Idioma",
                            decoration: const InputDecoration(
                                labelText: "Idioma"
                            ),
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
                  )),
            )));
  }
}