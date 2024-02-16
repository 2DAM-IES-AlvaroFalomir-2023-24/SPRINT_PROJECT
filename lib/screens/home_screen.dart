import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sprint/bloc/bloc_user/user_bloc.dart';
import 'package:sprint/bloc/bloc_user/user_state.dart';
import 'package:sprint/model/user.dart';
import 'package:sprint/screens/user_screen.dart';

import '../model/language.dart';
import 'login_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserStates>(builder: (context, state) {
      User user;
      if (state is UpdateState) {
        user = state.user;
      } else {
        user = User("Default", "password", false, "Default", Language.enUS);
      }

      return Scaffold(
        appBar: AppBar(
          title: Text('Home'),
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context),
          ),
          actions: <Widget>[
            PopupMenuButton<String>(
              onSelected: (String result) {
                if (result == 'Editar usuario') {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => UserScreen()),
                  );
                } else if (result == 'Cambiar de usuario') {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginScreen()),
                  );
                } else if (result == 'Cerrar sesión') {
                  //TODO Llamar a la función de Cerrar sesión (Alexandra)
                } else if(result == 'Idioma'){
                  //TODO Llamar a la función de Idioma (Pinto)
                } else if(result == 'Geolocalización') {
                  //TODO Llamar a la función de Geolocalización (Carol)
                }
              },
              itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                const PopupMenuItem<String>(
                  value: 'Editar usuario',
                  child: Text('Editar usuario'),
                ),
                const PopupMenuItem<String>(
                  value: 'Cambiar de usuario',
                  child: Text('Cambiar de usuario'),
                ),
                const PopupMenuItem<String>(
                  value: 'Cerrar sesión',
                  child: Text('Cerrar sesión'),
                ),
                const PopupMenuItem<String>(
                  value: 'Idioma',
                  child: Text('Idioma'),
                ),
                const PopupMenuItem<String>(
                  value: 'Geolocalización',
                  child: Text('Geolocalización'),
                ),
              ],
            ),
          ],
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                '¡Bienvenid@ ${user.name}!',
                style: TextStyle(fontSize: 24),
                // Ajusta el tamaño de la fuente según tus necesidades
                textAlign: TextAlign.center,
              ),
              const Text(
                'Estás en tu página de inicio.',
                textAlign: TextAlign.center,
              ),
              const Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Usa el menú', textAlign: TextAlign.center),
                    Icon(Icons.more_vert), // Icono del botón de desbordamiento
                    Text(
                      'en la parte superior derecha para mostrar las opciones de usuario.',
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
