import 'package:another_flushbar/flushbar.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sprint/bloc/bloc_user/user_bloc.dart';
import 'package:sprint/bloc/bloc_user/user_state.dart';
import 'package:sprint/model/odoo-user.dart';
import 'package:sprint/screens/user_screen.dart';

import '../app_localizations.dart';
import '../bloc_location/location.dart';
import '../model/language.dart';
import 'login_screen.dart';
import 'package:provider/provider.dart';
import 'package:sprint/screens/register_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<StatefulWidget> createState() => HomeScreenState();

}

class HomeScreenState extends State<HomeScreen>{

  late OdooUser user;

  late Flushbar message = Flushbar(
      title: AppLocalizations.of(context)!.translate('missingDataTitle'),
      message: AppLocalizations.of(context)!.translate('missingData'),
      isDismissible: false,
      flushbarPosition: FlushbarPosition.BOTTOM,
      onTap: (flush){
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => const UserScreen()));
      }
  );

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(milliseconds: 500), (){
      if(user.isMissingData()){
        message.show(context);
      }else{
        message.dismiss();
      }
    });
    return BlocBuilder<UserBloc, UserStates>(builder: (context, state) {
      if (state is UpdateState) {
        user = state.user;
      } else {
        user = OdooUser("Default", "password", false, "Default", Language.enUS);
      }

      return Scaffold(
        appBar: AppBar(
          title: Text(AppLocalizations.of(context)!.translate('home')),
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
                } else if (result == 'Geolocalización') {
                  Location().getCurrentLocation();
                }
              },
              itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                PopupMenuItem<String>(
                  value: 'Editar usuario',
                  child:
                  Text(AppLocalizations.of(context)!.translate('editUser')),
                ),
                PopupMenuItem<String>(
                  value: 'Cambiar de usuario',
                  child: Text(
                      AppLocalizations.of(context)!.translate('switchUser')),
                ),
                PopupMenuItem<String>(
                  value: 'Cerrar sesión',
                  child:
                  Text(AppLocalizations.of(context)!.translate('logout')),
                ),
                PopupMenuItem<String>(
                  value: 'Idioma',
                  child:
                  Text(AppLocalizations.of(context)!.translate('language')),
                ),
                PopupMenuItem<String>(
                  value: 'Geolocalización',
                  child:
                  Text(AppLocalizations.of(context)!.translate('location')),
                ),
              ],
            ),
          ],
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    AppLocalizations.of(context)!.translate('welcomeText'),
                    style: TextStyle(fontSize: 24),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    ' ${user.getEmail()}',
                    style: TextStyle(fontSize: 24),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              Text(
                AppLocalizations.of(context)!.translate('welcomeText2'),
                textAlign: TextAlign.center,
              ),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(AppLocalizations.of(context)!.translate('useMenu'),
                        textAlign: TextAlign.center),
                    Icon(Icons.more_vert),
                    Text(AppLocalizations.of(context)!.translate('useMenu2'),
                        textAlign: TextAlign.center),
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