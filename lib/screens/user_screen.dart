import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';
import 'package:sprint/app_localizations.dart';
import 'package:sprint/bloc/bloc_user/user_bloc.dart';
import 'package:sprint/bloc/bloc_user/user_event.dart';
import 'package:sprint/bloc/bloc_user/user_state.dart';
import 'package:sprint/model/odoo-user.dart';
import 'package:sprint/model/language.dart';

Logger logger = Logger();

class UserScreen extends StatefulWidget {
  const UserScreen({super.key, this.isEditable = false});

  final bool isEditable;

  // Guardamos un avatar predefinido en base64
  final String userDefaultAvatar =
      "iVBORw0KGgoAAAANSUhEUgAAAIAAAACACAYAAADDPmHLAAAEt2lUWHRYTUw6Y29tLmFkb2JlLnhtcAAAAAAAPD94cGFja2V0IGJlZ2luPSLvu78iIGlkPSJXNU0wTXBDZWhpSHpyZVN6TlRjemtjOWQiPz4KPHg6eG1wbWV0YSB4bWxuczp4PSJhZG9iZTpuczptZXRhLyIgeDp4bXB0az0iWE1QIENvcmUgNS41LjAiPgogPHJkZjpSREYgeG1sbnM6cmRmPSJodHRwOi8vd3d3LnczLm9yZy8xOTk5LzAyLzIyLXJkZi1zeW50YXgtbnMjIj4KICA8cmRmOkRlc2NyaXB0aW9uIHJkZjphYm91dD0iIgogICAgeG1sbnM6ZXhpZj0iaHR0cDovL25zLmFkb2JlLmNvbS9leGlmLzEuMC8iCiAgICB4bWxuczp0aWZmPSJodHRwOi8vbnMuYWRvYmUuY29tL3RpZmYvMS4wLyIKICAgIHhtbG5zOnBob3Rvc2hvcD0iaHR0cDovL25zLmFkb2JlLmNvbS9waG90b3Nob3AvMS4wLyIKICAgIHhtbG5zOnhtcD0iaHR0cDovL25zLmFkb2JlLmNvbS94YXAvMS4wLyIKICAgIHhtbG5zOnhtcE1NPSJodHRwOi8vbnMuYWRvYmUuY29tL3hhcC8xLjAvbW0vIgogICAgeG1sbnM6c3RFdnQ9Imh0dHA6Ly9ucy5hZG9iZS5jb20veGFwLzEuMC9zVHlwZS9SZXNvdXJjZUV2ZW50IyIKICAgZXhpZjpQaXhlbFhEaW1lbnNpb249IjEyOCIKICAgZXhpZjpQaXhlbFlEaW1lbnNpb249IjEyOCIKICAgZXhpZjpDb2xvclNwYWNlPSIxIgogICB0aWZmOkltYWdlV2lkdGg9IjEyOCIKICAgdGlmZjpJbWFnZUxlbmd0aD0iMTI4IgogICB0aWZmOlJlc29sdXRpb25Vbml0PSIyIgogICB0aWZmOlhSZXNvbHV0aW9uPSI3Mi8xIgogICB0aWZmOllSZXNvbHV0aW9uPSI3Mi8xIgogICBwaG90b3Nob3A6Q29sb3JNb2RlPSIzIgogICBwaG90b3Nob3A6SUNDUHJvZmlsZT0ic1JHQiBJRUM2MTk2Ni0yLjEiCiAgIHhtcDpNb2RpZnlEYXRlPSIyMDI0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";


  @override
  State<StatefulWidget> createState() => UserScreenState();
}

class UserScreenState extends State<UserScreen> {
  bool editable = false;
  bool _passwordVisible = false;
  String image = "";
  IconData fabIcon = Icons.edit;


  @override
  void initState() {
    super.initState();
    image = widget.userDefaultAvatar;
    editable = widget.isEditable;
    fabIcon = editable ? Icons.save : Icons.edit;
  }

