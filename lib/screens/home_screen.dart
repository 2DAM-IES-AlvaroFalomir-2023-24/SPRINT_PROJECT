import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sprint/bloc/bloc_user/user_bloc.dart';
import 'package:sprint/bloc/bloc_user/user_state.dart';
import 'package:sprint/model/odoo-user.dart';
import 'package:sprint/screens/user_screen.dart';
import 'package:sprint/widget/custom_elevated_button_iconified.dart';
import 'package:sprint/app_localizations.dart';
import 'package:sprint/model/language.dart';
import 'login_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<StatefulWidget> createState() => HomeScreenState();

}

class HomeScreenState extends State<HomeScreen>{

  late OdooUser user;

  late Flushbar message = Flushbar(
      title: AppLocalizations.of(context)!.translate('missingDataTitle'),
      message: AppLocalizations.of(context)!.translate('missingDataContent'),
      isDismissible: false,
      flushbarPosition: FlushbarPosition.BOTTOM,
      onTap: (flush) {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => const UserScreen()));
      }
  );

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserStates>(builder: (context, state) {
      if (state is UpdateState) {
        user = state.user;
      } else {
        user = OdooUser("Default", "password", false, "Default", Language.enUS);
      }

      Future.delayed(const Duration(milliseconds: 500), (){
        if(user.isMissingData() && !message.isShowing()){
          message.show(context);
        }
      });
      Future.delayed(const Duration(milliseconds: 2000), (){
        if(!user.isMissingData()){
          message.dismiss();
        }
      });

      return Scaffold(
        appBar: AppBar(
          title: Image.asset("assets/odoo_logo.png", scale: 8),
          centerTitle: true,
          automaticallyImplyLeading: false
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(bottom:80.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          AppLocalizations.of(context)!.translate('welcomeText'),
                          style: TextStyle(fontSize: 24),
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          ' ${user.name}',
                          style: TextStyle(fontSize: 24),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                    Text(
                        AppLocalizations.of(context)!.translate('welcomeText2'),
                        textAlign: TextAlign.center
                    )
                  ],
                ),
              ),
              Wrap(
                spacing: 25.0,
                runSpacing: 25.0,
                alignment: WrapAlignment.spaceEvenly,
                children: [
                  CustomElevatedButtonIconified(
                    icon: const Icon(Icons.logout),
                    onPressedFunction: (){
                      //TODO Llamar a la función de Cerrar sesión (Alexandra)
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => const LoginScreen()));
                    },
                    hintText: AppLocalizations.of(context)!.translate('logout')
                  ),
                  CustomElevatedButtonIconified(
                    icon: const Icon(Icons.language),
                    onPressedFunction: (){
                      //TODO Llamar a la función de Idioma (Pinto)
                    },
                    hintText: AppLocalizations.of(context)!.translate('language')
                  ),
                  CustomElevatedButtonIconified(
                    icon: const Icon(Icons.location_pin),
                    onPressedFunction: (){
                      //TODO Llamar a la función de Geolocalización (Carol)
                    },
                    hintText: AppLocalizations.of(context)!.translate('location')
                  ),
                  CustomElevatedButtonIconified(
                    icon: const Icon(Icons.change_circle),
                    onPressedFunction: (){
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => const LoginScreen()));
                    },
                    hintText: AppLocalizations.of(context)!.translate('switchUser')
                  ),
                  CustomElevatedButtonIconified(
                    icon: const Icon(Icons.edit),
                    onPressedFunction: (){
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => const UserScreen()));
                    },
                    hintText: AppLocalizations.of(context)!.translate('editUser')
                  )
                ]
              )
            ]
          )
        )
      );
    });
  }
}