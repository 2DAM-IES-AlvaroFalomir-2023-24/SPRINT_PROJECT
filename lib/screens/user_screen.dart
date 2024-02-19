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
import 'package:sprint/widget/custom_elevated_button_iconified.dart';

import 'login_screen.dart';

Logger logger = Logger();

class UserScreen extends StatefulWidget {
  const UserScreen({super.key, this.isEditable = false});

  final bool isEditable;

  @override
  State<StatefulWidget> createState() => UserScreenState();
}

class UserScreenState extends State<UserScreen> {
  bool editable = false;
  bool _passwordVisible = false;
  ImageProvider? userCustomAvatar;
  String userCustomAvatarEncoded = "";
  IconData fabIcon = Icons.edit;


  @override
  void initState() {
    super.initState();
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
    if(user.avatar.isNotEmpty && userCustomAvatarEncoded.isEmpty){
      userCustomAvatarEncoded = user.avatar;
      userCustomAvatar = MemoryImage(base64Decode(userCustomAvatarEncoded));
    }

    return Scaffold(
        // TODO ajustar el comportamiento por defecto al pulsar en un elemento editable
        appBar: AppBar(
          backgroundColor: Theme.of(context).focusColor,
          title: Text(AppLocalizations.of(context)!.translate("userProfile")),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.miniEndTop,
        // Botones para la edición de usuario
        floatingActionButton: Row(mainAxisAlignment: MainAxisAlignment.end,
          children: [
            if (editable)
              // Botón de cancelar que sólo aparece en modo edición
              FloatingActionButton(
                child: const Icon(Icons.close),
                onPressed: () {
                  setState(() {
                    // Salimos del modo edición, cambiamos el icono y devolvemos al bloc el usuario antes de los cambios
                    editable = !editable;
                    fabIcon = Icons.edit;
                    context
                        .read<UserBloc>()
                        .add(UserInformationChangedEvent(previousUser));
                  });
                },
              ),
            const SizedBox(width: 10),
            // Aceptamos los cambios guardando el usuario en el bloc y subimos los cambios a Odoo
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
                      userCustomAvatarEncoded,
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
                              foregroundImage: userCustomAvatar,
                              backgroundImage: const AssetImage('assets/user_default_avatar.png'),
                              radius: 100,
                            ),
                          ),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: FloatingActionButton(
                                onPressed: () async {
                                  // Cargamos el avatar y lo codificamos en base64
                                  if(editable){
                                    XFile? file = await ImagePicker().pickImage(
                                        source: ImageSource.gallery);
                                    if(file != null){
                                      File temp = File(file.path);
                                      setState(() {
                                        userCustomAvatarEncoded = base64Encode(temp.readAsBytesSync());
                                        userCustomAvatar = MemoryImage(base64Decode(userCustomAvatarEncoded));
                                      });
                                    }
                                  }else{
                                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Edit mode is disabled")));//TODO - translate
                                  }
                                },
                                child: const Icon(Icons.photo)
                            ),
                          )
                        ],
                      )
                    ),
                    // Organizamos los atributos del usuario en otro Column para poder añadir un spaceBetween entre ellso y el resto de elementos agrupados de la interfaz
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
                          obscureText: !_passwordVisible,
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
                          keyboardType: TextInputType.phone,
                        ),
                      ],
                    ),
                    const  SizedBox(height: 20),
                    // Agrupamos los botones de cerrar sesión, cambiar y borrar usuario para poder añadir el spacebetween de forma correcta
                    Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        CustomElevatedButtonIconified(
                            icon: const Icon(Icons.logout),
                            onPressedFunction: (){
                              //TODO Llamar a la función de Cerrar sesión (Alexandra)
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => const LoginScreen()));
                            },
                            hintText: AppLocalizations.of(context)!.translate("logout")
                        ),
                        CustomElevatedButtonIconified(
                            icon: const Icon(Icons.change_circle),
                            onPressedFunction: (){
                              // TODO Llamar a la función de Cambiar Usuario (Laura)
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return UserListDialog();
                                },
                              );
                            },
                            hintText: AppLocalizations.of(context)!.translate("switchUser")
                        ),
                        CustomElevatedButtonIconified(
                          icon: const Icon(Icons.delete),
                          onPressedFunction: (){
                              // TODO Llamar a la función de Borrar Usuario (Rubén)
                          },
                          hintText: AppLocalizations.of(context)!.translate("deleteUser"),
                          color: Colors.red,
                        )
                      ],
                    ),
                  ],
                )),
          ),
        ));
  }

  // Para implementar correctamente el patrón bloc rodeamos toda la clase _UserScreen con un BlocBuilder
  // Con esto conseguimos que los datos del usuario estén disponibles en el contexto completo de la clase.
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserStates>(builder: (context, state) {
      if (state is InitialState) {
        OdooUser user = OdooUser("USER_EMAIL", "USER_PASS", false, "USER_NAME",Language.esES, null, "");
        return _UserScreen(context, user);
      }
      if (state is UpdateState) {
        return _UserScreen(context, state.user);
      }
      return Container();
    });
  }
}
class UserListDialog extends StatefulWidget {
  @override
  _UserListDialogState createState() => _UserListDialogState();
}

class _UserListDialogState extends State<UserListDialog> {
  String? selectedUser; // Estado para almacenar el usuario seleccionado

  final List<String> users = ['user1', 'user2', 'user3', 'user4', 'user5', 'user6'];

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Lista de Usuarios'),
      content: Container(
        width: double.maxFinite,
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: users.length,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              title: Text(users[index]),
              onTap: () {
                setState(() {
                  // Actualizar el usuario seleccionado cuando se hace clic en un usuario de la lista
                  selectedUser = users[index];
                });
              },
            );
          },
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Cerrar'),
        ),
      ],
    );
  }
}