  Widget _UserScreen(BuildContext context, OdooUser user) {
    // Al arrancar la escena guardamos una copia del usuario para poder
    // volver atrás en el modo edición
    OdooUser previousUser = user;

    // Controladores para los TextFormField.
    TextEditingController _nameTextFormField =
        TextEditingController(text: user.name);
    TextEditingController _passwordTextFormField =
        TextEditingController(text: user.password);
    TextEditingController _emailTextFormField =
        TextEditingController(text: user.email);
    TextEditingController _languageTextFormField =
        TextEditingController(text: user.lang.toString());
    TextEditingController _phoneTextFormField =
      TextEditingController(text: user.phone.toString());
    //Si cargo la imagen el funcionamiento de edición es raro
    //image = user.avatar.toString();

    return Scaffold(
        // TODO ajustar el comportamiento por defecto al pulsar en un elemento editable
        appBar: AppBar(
          backgroundColor: Theme.of(context).focusColor,
          title: Text(AppLocalizations.of(context)!.translate("userProfile")),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.miniEndTop,
        floatingActionButton: Row(mainAxisAlignment: MainAxisAlignment.end,
          children: [
            if (editable)
              // Botón de cancelar edición que sólo aparece en modo edición
              FloatingActionButton(
                child: const Icon(Icons.close),
                onPressed: () {
                  setState(() {
                    // Salimos del modo edición, cambiamos el icono y regresamos al usuario que habíamos guardado
                    editable = !editable;
                    fabIcon = Icons.edit;
                    context
                        .read<UserBloc>()
                        .add(UserInformationChangedEvent(previousUser));
                  });
                },
              ),
            const SizedBox(width: 10),
            // Botón de edición y guardado del usuario.
            FloatingActionButton(
              child: Icon(fabIcon),
              onPressed: () {
                if (editable) {
                  context.read<UserBloc>().add(UserInformationChangedEvent(OdooUser(
                      _emailTextFormField.text,
                      _passwordTextFormField.text,
                      true,
                      _nameTextFormField.text,
                      Language
                          .enUS,
                      user.id,
                      image,
                      _phoneTextFormField.text))); // TODO cuando implementemos el spinner, recoger el valor seleccionado
                }
                //OdooConnect.modifyUser(context.read<UserBloc>().user);
                setState(() {
                  editable = !editable;
                  fabIcon = editable ? Icons.save : Icons.edit;
                });
              },
            ),
          ],
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 40,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      width: 200,
                      height: 200,
                      child: Stack(
                        children: [
                          Container(
                            alignment: Alignment.center,
                            child: CircleAvatar(
                              // TODO Cargar el avatar del usuario al pulsar si esta en modo edicion
                              backgroundImage: MemoryImage(base64Decode(image)),
                              radius: 100,
                            ),
                          ),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: FloatingActionButton(
                                onPressed: () async {
                                  if(editable){
                                    XFile? file = await ImagePicker().pickImage(
                                        source: ImageSource.gallery,
                                        maxWidth: 1920,
                                        maxHeight: 1200,
                                        imageQuality: 80);
                                    if(file != null){
                                      File temp = File(file.path);
                                      setState(() {
                                        final imageEncoded = base64Encode(temp.readAsBytesSync());
                                        image = imageEncoded;
                                      });
                                    }
                                  }else{
                                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Edit mode is disabled")));
                                  }
                                },
                                child: const Icon(Icons.photo)
                            ),
                          )
                        ],
                      )
                    ),
                    Column(
                      children: [
                        // NOMBRE DE USUARIO
                        TextFormField(
                          controller: _nameTextFormField,
                          decoration:
                              InputDecoration(labelText: AppLocalizations.of(context)!.translate("username")),
                          enabled: editable,
                        ),
                        // PASSWORD DE USUARIO
                        TextFormField(
                          controller: _passwordTextFormField,
                          decoration: InputDecoration(
                              labelText: AppLocalizations.of(context)!.translate("password"),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _passwordVisible ?
                                      Icons.visibility :
                                      Icons.visibility_off,
                                  color: Theme.of(context).primaryColorLight,
                                ),
                                onPressed: (){
                                  setState(() {
                                    _passwordVisible = !_passwordVisible;
                                  });
                                },
                              )
                          ),
                          obscureText: _passwordVisible,
                          enabled: editable,
                        ),
                        // EMAIL DE USUARIO
                        TextFormField(
                          controller: _emailTextFormField,
                          decoration:
                              InputDecoration(labelText: AppLocalizations.of(context)!.translate("email")),
                          enabled: editable,
                        ),
                        // IDIOMA DE USUARIO
                        // TODO Custom Spinner
                        TextFormField(
                          controller: _languageTextFormField,
                          decoration: InputDecoration(
                              labelText: AppLocalizations.of(context)!.translate("switchLanguage")),
                          enabled: editable,
                        ),
                        TextFormField(
                          controller: _phoneTextFormField,
                          decoration: InputDecoration(
                              labelText: AppLocalizations.of(context)!.translate("phoneInput")),
                          enabled: editable,
                        ),
                      ],
                    ),
                    SizedBox(height: 20,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        ElevatedButton(
                            child: Text(AppLocalizations.of(context)!.translate("logout")),
                            onPressed: () {
                              // TODO Llamar a la función de Cerrar sesión (Alexandra)
                            }),
                        ElevatedButton(
                            child: Text(AppLocalizations.of(context)!.translate("switchUser")),
                            onPressed: () {
                              // TODO Llamar a la función de Cambiar Usuario (Laura)
                            }),
                        ElevatedButton(
                            // TODO Falta cambiar el fondo del botón a rojo. Mirar como hacerlo global con el tema
                            child: Text(AppLocalizations.of(context)!.translate("deleteUser")),
                            onPressed: () {
                              // TODO Llamar a la función de Borrar Usuario (Rubén)
                            }),
                      ],
                    ),
                  ],
                )),
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserStates>(builder: (context, state) {
      if (state is InitialState) {
        OdooUser user = OdooUser("USER_EMAIL", "USER_PASS", false, "USER_NAME",
            Language.esES, null, widget.userDefaultAvatar);
        return _UserScreen(context, user);
      }
      if (state is UpdateState) {
        return _UserScreen(context, state.user);
      }
      return Container();
    });
  }
}
